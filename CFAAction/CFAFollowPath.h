//
//  CFAFollowPath.h
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAAction+Private.h"

@interface CFAFollowPath : CFAAction

+ (CFAAction *)followPath:(CGPathRef)path duration:(NSTimeInterval)sec;
+ (CFAAction *)followPath:(CGPathRef)path asOffset:(BOOL)offset orientToPath:(BOOL)orient duration:(NSTimeInterval)sec;

@end
