package Gentein;
use Mojo::Base 'Mojolicious';
use Schema;

has schema => sub {
  return Schema->connect('dbi:SQLite:' . ($ENV{MOJO_DB} || 'share/schema.db'));
};

# This method will run once at server start
sub startup {
  my $self = shift;

  $self->helper(db => sub { $self->app->schema });

  # Routes
  my $r = $self->routes;

  $r->get('/')->to('home#index');

  
}

1;
