//
//  CFCASpeed.m
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFASpeed.h"

static NSString *const CFCASpeedKeypath = @"speed";

typedef NS_ENUM(int, CFSpeedSubtype) {
	CFSpeedSubtypeNone = 0,
	CFSpeedSubtypeDelta,
	CFSpeedSubtypeDirect
};

@implementation CFASpeed {
	CGFloat _speed;
	CFSpeedSubtype _subtype;
}

+ (CFAAction *)speedBy:(CGFloat)speed duration:(NSTimeInterval)sec {
	CFASpeed *speedAnimation = [[CFASpeed alloc] init];
	
	speedAnimation->_speed = speed;
	speedAnimation->_subtype = CFSpeedSubtypeDelta;
	speedAnimation.duration = sec;
	
	return speedAnimation;
}

+ (CFAAction *)speedTo:(CGFloat)speed duration:(NSTimeInterval)sec {
	CFASpeed *speedAnimation = [[CFASpeed alloc] init];
	
	speedAnimation->_speed = speed;
	speedAnimation->_subtype = CFSpeedSubtypeDirect;
	speedAnimation.duration = sec;
	
	return speedAnimation;
}

- (id)copyWithZone:(NSZone *)zone {
	CFASpeed *copiedAction = [super copyWithZone:NULL];
	copiedAction->_speed = _speed;
	copiedAction->_subtype = _subtype;
	copiedAction.duration = self.duration;
	return copiedAction;
}

- (CFAAction *)reversedAction {
	CFASpeed *copiedAction = [super copyWithZone:NULL];
	copiedAction->_speed = -_speed;
	copiedAction->_subtype = _subtype;
	copiedAction.duration = self.duration;
	return copiedAction;
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	CGFloat newSpeed = [(CALayer *)target.presentationLayer ?: target speed];

	switch (_subtype) {
		case CFSpeedSubtypeDelta:
			newSpeed += _speed;
			break;
		case CFSpeedSubtypeDirect:
			newSpeed = _speed;
			break;
		default:
			break;
	}
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	animation.beginTime = time;
	animation.fromValue = [(CALayer *)target.presentationLayer ?: target valueForKey:CFCASpeedKeypath];
	animation.toValue = @(newSpeed);
	animation.duration = self.duration;
	animation.timingFunction = self.timingFunction;
	[animation setDelegate:self];
	[target.presentationLayer ?: target addAnimation:animation forKey:CFCASpeedKeypath];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	self.finished = flag;
}

@end
