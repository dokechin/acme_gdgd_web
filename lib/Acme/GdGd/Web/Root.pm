package Acme::GdGd::Web::Root;
use Mojo::Base 'Mojolicious::Controller';
use utf8;
use File::stat;
sub index {


  my $self = shift;
  my $stat = stat('./access.txt');

  if ($stat->atime + 24*60*60 < time){
      $self->render(
        message => 'グダグダ言ってないでコード書けよ。ハゲ！!' );
  }
  else{
      $self->render(
        message => 'グダグダ言ってないでコード書いてるね。ナイスガイ！!');
  }
}

sub webhook {
  my $now = time;
  utime $now, $now, "./access.txt";
 
}

sub login {
    my $self = shift;
    my $url = $self->url_for("https://github.com/login/oauth/authorize");
    $self->redirect_to($url->query(client_id => $self->app->config->{client_id},
     redirect_url=>$self->app->config->{redirect_url}));
}
1;