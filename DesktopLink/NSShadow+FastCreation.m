//
//  NSShadow+FastCreation.m
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import "NSShadow+FastCreation.h"

@implementation NSShadow (FastCreation)

- (id)initWithColor:(NSColor *)theColor offset:(NSSize)theOffset blurRadius:(CGFloat)theBlurRadius {
	self = [super init];
	if (self) {
		[self setShadowColor:theColor];
		[self setShadowOffset:theOffset];
		[self setShadowBlurRadius:theBlurRadius];
	}
	return self;
}

@end
