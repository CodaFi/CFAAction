//
//  CFAWait.m
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAWait.h"

@implementation CFAWait {
	NSTimeInterval _range;
}

+ (CFAAction *)waitForDuration:(NSTimeInterval)sec {
	CFAWait *waitAnimation = [[CFAWait alloc] init];
	
	waitAnimation.duration = sec;
	
	return waitAnimation;
}

+ (CFAAction *)waitForDuration:(NSTimeInterval)sec withRange:(NSTimeInterval)durationRange {
	CFAWait *waitAnimation = [[CFAWait alloc] init];
	
	waitAnimation->_range = durationRange;
	waitAnimation.duration = sec;
	
	return waitAnimation;
}

- (id)copyWithZone:(NSZone *)zone {
	CFAWait *copiedAction = [super copyWithZone:NULL];
	copiedAction->_range = _range;
	copiedAction.duration = self.duration;
	return copiedAction;
}

- (CFAAction *)reversedAction {
	return [self copy];
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		self.finished = YES;
	});
}


@end
