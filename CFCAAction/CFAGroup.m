//
//  CFCAGroup.m
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAGroup.h"
#import "CFASequence.h"

@implementation CFAGroup {
	NSArray *_actions;
}

- (id)init {
	self = [super init];
	
	_actions = [[NSArray alloc] init];
	
	return self;
}

+ (instancetype)groupWithActions:(NSArray *)actions {
	CFAGroup *sequence = nil;
	if (actions != nil) {
		if (actions.count != 0) {
			NSMutableArray *groupedActions = [[NSMutableArray alloc] initWithCapacity:actions.count];
			for (id action in actions) {
				if (![action isKindOfClass:NSArray.class]) {
					[groupedActions addObject:[action copy]];
				} else {
					[groupedActions addObject:[CFASequence sequenceWithActions:action]];
				}
			}
			sequence = [[CFAGroup alloc] init];
			sequence->_actions = groupedActions.copy;
			NSTimeInterval accumulator = 0.f;
			for (CFAAction *group in groupedActions) {
				accumulator = MAX(accumulator, group.duration);
			}
			[sequence setDuration:accumulator];
		}
	}
	return sequence;
}

- (id)copyWithZone:(NSZone *)zone {
	return [CFAGroup groupWithActions:_actions];
}

- (CFAAction *)reversedAction {
	NSMutableArray *reversedActions = [NSMutableArray arrayWithCapacity:_actions.count];
	for (CFAAction *action in _actions) {
		[reversedActions addObject:[action reversedAction]];
	}
	return [CFAGroup groupWithActions:reversedActions];
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	for (CFAAction *action in _actions) {
		[action executeWithTarget:target forTime:time];
	}
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		self.finished = YES;
	});
}

- (BOOL)finished {
	BOOL finished = YES;
	for (CFAAction *action in _actions) {
		if (!action.finished) return NO;
	}
	return finished;
}

@end
