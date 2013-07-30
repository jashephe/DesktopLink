//
//  DLActionButton.h
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DLActionButton : NSButton

typedef void (^ActionBlock)(void);

- (id)initWithTitle:(NSString *)aTitle image:(NSImage *)anImage handler:(ActionBlock)aBlock;

@end

@interface DLActionButtonCell : NSButtonCell

@end
