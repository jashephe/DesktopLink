//
//  main.m
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DLAppDelegate.h"

int main(int argc, char *argv[]) {
	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
	Class principalClass = NSClassFromString([infoDictionary objectForKey:@"NSPrincipalClass"]);
	if (![principalClass respondsToSelector:@selector(sharedApplication)]) {
		NSLog(@"Principal class must implement sharedApplication.");
		return EXIT_FAILURE;
	}
	NSApplication *application = [principalClass sharedApplication];
	
	DLAppDelegate *appDelegate = [[DLAppDelegate alloc] init];
	
	[application setDelegate:appDelegate];
	if ([application respondsToSelector:@selector(run)]) {
		[application performSelectorOnMainThread:@selector(run) withObject:nil waitUntilDone:YES];
	}
	
	return EXIT_SUCCESS;
}
