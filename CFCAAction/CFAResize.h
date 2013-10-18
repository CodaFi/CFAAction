//
//  CFCAResize.h
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAAction+Private.h"

@interface CFAResize : CFAAction

+ (CFAAction *)resizeByWidth:(CGFloat)width height:(CGFloat)height duration:(NSTimeInterval)duration;
+ (CFAAction *)resizeToWidth:(CGFloat)width height:(CGFloat)height duration:(NSTimeInterval)duration;
+ (CFAAction *)resizeToWidth:(CGFloat)width duration:(NSTimeInterval)duration;
+ (CFAAction *)resizeToHeight:(CGFloat)height duration:(NSTimeInterval)duration;

@end
