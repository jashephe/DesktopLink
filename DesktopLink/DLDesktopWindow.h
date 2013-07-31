//
//  DLDesktopWindow.h
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DLDesktopWindow : NSWindow

- (id)initWithContentRect:(NSRect)contentRect backing:(NSBackingStoreType)bufferingType defer:(BOOL)deferCreation;
- (void)reallyCenter;

@end
