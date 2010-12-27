---
layout: post
title: Temporary Core Animation
author: Stefano Pigozzi
date: 2009-02-09
tags: cocoa macosx
---
Working on my project I used Core Animation for the first time. Unfortunately layer-backed views don’t work well with some Cocoa controls (such as NSTextField and NSButton with check style). Luckyly I only need Core Animation to set up some NSView replacing and NSWindow scaling transitions.


For this reason I started to research a way to turn on layer backing before the animation starts and turn it off as soon as it ends. Since I didn’t find much information about it I wrote this post to sum it up. Here is some source code:

{% highlight objc %}
-(IBAction) trigger:(id) sender
{
	[[mainWindow contentView] setWantsLayer:YES];
	[NSTimer scheduledTimerWithTimeInterval:.2 target:self 
			 selector:@selector(doAnimation) userInfo:nil repeats:NO];

}
-(void)doAnimation
{
	[NSAnimationContext beginGrouping];
	// do your transition here
	[NSAnimationContext endGrouping];
	[NSTimer scheduledTimerWithTimeInterval:.1 target:self
			 selector:@selector(finishAnimation) userInfo:nil repeats:NO];

}
-(void)finishAnimation
{
	[[mainWindow contentView] setWantsLayer:NO];
}
{% endhighlight %}

## UPDATE:
Alejandro pointed out a better solution which doesn't use timers. Please take a look at his comment.