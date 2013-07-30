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
		DLActionButton *test1 = [[DLActionButton alloc] initWithTitle:@"DMC Website" image:[NSImage imageNamed:NSImageNameNetwork] handler:^{
			[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://digitalmedia.jhu.edu/"]];
		}];
		DLActionButton *test2 = [[DLActionButton alloc] initWithTitle:@"Online Reservations" image:[NSImage imageNamed:NSImageNameBonjour] handler:^{
			[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://checkout.dmc.jhu.edu/webcheckout/pir"]];
		}];
		DLActionButton *test3 = [[DLActionButton alloc] initWithTitle:@"Help Wiki" image:[NSImage imageNamed:NSImageNameInfo] handler:^{
			[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://proteus.dmc.jhu.edu/groups/helpwiki/"]];
		}];
		
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
