package Acme::GdGd::Web;
use Mojo::Base 'Mojolicious';
use Acme::GdGd::DB;

# This method will run once at server start
sub startup {
  my $self = shift;

  my $config = $self->plugin('Config', { file => 'acme_gdgd.conf' }); # ’Ç‰Á
  $self->attr( db => sub { Acme::GdGd::DB->new( $config->{db} ) } ); # ’Ç‰Á

  # Router
  my $r = $self->routes;

  $r->post('/webhook/:key')->to('Root#webhook');
  $r->get('/')->to('Root#index');
  # have not implemented yet
  $r->get('/login')->to('Root#login');
  $r->get('/callback')->to('Root#callback');

}

1;
