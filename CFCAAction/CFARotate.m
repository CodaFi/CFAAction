//
//  CFCARotate.m
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFARotate.h"

static NSString *const CFCARotateKeypath = @"transform.rotation";

typedef NS_ENUM(int, CFRotateSubtype) {
	CFRotateSubtypeNone = 0,
	CFRotateSubtypeDelta,
	CFRotateSubtypeDirect
};

@implementation CFARotate {
	CGFloat _angle;
	CFRotateSubtype _subtype;
}

+ (CFAAction *)rotateByAngle:(CGFloat)radians duration:(NSTimeInterval)sec {
	CFARotate *resizeAction = [[CFARotate alloc] init];
	
	resizeAction->_angle = radians;
	resizeAction.duration = sec;
	resizeAction->_subtype = CFRotateSubtypeDelta;
	
	return resizeAction;
}

+ (CFAAction *)rotateToAngle:(CGFloat)radians duration:(NSTimeInterval)sec {
	return [CFARotate rotateToAngle:radians duration:sec shortestUnitArc:NO];
}

+ (CFAAction *)rotateToAngle:(CGFloat)radians duration:(NSTimeInterval)sec shortestUnitArc:(BOOL)shortestUnitArc {
	CFARotate *resizeAction = [[CFARotate alloc] init];
	
	resizeAction->_angle = radians;
	resizeAction.duration = sec;
	resizeAction->_subtype = CFRotateSubtypeDirect;
	
	return resizeAction;
}

- (id)copyWithZone:(NSZone *)zone {
	CFARotate *copiedAction = [super copyWithZone:zone];
	copiedAction->_angle = _angle;
	copiedAction->_subtype = _subtype;
	copiedAction.duration = self.duration;
	return copiedAction;
}

- (CFAAction *)reversedAction {
	if (_subtype == CFRotateSubtypeDirect) {
		return [self copy];
	}
	CFARotate *copiedAction = [super copyWithZone:NULL];
	copiedAction->_angle = -_angle;
	copiedAction->_subtype = _subtype;
	copiedAction.duration = self.duration;
	return copiedAction;
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	CGFloat angle = [(NSNumber *)[target.presentationLayer valueForKeyPath:@"transform.rotation"] floatValue];
	switch (_subtype) {
		case CFRotateSubtypeDelta:
			angle += _angle;
			break;
		case CFRotateSubtypeDirect:
			angle = _angle;
			break;
		default:
			break;
	}
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:CFCARotateKeypath];
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	animation.beginTime = time;
	animation.fromValue = [target.presentationLayer valueForKeyPath:@"transform.rotation"];
	animation.toValue = @(_angle);
	animation.duration = self.duration;
	animation.repeatCount = self.repeatCount;
	animation.cumulative = YES;
	animation.timingFunction = self.timingFunction;
	[animation setDelegate:self];
	[target.presentationLayer ?: target addAnimation:animation forKey:CFCARotateKeypath];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	self.finished = YES;
}


@end
