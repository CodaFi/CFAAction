//
//  CFCARepeat.m
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFARepeat.h"

@implementation CFARepeat {
	CFAAction *_repeatedAction;
	float _count;
	BOOL _forever;
}

+ (CFAAction *)repeatAction:(CFAAction *)action count:(NSUInteger)count {
	NSParameterAssert(action != nil);
	
	CFARepeat *repeatAction = [[CFARepeat alloc] init];

	repeatAction->_repeatedAction = [action copy];
	repeatAction->_count = count;
	repeatAction->_forever = NO;
	repeatAction.duration = action.duration * ((count < 1) ? 1 : count);

	return repeatAction;
}

+ (CFAAction *)repeatActionForever:(CFAAction *)action {
	NSParameterAssert(action != nil);
	
	CFARepeat *repeatAction = [[CFARepeat alloc] init];
	
	repeatAction->_repeatedAction = [action copy];
	repeatAction->_count = HUGE_VALF;
	repeatAction.duration = action.duration * HUGE_VALF;
	
	return repeatAction;
}

- (id)copyWithZone:(NSZone *)zone {
	CFARepeat *repeatedCopy = nil;
	
	if (_forever) {
		repeatedCopy = (CFARepeat *)[CFARepeat repeatActionForever:_repeatedAction];
	} else {
		repeatedCopy = (CFARepeat *)[CFARepeat repeatAction:_repeatedAction count:_count];
	}
	
	return repeatedCopy;
}

- (CFAAction *)reversedAction {
	return [self copy];
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	_repeatedAction.repeatCount = _count;
	[_repeatedAction executeWithTarget:target forTime:time];
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		self.finished = YES;
	});
}


@end
