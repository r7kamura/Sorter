package Sorter;
use strict;
use warnings;

sub new {
  bless { values => [] }, shift;
}

sub set_values {
  my $self = shift;
  $self->{values} = [@_];
  $self;
}

sub get_values {
  @{shift->{values}};
}

sub sort {
  my $self = shift;
  my @values = $self->get_values;
  return $self if @values <= 1;
  
  my $pivot = splice(@values, int(@values / 2), 1);
  my (@lvals, @rvals);
  for my $value (@values) {
    ($value < $pivot) ? push(@lvals, $value) : push(@rvals, $value);
  }
  my $l = __PACKAGE__->new;
  my $r = __PACKAGE__->new;
  $self->set_values(
    $l->set_values(@lvals)->sort->get_values,
    $pivot,
    $r->set_values(@rvals)->sort->get_values
  );
}

1;
