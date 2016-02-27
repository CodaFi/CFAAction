//
//  CFACustomAction.h
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAAction+Private.h"

@interface CFACustomAction : CFAAction

+ (CFAAction *)customActionWithDuration:(NSTimeInterval)seconds actionBlock:(void (^)(CALayer *node, double elapsedTime))block;

@end
