//
//  CFAHide.m
//  CFAAction
//
//  Created by Robert Widmann on 12/9/14.
//  Copyright (c) 2014 CodaFi. All rights reserved.
//

#import "CFAHide.h"

@implementation CFAHide {
	BOOL _willHideNode;
}

+ (CFAAction *)hide {
	CFAHide *hideAction = [[CFAHide alloc] init];
	hideAction->_willHideNode = YES;
	return hideAction;
}

+ (CFAAction *)unhide {
	CFAHide *hideAction = [[CFAHide alloc] init];
	hideAction->_willHideNode = NO;
	return hideAction;
}

- (id)copyWithZone:(NSZone *)zone {
	CFAHide *copiedAction = [super copyWithZone:zone];
	copiedAction->_willHideNode = _willHideNode;
	return copiedAction;
}

- (CFAAction *)reversedAction {
	CFAHide *copiedAction = [super copyWithZone:NULL];
	copiedAction->_willHideNode = !_willHideNode;
	return copiedAction;
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	target.hidden = _willHideNode;
	self.finished = YES;
}

@end
