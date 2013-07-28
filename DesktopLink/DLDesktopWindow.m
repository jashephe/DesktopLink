//
//  DLDesktopWindow.m
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import "DLDesktopWindow.h"

@interface DLDesktopWindow ()
@property NSView *actualContentView;
@end

@implementation DLDesktopWindow

- (id)initWithContentRect:(NSRect)contentRect backing:(NSBackingStoreType)bufferingType defer:(BOOL)deferCreation {
	self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:bufferingType defer:deferCreation];
	if (self) {
		[self setOpaque:NO];
		[self setBackgroundColor:[NSColor clearColor]];
		[self setHasShadow:NO];
		[self setLevel:(NSNormalWindowLevel - 1)];
		[self setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];
		
		NSRect bounds = [self frame];
		bounds.origin = NSZeroPoint;
		DLTransparentWindowFrame *frameView = [[DLTransparentWindowFrame alloc] initWithFrame:bounds];
		[super setContentView:frameView];
		[self setContentView:[[NSView alloc] initWithFrame:bounds]];
	}
	return self;
}

- (void)reallyCenter {
	[self setFrameOrigin:NSMakePoint([[NSScreen mainScreen] frame].size.width/2.0f - [self frame].size.width/2.0f, [[NSScreen mainScreen] frame].size.height/2.0f - [self frame].size.height/2.0f)];
}

# pragma mark Borderless Window Fixes

// Without this, controls in the window cannot become active.
- (BOOL)canBecomeKeyWindow {
	return YES;
}

# pragma mark Content View Faking

// Change the actual content view, and then insert it into the background view.
- (void)setContentView:(NSView *)theContentView {
	if ([self.actualContentView isEqualTo:theContentView])
		return;
	
	NSRect bounds = [self frame];
	bounds.origin = NSZeroPoint;
	DLTransparentWindowFrame *frameView = (DLTransparentWindowFrame *)[super contentView];
	
	if (self.actualContentView)
		[self.actualContentView removeFromSuperview];
	self.actualContentView = theContentView;
	[self.actualContentView setFrame:bounds];
	[self.actualContentView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
	[frameView setSubviews:@[self.actualContentView]];
}

- (NSView *)contentView {
	return self.actualContentView;
}

@end

# pragma mark -
# pragma mark Window Background

@implementation DLTransparentWindowFrame

#define WINDOW_CORNER_RADIUS	 10.0f
#define BACKGROUND_COLOR [NSColor colorWithCalibratedWhite:0.5 alpha:0.2]
#define SHADOW_THICKNESS 10.0f

- (void)drawRect:(NSRect)dirtyRect {
	NSRect drawingRect = [self bounds];
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:drawingRect xRadius:WINDOW_CORNER_RADIUS yRadius:WINDOW_CORNER_RADIUS];
	
	NSBezierPath *shadowPath = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(drawingRect, -SHADOW_THICKNESS/2 - 1, -SHADOW_THICKNESS/2 - 1) xRadius:WINDOW_CORNER_RADIUS yRadius:WINDOW_CORNER_RADIUS];
	
	[BACKGROUND_COLOR set];
	[path fill];
	
	[[NSGraphicsContext currentContext] saveGraphicsState];
	
	[path addClip];
	
	NSShadow * shadow = [[NSShadow alloc] init];
	[shadow setShadowColor:[NSColor colorWithCalibratedWhite:0.1f alpha:0.8f]];
	[shadow setShadowBlurRadius:SHADOW_THICKNESS];
	[shadow set];
	
	[[NSColor blackColor] set];
	[shadowPath setLineWidth:SHADOW_THICKNESS];
	[shadowPath stroke];
	
	[[NSGraphicsContext currentContext] restoreGraphicsState];
}

@end
