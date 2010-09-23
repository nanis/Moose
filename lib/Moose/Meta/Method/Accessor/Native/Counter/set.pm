package Moose::Meta::Method::Accessor::Native::Counter::set;

use strict;
use warnings;

our $VERSION = '1.14';
$VERSION = eval $VERSION;
our $AUTHORITY = 'cpan:STEVAN';

use base 'Moose::Meta::Method::Accessor::Native::Writer';

sub _minimum_arguments {1}
sub _maximum_arguments {1}

sub _potential_value {'$_[0]'}

sub _inline_optimized_set_new_value {
    my ( $self, $inv, $new, $slot_access ) = @_;

    return "$slot_access = \$_[0];";
}

1;
