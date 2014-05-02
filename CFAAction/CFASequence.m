//
//  CFASequence.m
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFASequence.h"
#import "CFAGroup.h"

@implementation CFASequence {
	NSArray *_actions;
}

- (id)init {
	self = [super init];
	
	_actions = [[NSArray alloc] init];
	
	return self;
}

+ (instancetype)sequenceWithActions:(NSArray *)actions {
	CFASequence *sequence = nil;
	if (actions != nil) {
		if (actions.count != 0) {
			NSMutableArray *groupedActions = [[NSMutableArray alloc] initWithCapacity:actions.count];
			for (id action in actions) {
				if (![action isKindOfClass:NSArray.class]) {
					[groupedActions addObject:[action copy]];
				} else {
					[groupedActions addObject:[CFAGroup groupWithActions:action]];
				}
			}
			sequence = [[CFASequence alloc] init];
			sequence->_actions = groupedActions.copy;
			NSTimeInterval accumulator = 0.f;
			for (CFAGroup *group in groupedActions) {
				accumulator += group.duration;
			}
			[sequence setDuration:accumulator];
		}
	}
	return sequence;
}

- (id)copyWithZone:(NSZone *)zone {
	return [CFASequence sequenceWithActions:_actions];
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	NSTimeInterval accumulator = 0.0f;
	for (CFAAction *action in _actions) {
		[action executeWithTarget:target forTime:time + accumulator];
		accumulator += action.duration;
	}
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(accumulator * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		self.finished = YES;
	});
}

- (CFAAction *)reversedAction {
	NSMutableArray *reversedActions = [NSMutableArray arrayWithCapacity:_actions.count];
	for (CFAAction *action in _actions) {
		[reversedActions insertObject:[action reversedAction] atIndex:0];
	}
	return [CFASequence sequenceWithActions:reversedActions];
}

@end
