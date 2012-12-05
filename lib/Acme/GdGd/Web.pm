package Acme::GdGd::Web;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Router
  my $r = $self->routes;

  $r->post('/webhook')->to('Root#webhook');
  $r->get('/')->to('Root#index');
}

1;
