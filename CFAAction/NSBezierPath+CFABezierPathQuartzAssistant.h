//
//  NSBezierPath+CFABezierPathQuartzAssistant.h
//  CFAAction
//
//  Created by Robert Widmann on 10/18/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#if TARGET_OS_IPHONE
// do we need this?
#elif TARGET_IPHONE_SIMULATOR  
// or this?
#else

#import <AppKit/NSBezierPath.h>

@interface NSBezierPath (CFABezierPathQuartzAssistant)

- (CGPathRef)quartzPath;

@end

#endif
