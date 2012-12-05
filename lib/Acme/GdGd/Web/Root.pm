package Acme::GdGd::Web::Root;
use Mojo::Base 'Mojolicious::Controller';
use utf8;
use File::stat;
sub index {

  my $self = shift;
  my $stat = stat('./access.txt');

  if ($stat->atime + 24*60*60 < time){
      $self->render(
        message => 'グダグダ言ってないでコード書けよ。ハゲ！!');
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
1;