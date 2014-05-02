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

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	if (_actionBlock != NULL) {
		_actionBlock(target, time);
	}
	self.finished = YES;
}

@end
