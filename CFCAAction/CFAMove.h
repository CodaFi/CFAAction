//
//  CFCAMove.h
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFAAction+Private.h"

@interface CFAMove : CFAAction

+ (CFAAction *)moveByX:(CGFloat)deltaX y:(CGFloat)deltaY duration:(NSTimeInterval)sec;
#if CGVECTOR_DEFINED
+ (CFAAction *)moveBy:(CGVector)delta duration:(NSTimeInterval)sec;
#endif
+ (CFAAction *)moveTo:(CGPoint)location duration:(NSTimeInterval)sec;
+ (CFAAction *)moveToX:(CGFloat)x duration:(NSTimeInterval)sec;
+ (CFAAction *)moveToY:(CGFloat)y duration:(NSTimeInterval)sec;

@end
