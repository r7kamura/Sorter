package Sorter;
use strict;
use warnings;

sub new {
  my $class = shift;
  my $self = {
    values => []
  };
  bless $self, $class;
}

sub set_values {
  my $self = shift;
  $self->{values} = [@_];
}

sub get_values {
  my $self = shift;
  @{$self->{values}};
}

sub sort {
  my $self = shift;
  return if $self->get_values <= 1;
  
  my $pivot = $self->_pivot;
  my (@lvals, @rvals);
  for my $value ($self->get_values) {
    ($value < $pivot) ? push(@lvals, $value) : push(@rvals, $value);
  }
  my $l = __PACKAGE__->new;
  my $r = __PACKAGE__->new;
  $l->set_values(@lvals);
  $r->set_values(@rvals);
  $l->sort;
  $r->sort;
  $self->set_values($l->get_values, $pivot, $r->get_values);
}

sub _pivot {
  my $self = shift;
  my @values = $self->get_values;
  my $pivot = splice(@values, int(@values/2), 1);
  $self->set_values(@values);
  $pivot;
}

1;
