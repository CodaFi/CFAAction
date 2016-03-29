//
//  CFAWait.h
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAAction+Private.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFAWait : CFAAction

+ (CFAAction *)waitForDuration:(NSTimeInterval)sec;
+ (CFAAction *)waitForDuration:(NSTimeInterval)sec withRange:(NSTimeInterval)durationRange;

@end

NS_ASSUME_NONNULL_END
