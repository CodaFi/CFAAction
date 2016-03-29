//
//  CFAMove.h
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAAction+Private.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFAMove : CFAAction

+ (CFAAction *)moveByX:(CGFloat)deltaX y:(CGFloat)deltaY duration:(NSTimeInterval)sec;
#if CGVECTOR_DEFINED
+ (CFAAction *)moveBy:(CGVector)delta duration:(NSTimeInterval)sec;
#endif
+ (CFAAction *)moveTo:(CGPoint)location duration:(NSTimeInterval)sec;
+ (CFAAction *)moveToX:(CGFloat)x duration:(NSTimeInterval)sec;
+ (CFAAction *)moveToY:(CGFloat)y duration:(NSTimeInterval)sec;

@end

NS_ASSUME_NONNULL_END
