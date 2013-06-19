use strict;
use Test::Base::Less;
use Acme::Tategaki;
use Encode;
use utf8;

filters {
    expected => [ qw/chomp/ ],
};

for my $block (blocks) {
    is( scalar tategaki(map {decode_utf8 $_} $block->input), decode_utf8 $block->expected );
}

done_testing;

__DATA__

===
--- input
ほげ、ふが。ほげ→
--- expected
ほ　ふ　ほ
げ　が　げ
↓　︒　︑
===
--- input
cpan
--- expected
c
p
a
n
===
--- input
ほげ
--- expected
ほ
げ
===
--- input
お前は、すでに、死んでいる。からね。
--- expected
か　死　す　お
ら　ん　で　前
ね　で　に　は
︒　い　︑　︑
　　る　　　　
　　︒　　　　
===
--- input
お前は，すでに，死んでいる．んだからさ．
--- expected
ん　死　す　お
だ　ん　で　前
か　で　に　は
ら　い　，　，
さ　る　　　　
．　．　　　　
===
--- input
お前は，すでに，死んでいる．
--- expected
死　す　お
ん　で　前
で　に　は
い　，　，
る　　　　
．　　　　
===
--- input
お前は　すでに　死んでいる
--- expected
死　す　お
ん　で　前
で　に　は
い　　　　
る　　　　
===
--- input
お前は すでに 死んでいる
--- expected
死　す　お
ん　で　前
で　に　は
い　　　　
る　　　　
===
--- input
,
--- expected
︐
===
--- input
、
--- expected
︑
===
--- input
。
--- expected
︒
===
--- input
〖
--- expected
︗
===
--- input
〗
--- expected
︘
===
--- input
…
--- expected
︙
===
--- input
ー
--- expected
｜
===
--- input
「
--- expected
¬
===
--- input
」
--- expected
∟
===
--- input
→
--- expected
↓
===
--- input
↑
--- expected
→
===
--- input
←
--- expected
↑
===
--- input
↓
--- expected
←
===
--- input
＝
--- expected
॥
===
--- input
=
--- expected
॥
