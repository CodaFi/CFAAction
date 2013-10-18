//
//  CFCACustomAction.h
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFAAction+Private.h"

@interface CFACustomAction : CFAAction

+ (CFAAction *)customActionWithDuration:(NSTimeInterval)seconds actionBlock:(void (^)(CALayer *node, CGFloat elapsedTime))block;

@end
