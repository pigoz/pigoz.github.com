---
layout: post
title: Blog moved to jekyll and github!
author: Stefano Pigozzi
date: 2010-12-09
tags: blog jekyll
---
 
I just ditched my old and boring [Wordpress.com blog](http://wordpress.com/pigoz) in favor of a solution powered by [Jekyll](https://github.com/mojombo/jekyll). I can finally just write stuff in markdown and have my articles versioned and deployed with git push.

The full source for this blog is available on [GitHub](https://github.com/pigoz/pigoz.github.com). There are quite some customizations that are worth mentioning:

-   Getting comments outsourced to [Disqus](http://disqus.com/) was easy as a pie.
-   Building a sensible tag support was somewhat tricky. The tagcloud and the tags pages are built via some Rake tasks before deploy.
-   CSS written using [SASS](http://sass-lang.com/) and translated with a Rake task before deploy.

Jekyll and GitHub Pages will serve any static file unchanged. So if you have any kind of content that is impossible to generate with Liquid templates you can just generate it with pure Ruby. For some examples take a peek at [my Rakefile](https://github.com/pigoz/pigoz.github.com/blob/master/Rakefile).

The downside of this approach is you are polluting your project's repository with generated content, but its pretty much the only way to create complex stuff like a tag cloud.