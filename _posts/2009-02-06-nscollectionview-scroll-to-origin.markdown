---
layout: post
title: Monkeypatch scroll to top when resizing an NSCollectionView
tags: cocoa macosx jekyll
---

As you know Leopard has this new amazing facility to present complex data on screen. NSCollectionView allows you to lay out some NSViews each representing your data, whereas NSTableView supports only NSCells out of the box.

Anyway if you are thinking about using a NSCollectionView you will be disappointed to discover that the current implementation is very buggy. As pointed out in the linked posts whenever you resize a containing NSWindow the contained NSCollectionView will scroll to its origins (provided that you actually have springed the NSCollectionView to the window).


Fortunately, fixing the "scroll to origin" misbehavior is pretty easy. All you need to do is a NSWindow subclass implementing two delegate methods.

In the interface define an outlet that you will bind to the NSScrollView containing the NSCollectionView you want to resize properly. Moreover define an NSPoint to store the original position of the NSCollectionView in the NSScrollView.

{% highlight objc %}
@interface PGZWindow : NSWindow {

	IBOutlet NSScrollView * scrollView;
	NSPoint pos;

}

@property (retain) IBOutlet NSScrollView * scrollView;
- (void)windowDidResize:(NSNotification *)notification;
- (NSSize)windowWillResize:(NSWindow *) window toSize:(NSSize)newSize;

@end
{% endhighlight %}

In the implementation you just store the position before the resize, and set it after the resize is completed. Note that you need to set the delegate to _self_ or _windowDidResize:_ will not be called (the mysteries of cocoa...). Here's the implementation:

{% highlight objc %}
@implementation PGZWindow
@synthesize scrollView;

- (void) awakeFromNib
{
	[self setDelegate:self];
}

- (NSSize)windowWillResize:(NSWindow *) window toSize:(NSSize)newSize
{
	NSPoint new_pos = [[scrollView contentView] bounds].origin;
	if(new_pos.x > 0.0 || new_pos.y > 0.0){
		self->pos = new_pos;
	}
}

- (void)windowDidResize:(NSNotification *)notification
{
	NSPoint new_pos = [[scrollView contentView] bounds].origin;
	if(new_pos.x > 0.0 || new_pos.y > 0.0){
		self->pos = new_pos;
	} else {
		[[scrollView contentView] scrollToPoint:self->pos];
		[scrollView reflectScrolledClipView: [scrollView contentView]];
	}
	self->pos = NSMakePoint(0.0, 0.0);
}

@end
{% endhighlight %}

Cheers :)