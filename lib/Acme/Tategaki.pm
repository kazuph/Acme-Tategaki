package Acme::Tategaki;
use 5.008005;
use strict;
use warnings;
use utf8;

use Array::Transpose::Ragged qw/transpose_ragged/;
use Encode qw/decode_utf8 encode_utf8/;

use parent 'Exporter';
our @EXPORT = qw( tategaki );

our $VERSION = "0.09";

my @punc = qw(、 。 ， ．);

sub tategaki {
    my @text = @_;
    return unless scalar @text;
    my $text = join '　', map { decode_utf8 $_} @text;

    $text =~ s/$_\s?/$_　/g for @punc;
    $text =~ tr/ー「」→↑←↓＝,、。〖〗…/｜¬∟↓→↑←॥︐︑︒︗︘︙/;
    @text = split /\s/, $text;

    @text = map { [ split //, $_ ] } @text;
    @text = transpose_ragged( \@text );
    @text = map { [ map {$_ || '　' } @$_ ] } @text;
    @text = map { encode_utf8 $_} map { join '　', reverse @$_ } @text;
    return wantarray ? @text : join "\n", @text;
}

1;

__END__

=encoding utf-8

=head1 NAME

Acme::Tategaki - This Module makes a text vertically.

=head1 SYNOPSIS

    $ perl -MAcme::Tategaki -e 'print scalar tategaki("お前は、すでに、死んでいる。")'
    死　す　お
    ん　で　前
    で　に　は
    い　︑　︑
    る　　　　
    ︒　　　　

=head1 DESCRIPTION

Acme::Tategaki makes a text vertically.

=head1 AUTHOR

Kazuhiro Homma E<lt>kazuph@cpan.orgE<gt>

=head1 DEPENDENCIES

L<Array::Transpose>, L<Array::Transpose::Ragged>

=head1 SEE ALSO

L<flippy|https://rubygems.org/gems/flippy>

=head1 LICENSE

Copyright (C) Kazuhiro Homma.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

