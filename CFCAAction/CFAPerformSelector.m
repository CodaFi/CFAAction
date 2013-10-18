//
//  CFCAPerformSelector.m
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFAPerformSelector.h"
#include <objc/message.h>

@implementation CFAPerformSelector {
	SEL _selector;
	id _target;
}

+ (CFAAction *)performSelector:(SEL)selector onTarget:(id)target {
	CFAPerformSelector *action = [[CFAPerformSelector alloc] init];
	
	action->_selector = selector;
	action->_target = target;
	
	return action;
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	if (!self.finished) {
		if ((_target != nil) && (_selector != NULL)) {
			objc_msgSend(_target, _selector);
		}
		self.finished = YES;
	}
}

@end
