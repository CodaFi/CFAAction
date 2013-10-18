//
//  NSBezierPath+CFABezierPathQuartzAssistant.h
//  CFAAction
//
//  Created by Robert Widmann on 10/18/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <AppKit/NSBezierPath.h>

@interface NSBezierPath (CFABezierPathQuartzAssistant)

- (CGPathRef)quartzPath;

@end