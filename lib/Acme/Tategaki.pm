package Acme::Tategaki;
use 5.008005;
use strict;
use warnings;
use utf8;

use parent 'Exporter';

use Array::Transpose;
use List::Util qw(max);
use Encode qw/decode_utf8 encode_utf8/;
our @EXPORT = qw( tategaki );

our $VERSION = "0.07";

my @punc             = qw(、 。 ， ．);
my @horizontal_words = qw(ー 「 」 → ↑ ← ↓ ＝ );
my @vertical_words   = qw(｜ ¬ ∟ ↓ → ↑ ← ॥ );
my %replace_words = map {$horizontal_words[$_] => $vertical_words[$_]} (0..$#horizontal_words);

sub tategaki {
    my @text = @_;
    return unless scalar @text;
    my $text = join '　', map{decode_utf8 $_} @text;

    while (my($key, $value) = each %replace_words) {
        $text =~ s/$key/$value/g;
    }
    $text =~ s/$_\s?/$_　/g for @punc;

    # vertical forms (FE10 to FE19)
    $text =~ s/,/︐/go;
    $text =~ s/、/︑/go;
    $text =~ s/。/︒/go;
    $text =~ s/：/︓/go;
    $text =~ s/；/︔/go;
    $text =~ s/！/︕/go;
    $text =~ s/？/︖/go;
    $text =~ s/〖/︗/go;
    $text =~ s/〗/︘/go;
    $text =~ s/…/︙/go;

    @text = split /\s/, $text;
    my $max_lengh =  max map {length $_} @text;
    @text = map{$_ . ('　' x ($max_lengh - length $_))} @text;
    @text = map {[split //, $_]} @text;
    @text = transpose([@text]);
    @text = map{encode_utf8 $_} map {join '　', reverse @$_} @text;
    return wantarray ? @text : join "\n", @text;
}

if ( __FILE__ eq $0 ) {

    my $text = Acme::Tategaki::tategaki("お前は、すでに、死んでいる。");
    warn $text, "\n";
    my @text = Acme::Tategaki::tategaki("お前は、すでに、死んでいる。");
    warn $_, "\n" for @text;

    $text = tategaki("お前は、すでに、死んでいる。");
    warn $text, "\n";
    @text = tategaki("お前は、すでに、死んでいる。");
    warn $_, "\n" for @text;
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
    い　、　、
    る
    。

=head1 DESCRIPTION

Acme::Tategaki makes a text vertically.

=head1 AUTHOR

Kazuhiro Homma E<lt>kazuph@cpan.orgE<gt>

=head1 DEPENDENCIES

L<Array::Transpose>

=head1 SEE ALSO

L<flippy|https://rubygems.org/gems/flippy>

=head1 LICENSE

Copyright (C) Kazuhiro Homma.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

