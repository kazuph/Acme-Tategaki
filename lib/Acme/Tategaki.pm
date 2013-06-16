package Acme::Tategaki;
use 5.008005;
use strict;
use warnings;
use utf8;
use Array::Transpose;
use List::Util qw(max);
use Encode qw/decode_utf8 encode_utf8/;

our $VERSION = "0.04";

my @punc             = qw(、 。 ， ．);
my @horizontal_words = qw(ー 「 」 → ↑ ← ↓ ＝ …);
my @vertical_words   = qw(｜ ¬ ∟ ↓ → ↑ ← ॥ ：);
my %replace_words = map {$horizontal_words[$_] => $vertical_words[$_]} (0..$#horizontal_words);

sub tategaki {
    my $self = shift;
    my @text = @_;
    return unless scalar @text;
    my $text = join '　', map{decode_utf8 $_} @text;

    while (my($key, $value) = each %replace_words) {
        $text =~ s/$key/$value/g;
    }
    $text =~ s/$_\s?/$_　/g for @punc;
    @text = split /\s/, $text;
    my $max_lengh =  max map {length $_} @text;
    @text = map{$_ . ('　' x ($max_lengh - length $_))} @text;
    @text = map {[split //, $_]} @text;
    @text = transpose([@text]);
    @text = map {join '　', reverse @$_} @text;
    print encode_utf8 $_, "\n" for @text;
}

if ( __FILE__ eq $0 ) {
    tategaki();
}

1;

__END__

=encoding utf-8

=head1 NAME

Acme::Tategaki - It makes a text vertically.

=head1 SYNOPSIS

    $ perl -MAcme::Tategaki -e 'print Acme::Tategaki->tategaki("お前は、すでに、死んでいる。")'
    死　す　お
    ん　で　前
    で　に　は
    い　、　、
    る
    。

=head1 DESCRIPTION

Acme::Tategaki makes a text vertically.

=head1 LICENSE

Copyright (C) Kazuhiro Homma.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Kazuhiro Homma E<lt>kazuph@cpan.orgE<gt>

=head1 DEPENDENCIES

L<Array::Transpose>

=head1 SEE ALSO

L<flippy|https://rubygems.org/gems/flippy>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

