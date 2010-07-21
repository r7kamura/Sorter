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
  
  return if $self->get_values < 1;
  
  my $pivot = $self->_pivot;
  my $left = __PACKAGE__->new;
  my $right = __PACKAGE__->new;
  $left->set_values($self->_partition($pivot, -1));
  $right->set_values($self->_partition($pivot, 1));
  $left->sort;
  $right->sort;
  $self->set_values($left->get_values, $pivot, $right->get_values);
}

sub _partition {
  my ($self, $pivot, $comp) = @_;
  
  if ($comp < 0) {
    grep { $_ < $pivot } $self->get_values;
  }
  else {
    grep { $_ >= $pivot } $self->get_values;
  }
}

sub _pivot {
  my $self = shift;
  my @values = $self->get_values;
  my $pivot = shift @values;
  $self->set_values(@values);
  $pivot;
}

1;