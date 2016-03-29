//
//  CFASpeed.h
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAAction+Private.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFASpeed : CFAAction

+ (CFAAction *)speedBy:(CGFloat)speed duration:(NSTimeInterval)sec;
+ (CFAAction *)speedTo:(CGFloat)speed duration:(NSTimeInterval)sec;

@end

NS_ASSUME_NONNULL_END
