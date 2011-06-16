---
layout: post
title: Getting started with ANTLR3 and Ruby
author: Stefano Pigozzi
date: 2011-06-16
tags: antlr ruby
---

Today I just started reading [The definitive ANTLR reference](http://pragprog.com/titles/tpantlr/the-definitive-antlr-reference) and I noticed in the first chapter that you can target ruby code. Of course I HAD to try it even if I'm such a big noob with ANTLR :)

This small article will focus to reproduce the test grammar from the first chapter (1.4	Executing ANTLR and Invoking Recognizers).

Install the ANTLR3 gem by running the usual `gem install antlr3`. This gem bundles the antlr jar so you are good to go (you need a jvm actually as a prerequisite). You can now create your simple grammar just like in the book:

{% highlight antlr %}
grammar T;
options { language = Ruby; }

r : 'call' ID ';' {puts "invoked: #{$ID}"} ;
ID: 'a'..'z'+ ;
WS: (' '|'\r'|'\n') {$channel=HIDDEN;} ;
{% endhighlight %}

Now you can run `antlr4ruby T.g` and the Lexer and Parser will be generated for you. To try it out create a script (I called it runner.rb) along the lines of:
{% highlight ruby %}
$: << File.dirname(__FILE__)
require 'TLexer'
require 'TParser'

T::Parser.new(T::Lexer.new(STDIN)).r
{% endhighlight %}

Create a source file `echo "call foo;" > source` and you can finally test it with `ruby runner.rb < source`.

Have fun.
