//
//  DLActionButtonContainerView.m
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import "DLActionButtonContainerView.h"
#import "NSShadow+FastCreation.h"

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

#pragma mark Graphics

#define WINDOW_CORNER_RADIUS	 10.0f
#define BACKGROUND_COLOR [NSColor colorWithCalibratedWhite:0.5 alpha:0.4]
#define SHADOW_THICKNESS 10.0f

- (void)drawRect:(NSRect)dirtyRect {
	NSRect drawingRect = [self bounds];
	NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:drawingRect xRadius:WINDOW_CORNER_RADIUS yRadius:WINDOW_CORNER_RADIUS];
	
	NSBezierPath *shadowPath = [NSBezierPath bezierPathWithRoundedRect:NSInsetRect(drawingRect, -SHADOW_THICKNESS/2 - 1, -SHADOW_THICKNESS/2 - 1) xRadius:WINDOW_CORNER_RADIUS yRadius:WINDOW_CORNER_RADIUS];
	
	[BACKGROUND_COLOR set];
	[path fill];
	
	[[NSGraphicsContext currentContext] saveGraphicsState];
	
	[path addClip];
	
	NSShadow * shadow = [[NSShadow alloc] initWithColor:[NSColor colorWithCalibratedWhite:0.0f alpha:0.8f] offset:NSZeroSize blurRadius:SHADOW_THICKNESS];
	[shadow set];
	
	[[NSColor blackColor] set];
	[shadowPath setLineWidth:SHADOW_THICKNESS];
	[shadowPath stroke];
	
	[[NSGraphicsContext currentContext] restoreGraphicsState];
}

@end
