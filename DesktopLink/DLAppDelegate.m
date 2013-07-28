//
//  DLAppDelegate.m
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import "DLAppDelegate.h"
#import "DLDesktopWindow.h"
#import "DLActionButtonContainerView.h"
#import "DLActionButton.h"

@interface DLAppDelegate ()
@property (strong) DLDesktopWindow *desktopPanel;
@end

@implementation DLAppDelegate

- (id)init {
	self = [super init];
	if (self) {
		DLActionButton *test1 = [[DLActionButton alloc] init];
		[test1 setImage:[NSImage imageNamed:NSImageNameNetwork]];
		[test1 setTitle:@"DMC Website"];
		DLActionButton *test2 = [[DLActionButton alloc] init];
		[test2 setImage:[NSImage imageNamed:NSImageNameShareTemplate]];
		[test2 setTitle:@"Online Reservations"];
		DLActionButton *test3 = [[DLActionButton alloc] init];
		[test3 setImage:[NSImage imageNamed:NSImageNameInfo]];
		[test3 setTitle:@"Help Wiki"];
		
		DLActionButtonContainerView *actionButtonContainer = [[DLActionButtonContainerView alloc] initWithActionButtonSize:NSMakeSize(160, 160)];
		[actionButtonContainer addActionButton:test1];
		[actionButtonContainer addActionButton:test2];
		[actionButtonContainer addActionButton:test3];
		
		self.desktopPanel = [[DLDesktopWindow alloc] initWithContentRect:actionButtonContainer.frame backing:NSBackingStoreBuffered defer:NO];
		[self.desktopPanel setContentView:actionButtonContainer];
		[self.desktopPanel reallyCenter];
	}
	return self;
}

- (void)applicationWillFinishLaunching:(NSNotification *)aNotification {
	[self.desktopPanel makeKeyAndOrderFront:self];
}

@end
