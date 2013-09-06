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

#define BACKGROUND_OPACITY 0.1
#define BASE_OPACITY 0.6
#define OPACITY_INCREMENT 0.2
#define CORNER_RADIUS 8.0

@implementation DLActionButtonCell

- (void)drawImage:(NSImage*)image withFrame:(NSRect)frame inView:(NSView*)controlView {
	NSRect imageRect = NSMakeRect(self.controlView.bounds.origin.x + self.controlView.bounds.size.width * 0.1, self.controlView.bounds.origin.y + self.controlView.bounds.size.height * 0.05, self.controlView.bounds.size.width * 0.8, self.controlView.bounds.size.height * 0.8);
	if ([self isHighlighted]) {
		[image drawInRect:imageRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:BASE_OPACITY + 2*OPACITY_INCREMENT respectFlipped:YES hints:nil];
	}
	else if (self.mouseoverActive) {
		[image drawInRect:imageRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:BASE_OPACITY + OPACITY_INCREMENT respectFlipped:YES hints:nil];
	}
	else {
		[image drawInRect:imageRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:BASE_OPACITY respectFlipped:YES hints:nil];
	}
}

static NSDictionary *baseTextAttributes;

- (NSRect)drawTitle:(NSAttributedString*)title withFrame:(NSRect)frame inView:(NSView*)controlView {
	
	if (!baseTextAttributes) {
		NSMutableParagraphStyle 	*centeredParagraphStyle = [[NSMutableParagraphStyle alloc] init];
		[centeredParagraphStyle setAlignment:NSCenterTextAlignment];
		baseTextAttributes = @{NSShadowAttributeName : [[NSShadow alloc] initWithColor:[NSColor blackColor] offset:NSMakeSize(0, -1) blurRadius:3.0f],
						 NSFontAttributeName : [[NSFontManager sharedFontManager] fontWithFamily:@"Helvetica Neue" traits:0 weight:3 size:16],
						 NSParagraphStyleAttributeName : centeredParagraphStyle
						 };
	}
	
	NSMutableAttributedString *styledTitle = [title mutableCopy];
	
	NSMutableDictionary *attributes = [baseTextAttributes mutableCopy];
	
	if ([self isHighlighted]) {
		[attributes setValue:[NSColor colorWithCalibratedWhite:1.0f alpha:BASE_OPACITY + 2*OPACITY_INCREMENT] forKey:NSForegroundColorAttributeName];
	}
	else if (self.mouseoverActive) {
		[attributes setValue:[NSColor colorWithCalibratedWhite:1.0f alpha:BASE_OPACITY + OPACITY_INCREMENT] forKey:NSForegroundColorAttributeName];
	}
	else {
		[attributes setValue:[NSColor colorWithCalibratedWhite:1.0f alpha:BASE_OPACITY] forKey:NSForegroundColorAttributeName];
	}
	
	[styledTitle setAttributes:attributes range:NSMakeRange(0, styledTitle.length)];
	
	[styledTitle drawInRect:NSMakeRect(0, self.controlView.bounds.size.height - styledTitle.size.height - self.controlView.bounds.size.height*0.05f, self.controlView.bounds.size.width, styledTitle.size.height)];
	return frame;
}

- (void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView {
	if ([self isHighlighted]) {
		NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:self.controlView.bounds xRadius:CORNER_RADIUS yRadius:CORNER_RADIUS];
		[[NSColor colorWithCalibratedWhite:0.0 alpha:BACKGROUND_OPACITY + OPACITY_INCREMENT] set];
		[path fill];
	}
	else if (self.mouseoverActive) {
		NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:self.controlView.bounds xRadius:CORNER_RADIUS yRadius:CORNER_RADIUS];
		[[NSColor colorWithCalibratedWhite:0.0 alpha:BACKGROUND_OPACITY] set];
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