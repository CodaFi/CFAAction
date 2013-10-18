//
//  CFCAMove.m
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAMove.h"
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
#import <UIKit/UIKit.h>
#endif

static NSString *const CFCAMoveKeypath = @"position";

typedef NS_ENUM(int, CFMoveSubtype) {
	CFMoveSubtypeNone = 0,
	CFMoveSubtypeDelta,
	CFMoveSubtypeDirect
};

@implementation CFAMove {
	double x, y;
	CFMoveSubtype _subtype;
}

#if CGVECTOR_DEFINED
+ (CFAAction *)moveBy:(CGVector)delta duration:(NSTimeInterval)sec {
	return [CFAMove moveByX:delta.dx y:delta.dy duration:sec];
}
#endif

+ (CFAAction *)moveByX:(CGFloat)deltaX y:(CGFloat)deltaY duration:(NSTimeInterval)sec {
	CFAMove *moveAction = [[CFAMove alloc] init];
	
	moveAction->x = deltaX;
	moveAction->y = deltaY;
	moveAction->_subtype = CFMoveSubtypeDelta;
	moveAction.duration = sec;
	
	return moveAction;
}

+ (CFAAction *)moveTo:(CGPoint)location duration:(NSTimeInterval)sec {
	return [CFAMove moveToX:location.x y:location.y duration:sec];
}

+ (CFAAction *)moveToX:(CGFloat)x duration:(NSTimeInterval)sec {
	return [CFAMove moveToX:x y:0.0f duration:sec];
}

+ (CFAAction *)moveToY:(CGFloat)y duration:(NSTimeInterval)sec {
	return [CFAMove moveToX:0.0f y:y duration:sec];
}

+ (CFAAction *)moveToX:(CGFloat)x y:(CGFloat)y duration:(NSTimeInterval)sec {
	CFAMove *moveAction = [[CFAMove alloc] init];
	
	moveAction->x = x;
	moveAction->y = y;
	moveAction.duration = sec;
	moveAction->_subtype = CFMoveSubtypeDirect;
	
	return moveAction;
}

- (id)copyWithZone:(NSZone *)zone {
	CFAMove *copiedAction = [super copyWithZone:zone];
	copiedAction->x = x;
	copiedAction->y = y;
	copiedAction->_subtype = _subtype;
	copiedAction.duration = self.duration;
	return copiedAction;
}

- (CFAAction *)reversedAction {
	if (_subtype == CFMoveSubtypeDirect) {
		return [self copy];
	}
	CFAMove *copiedAction = [super copyWithZone:NULL];
	copiedAction->x = -x;
	copiedAction->y = -y;
	copiedAction->_subtype = _subtype;
	copiedAction.duration = self.duration;
	return copiedAction;
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	CGPoint newPosition = [(CALayer *)target.presentationLayer ?: target position];
	switch (_subtype) {
		case CFMoveSubtypeDelta:
			newPosition.x += x;
			newPosition.y += y;
			break;
		case CFMoveSubtypeDirect:
			newPosition.x = x;
			newPosition.y = y;
			break;
		default:
			break;
	}
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:CFCAMoveKeypath];
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	animation.beginTime = time;
	animation.fromValue = [(CALayer *)target.presentationLayer ?: target valueForKey:CFCAMoveKeypath];
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
	animation.toValue = [NSValue valueWithCGPoint:newPosition];
#else
	animation.toValue = [NSValue valueWithPoint:newPosition];
#endif
	animation.duration = self.duration;
	animation.repeatCount = self.repeatCount;
	animation.cumulative = YES;
	animation.timingFunction = self.timingFunction;
	[animation setDelegate:self];
	[target.presentationLayer ?: target addAnimation:animation forKey:CFCAMoveKeypath];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	self.finished = flag;
}

@end
