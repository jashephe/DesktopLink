//
//  DLActionButton.m
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import "DLActionButton.h"
#import "NSShadow+FastCreation.h"

@interface DLActionButton ()

@property NSTrackingArea *mouseTrackingArea;
@property (nonatomic, copy) ActionBlock block;

@end

@implementation DLActionButton

+ (void)initialize {
	[DLActionButton setCellClass:[DLActionButtonCell class]];
}

- (id)initWithTitle:(NSString *)aTitle image:(NSImage *)anImage handler:(ActionBlock)aBlock {
	self = [super init];
	if (self) {
		self.image = anImage;
		self.title = aTitle;
		self.block = aBlock;
		
		[self setTarget:self];
		[self setAction:@selector(performBlockAction)];
		
		[self setBordered:YES];
		[self setButtonType:NSMomentaryLightButton];
		[self setBezelStyle:NSSmallSquareBezelStyle];
		self.mouseTrackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingInVisibleRect owner:self userInfo:nil];
		[self addTrackingArea:self.mouseTrackingArea];
	}
    
	return self;
}

- (void)dealloc {
	[self removeTrackingArea:self.mouseTrackingArea];
}

- (void)mouseEntered:(NSEvent *)event {
	[self.cell mouseEntered:event];
}

- (void)mouseExited:(NSEvent *)event {
	[self.cell mouseExited:event];
}

- (void)performBlockAction {
	self.block();
}

@end

#pragma mark -
#pragma mark Button Drawing

@interface DLActionButtonCell ()
@property BOOL mouseoverActive;
@end

@implementation DLActionButtonCell

- (void)drawImage:(NSImage*)image withFrame:(NSRect)frame inView:(NSView*)controlView {
	if ([self isHighlighted]) {
		[image drawInRect:NSInsetRect(self.controlView.bounds, self.controlView.bounds.size.width * 0.15, self.controlView.bounds.size.height * 0.15) fromRect:NSZeroRect operation:NSCompositeDestinationOver fraction:0.9 respectFlipped:YES hints:nil];
	}
	else if (self.mouseoverActive) {
		[image drawInRect:NSInsetRect(self.controlView.bounds, self.controlView.bounds.size.width * 0.15, self.controlView.bounds.size.height * 0.15) fromRect:NSZeroRect operation:NSCompositeDestinationOver fraction:0.7 respectFlipped:YES hints:nil];
	}
	else {
		[image drawInRect:NSInsetRect(self.controlView.bounds, self.controlView.bounds.size.width * 0.15, self.controlView.bounds.size.height * 0.15) fromRect:NSZeroRect operation:NSCompositeDestinationOver fraction:0.5 respectFlipped:YES hints:nil];
	}
}

static NSDictionary *baseTextAttributes;

- (NSRect)drawTitle:(NSAttributedString*)title withFrame:(NSRect)frame inView:(NSView*)controlView {
	
	if (!baseTextAttributes) {
		NSMutableParagraphStyle 	*centeredParagraphStyle = [[NSMutableParagraphStyle alloc] init];
		[centeredParagraphStyle setAlignment:NSCenterTextAlignment];
		baseTextAttributes = @{NSShadowAttributeName : [NSShadow shadowWithColor:[NSColor blackColor] offset:NSMakeSize(0, -1) blurRadius:3.0f],
						 NSFontAttributeName : [[NSFontManager sharedFontManager] fontWithFamily:@"Helvetica Neue" traits:0 weight:3 size:16],
						 NSParagraphStyleAttributeName : centeredParagraphStyle
						 };
	}
	
	NSMutableAttributedString *styledTitle = [title mutableCopy];
	
	NSMutableDictionary *attributes = [baseTextAttributes mutableCopy];
	
	if ([self isHighlighted]) {
		[attributes setValue:[NSColor colorWithCalibratedWhite:1.0f alpha:0.9f] forKey:NSForegroundColorAttributeName];
	}
	else if (self.mouseoverActive) {
		[attributes setValue:[NSColor colorWithCalibratedWhite:1.0f alpha:0.7f] forKey:NSForegroundColorAttributeName];
	}
	else {
		[attributes setValue:[NSColor colorWithCalibratedWhite:1.0f alpha:0.5f] forKey:NSForegroundColorAttributeName];
	}
	
	[styledTitle setAttributes:attributes range:NSMakeRange(0, styledTitle.length)];
	
	[styledTitle drawInRect:NSMakeRect(0, self.controlView.bounds.size.height - styledTitle.size.height - self.controlView.bounds.size.height*0.05f, self.controlView.bounds.size.width, styledTitle.size.height)];
	return frame;
}

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView {
	if ([self isHighlighted]) {
		NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:self.controlView.bounds xRadius:10.0f yRadius:8.0f];
		[[NSColor colorWithCalibratedWhite:0.0 alpha:0.2] set];
		[path fill];
	}
	else if (self.mouseoverActive) {
		NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:self.controlView.bounds xRadius:10.0f yRadius:8.0f];
		[[NSColor colorWithCalibratedWhite:0.0 alpha:0.1] set];
		[path fill];
	}
}

# pragma mark Mouseover Management

- (void)mouseEntered:(NSEvent *)event {
	self.mouseoverActive = YES;
	[self.controlView setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)event {
	self.mouseoverActive = NO;
	[self.controlView setNeedsDisplay:YES];
}

@end