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
  my @array = $self->get_values;
  $self->_quick_sort(0, $#array) if ($#array) > 0;
}

sub _quick_sort {
  my $self = shift;
  my ($left, $right) = @_;
  
  if ($left < $right) {
    my ($i, $j) = ($left, $right);
    my $array = $self->{values};
    my $center = int(($left + $right) / 2);
    my $pivot = $array->[$center];
    
    while (1) {
      $i++ while($array->[$i] < $pivot);
      $j-- while($array->[$j] > $pivot);
      last if ($i >= $j);
      $self->_swap($i, $j);
      $i++; $j--;
    }
    
    $self->_quick_sort($left, $i - 1)  if ($left < $i-1);
    $self->_quick_sort($j + 1, $right) if ($j+1 < $right);
  }
}

sub _swap {
  my $self = shift;
  my ($i, $j) = @_;
  my $array = $self->{values};
  my $tmp = $array->[$i];
  $array->[$i] = $array->[$j];
  $array->[$j] = $tmp;
}

1;