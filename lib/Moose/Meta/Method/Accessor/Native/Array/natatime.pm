package Moose::Meta::Method::Accessor::Native::Array::natatime;

use strict;
use warnings;

use List::MoreUtils;

our $VERSION = '1.14';
$VERSION = eval $VERSION;
our $AUTHORITY = 'cpan:STEVAN';

use base 'Moose::Meta::Method::Accessor::Native::Reader';

sub _minimum_arguments {1}

sub _maximum_arguments {2}

sub _inline_check_arguments {
    my $self = shift;

    return $self->_inline_throw_error(
        q{'The n value passed to natatime must be an integer'})
        . ' unless defined $_[0] && $_[0] =~ /^\\d+$/;' . "\n"
        . $self->_inline_throw_error(
        q{'The second argument passed to natatime must be a code reference'})
        . q{ if defined $_[1] && ( ref $_[1] || q{} ) ne 'CODE';};
}

sub _inline_return_value {
    my ( $self, $slot_access ) = @_;

    return
        "my \$iter = List::MoreUtils::natatime( \$_[0], \@{ $slot_access } );"
        . "\n"
        . 'if ( $_[1] ) {' . "\n"
        . 'while (my @vals = $iter->()) {' . "\n"
        . '$_[1]->(@vals);' . "\n" . '}' . "\n"
        . '} else {' . "\n"
        . 'return $iter;' . "\n" . '}';
}

1;
