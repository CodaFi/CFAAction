//
//  CFCAScale.h
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFAAction+Private.h"

@interface CFAScale : CFAAction

+ (CFAAction *)scaleBy:(CGFloat)scale duration:(NSTimeInterval)sec;
+ (CFAAction *)scaleXBy:(CGFloat)xScale y:(CGFloat)yScale duration:(NSTimeInterval)sec;
+ (CFAAction *)scaleTo:(CGFloat)scale duration:(NSTimeInterval)sec;
+ (CFAAction *)scaleXTo:(CGFloat)xScale y:(CGFloat)yScale duration:(NSTimeInterval)sec;
+ (CFAAction *)scaleXTo:(CGFloat)scale duration:(NSTimeInterval)sec;
+ (CFAAction *)scaleYTo:(CGFloat)scale duration:(NSTimeInterval)sec;

@end
