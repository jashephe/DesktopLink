//
//  NSShadow+FastCreation.m
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import "NSShadow+FastCreation.h"

@implementation NSShadow (FastCreation)

+ (NSShadow *)shadowWithColor:(NSColor *)theColor offset:(NSSize)theOffset blurRadius:(CGFloat)theBlurRadius {
	NSShadow *theShadow = [[NSShadow alloc] init];
	[theShadow setShadowColor:theColor];
	[theShadow setShadowOffset:theOffset];
	[theShadow setShadowBlurRadius:theBlurRadius];
	return theShadow;
}

@end
