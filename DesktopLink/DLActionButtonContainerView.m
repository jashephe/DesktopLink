//
//  DLActionButtonContainerView.m
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import "DLActionButtonContainerView.h"

@interface DLActionButtonContainerView ()

@property int actionButtonsCount;
@property NSSize actionButtonSize;

@end

#define BUTTON_PADDING 8.0f

@implementation DLActionButtonContainerView

- (id)initWithActionButtonSize:(NSSize)actionButtonSize {
    self = [super initWithFrame:NSMakeRect(0, 0, actionButtonSize.width, actionButtonSize.height)];
    if (self) {
        self.actionButtonsCount = 0;
		self.actionButtonSize = actionButtonSize;
    }
    
    return self;
}

- (void)addActionButton:(DLActionButton *)anActionButton {
	self.actionButtonsCount += 1;
	[self setFrame:NSMakeRect(0, 0, self.actionButtonSize.width * self.actionButtonsCount + BUTTON_PADDING * (self.actionButtonsCount + 1), self.actionButtonSize.height + BUTTON_PADDING * 2)];
	[anActionButton setFrame:NSMakeRect(self.actionButtonSize.width * (self.actionButtonsCount - 1) + BUTTON_PADDING * self.actionButtonsCount, BUTTON_PADDING, self.actionButtonSize.width, self.actionButtonSize.height)];
	[self addSubview:anActionButton];
}

@end
