use strict;
use Test::Base::Less;
use Acme::Tategaki;

filters {
    expected => [ qw/chomp/ ],
};

for my $block (blocks) {
    is( scalar tategaki($block->input), $block->expected );
}

done_testing;

__DATA__

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
お前は、すでに、死んでいる。
--- expected
死　す　お
ん　で　前
で　に　は
い　︑　︑
る　　　　
︒　　　　
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
