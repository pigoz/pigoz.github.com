---
layout: post
title: Compile mplayer.git on MacOSX
author: Stefano Pigozzi
date: 2009-09-09
tags: mplayer macosx
---

In this post I will explain how I am compiling mplayer on Mac OSX Leopard using the Uoti's mplayer fork build script. The script automates all the build process of ffmpeg, mplayer and libass. It is better than my previous method because it includes automatically the most recent version of libass (the one coming with mplayer is ancient).

First you need to install a couple of dependencies, you could compile them manually but it is not worth the hassle. Use MacPorts instead.

{% highlight bash %}
sudo port install git-core autoconf automake libtool pkgconfig freetype fontconfig libiconv ncurses zlib lzo2 libpng
{% endhighlight %}

As you see among other stuff you have installed autotools. These are needed to perform an autoreconf on libass' source code.

Now make sure your MacPorts bin directory is at the start of your PATH, this will override the automake and autoconf shipping with Leopard. Your last .bash_profile line should look something like this:

{% highlight bash %}
export PATH=/opt/local/bin:/opt/local/sbin:${PATH}
{% endhighlight %}

Download the build scripts:

{% highlight bash %}
git clone git://repo.or.cz/mplayer-build.git
{% endhighlight %}

To launch the build script you do not use the usual ./configure && make && make install, read the README for more information on how the scripts work.

Download the source code for ffmpeg, libass and mplayer, and enable multithreading in ffmpeg:

{% highlight bash %}
cd mplayer-build
./init
./enable-mt
{% endhighlight %}

Now you need to edit some configuration file or the compilation will fail. First you need to add

{% highlight bash %}
--cc=gcc-4.2
{% endhighlight %}

to the common_options file (this should be optional on Snow Leopard since it comes with gcc4.2 as default compiler).

Add

{% highlight bash %}
--disable-x11
--disable-gl
--disable-mencoder
{% endhighlight %}

to the mplayer_options file.

Add

{% highlight bash %}
--enable-encoder=png
{% endhighlight %}

to ffmpeg_options file if you want to take screenshots with the MplayerOSX Extended GUI.

You need to remove '--cpu=native', from script/ffmpeg-config and if you are on a core2 or core2duo add '--cpu=core2',.

Now you are ready to compile everything, just run:

{% highlight bash %}
export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig"
make
{% endhighlight %}

The build script will take care of compiling ffmpeg, libass, mplayer and then linking them together.
After you are done you should find your mplayer executable in the mplayer subdirectory.

To use your newly compiled mplayer with the MPlayerOSX Extended GUI:

{% highlight bash %}
cd mplayer
sudo cp mplayer /Applications/MPlayer\ OSX\ Extended.app/Contents/Resources/External_Binaries/mplayer.app/Contents/MacOS/mplayer
{% endhighlight %}

That's all folks! Enjoy.

## NOTICE: You can find more updated version of this guide [on this wiki page](http://code.google.com/p/mplayerosx-builds/wiki/Compiling)