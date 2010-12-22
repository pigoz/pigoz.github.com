---
layout: post
title: Blog moved to jekyll and github!
tags: blog jekyll
---
 
I just ditched my old and boring [Wordpress.com blog](http://wordpress.com/pigoz) in favor of a solution powered by [Jekyll](https://github.com/mojombo/jekyll). I can finally just write stuff in markdown and have my articles versioned and deployed with git push.

The full source for this blog is available on [GitHub](https://github.com/pigoz/pigoz.github.com). There are quite some customizations that are worth mentioning:

-   Getting comments outsourced to [Disqus](http://disqus.com/) was easy as a pie.
-   Building a sensible tag support was somewhat tricky. The tagcloud and the tags pages are built via some Rake tasks before deploy.
-   CSS written using [SASS](http://sass-lang.com/) and translated with a Rake task before deploy.

In general everything that you want to compute using Ruby has to be precomputed before pushing to GitHub. The most brilliant feature of jekyll is that it adds static files in your project root to the deployed site, so you can pre generate them locally on shared services such as GitHub Pages.