package Acme::GdGd::Web::Root;
use Mojo::Base 'Mojolicious::Controller';
use utf8;
use File::stat;
use String::Random;
require LWP::UserAgent;
use JSON qw/encode_json decode_json/;
use Data::Dumper;


sub index {


  my $self = shift;
  my $stat = stat('./access.txt');
  my $user = $self->session('user');

  if ($stat->atime + 24*60*60 < time){
      $self->render(
        message => 'グダグダ言ってないでコード書けよ。'. $user . '！!' );
  }
  else{
      $self->render(
        message => 'グダグダ言ってないでコード書いてるね。'. $user . '！!' );
  }
}

sub webhook {
  my $now = time;
  utime $now, $now, "./access.txt";
 
}

sub login {
    my $self = shift;
#    my $state = String::Random->new->randregex('[A-Za-z0-9]{32}');
    my $url = $self->url_for("https://github.com/login/oauth/authorize");
    $self->redirect_to($url->query(client_id => $self->app->config->{client_id},
     redirect_url=>$self->app->config->{redirect_uri},
     ));
#    $self->session(state=>$state);
}

sub callback{

    my $self = shift;

    my $code = $self->param('code');
#    my $callback_state = $self->param('state');
#    my $state = $self->session('state');
#    $self->session(expires => 1);
#    if ($state ne $callback_state){
#        $self->redirect_to('/');
#    }
    
 
    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    my $response = $ua->post('https://github.com/login/oauth/access_token',
      {client_id =>$self->app->config->{client_id},
      redirect_uri =>$self->app->config->{redirect_uri},
      client_secret =>$self->app->config->{client_secret},
      code => $code}
      );

    if ($response->is_success){
      if ($response->content =~ /^(access_token=)(.*)(&)/) {
          my $access_token=$2;

          my $response = $ua->get('https://api.github.com/user?access_token='. $access_token);
          my $json = decode_json($response->content);
          my $user = $json->{'login'};
          
          
          my $row = $self->app->db->single('User',{user=>$user});
          print Dumper($row);
          if (!defined $row){
              my $key = String::Random->new->randregex('[A-Za-z0-9]{32}');
              $self->app->db->insert('User',{user=>$user, key=>$key});
          }

          $self->session(user=>$user);
          $self->session(access_token=>$access_token);

          $self->redirect_to('/');
      }
      else{
          $self->redirect_to('/');
      }
    }
    else{
      $self->redirect_to('/');
    }


}

1;