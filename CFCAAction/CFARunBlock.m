//
//  CFCARunBlock.m
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFARunBlock.h"

@implementation CFARunBlock {
	dispatch_block_t _block;
	dispatch_queue_t _queue;
}

+ (CFAAction *)runBlock:(dispatch_block_t)block {
	return [CFAAction runBlock:block queue:NULL];
}

+ (CFAAction *)runBlock:(dispatch_block_t)block queue:(dispatch_queue_t)queue {
	CFARunBlock *runBlock = [[CFARunBlock alloc] init];
	runBlock->_block = (__bridge dispatch_block_t)Block_copy((__bridge void *)block);
	runBlock->_queue = queue;
	return runBlock;
}

- (id)copyWithZone:(NSZone *)zone {
	CFARunBlock *copiedAction = [super copyWithZone:zone];
	copiedAction->_block = (__bridge dispatch_block_t)Block_copy((__bridge void *)_block);
	copiedAction->_queue = _queue;
	return copiedAction;
}

- (CFAAction *)reversedAction {
	return [self copy];
}

- (void)executeWithTarget:(id)target forTime:(NSTimeInterval)time {
	if (self.finished) {
		return;
	}
	if (_block == NULL) return;
	if (_queue == NULL) {
		_queue = dispatch_get_main_queue();
	}
	dispatch_async(_queue, _block);
	self.finished = YES;
}

@end
