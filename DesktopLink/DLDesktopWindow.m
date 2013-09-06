//
//  DLDesktopWindow.m
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import "DLDesktopWindow.h"

@interface DLDesktopWindow ()

@end

@implementation DLDesktopWindow

- (id)initWithContentRect:(NSRect)contentRect backing:(NSBackingStoreType)bufferingType defer:(BOOL)deferCreation {
	self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:bufferingType defer:deferCreation];
	if (self) {
		[self setOpaque:NO];
		[self setBackgroundColor:[NSColor clearColor]];
		[self setHasShadow:NO];
		[self setMovable:NO];
		[self setLevel:(NSNormalWindowLevel - 1)];
		[self setCollectionBehavior:NSWindowCollectionBehaviorCanJoinAllSpaces];
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

@end
