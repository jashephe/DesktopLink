//
//  DLActionButtonContainerView.h
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DLActionButton.h"

@interface DLActionButtonContainerView : NSView

- (id)initWithActionButtonSize:(NSSize)actionButtonSize;
- (void)addActionButton:(DLActionButton *)anActionButton;

@end
