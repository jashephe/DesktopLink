//
//  NSShadow+FastCreation.h
//  DesktopLink
//
//  Created by James Shepherdson on 7/28/13.
//  Copyright (c) 2013 James Shepherdson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSShadow (FastCreation)

+ (NSShadow *)shadowWithColor:(NSColor *)theColor offset:(NSSize)theOffset blurRadius:(CGFloat)theBlurRadius;

@end
