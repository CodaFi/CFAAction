//
//  CFACustomAction.m
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFACustomAction.h"

@implementation CFACustomAction {
	void (^_actionBlock)(CALayer *node, CGFloat elapsedTime);
}

+ (CFAAction *)customActionWithDuration:(NSTimeInterval)seconds actionBlock:(void (^)(CALayer *node, CGFloat elapsedTime))block {
	CFACustomAction *action = [[CFACustomAction alloc] init];
	
	action->_actionBlock = [block copy];
	action.duration = seconds;
	
	return action;
}

- (id)copyWithZone:(NSZone *)zone {
	CFACustomAction *copyAction = [super copyWithZone:zone];
	copyAction->_actionBlock = [_actionBlock copy];
	
	return copyAction;
}

- (CFAAction *)reversedAction {
	return [self copy];
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	NSCAssert(_actionBlock != NULL, @"CFACustomAction created with NULL custom action");
	
	_actionBlock(target, time);
	self.finished = YES;
}

@end
