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
		DLActionButton *homeLink = [[DLActionButton alloc] initWithTitle:@"DMC Website" image:[NSImage imageNamed:@"DMC_3D_color.png"] handler:^{
			[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://digitalmedia.jhu.edu/"]];
		}];
		DLActionButton *reservationsLink = [[DLActionButton alloc] initWithTitle:@"Online Reservations" image:[NSImage imageNamed:@"Camera_3D_color.png"] handler:^{
			[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://checkout.dmc.jhu.edu/webcheckout/pir"]];
		}];
		DLActionButton *memberWikiLink = [[DLActionButton alloc] initWithTitle:@"Member Wiki" image:[NSImage imageNamed:@"Info_3D_color.png"] handler:^{
			[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://proteus.dmc.jhu.edu/groups/helpwiki/"]];
		}];
		
		DLActionButtonContainerView *actionButtonContainer = [[DLActionButtonContainerView alloc] initWithActionButtonSize:NSMakeSize(160, 160)];
		[actionButtonContainer addActionButton:homeLink];
		[actionButtonContainer addActionButton:reservationsLink];
		[actionButtonContainer addActionButton:memberWikiLink];
		
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
