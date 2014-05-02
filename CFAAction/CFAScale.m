//
//  CFAScale.m
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAScale.h"

static NSString *const CFAScaleKeypath = @"scale";
static NSString *const CFAScaleXKeypath = @"transform.scale.x";
static NSString *const CFAScaleYKeypath = @"transform.scale.y";

typedef NS_ENUM(int, CFScaleSubtype) {
	CFScaleSubtypeNone = 0,
	CFScaleSubtypeDelta,
	CFScaleSubtypeDirect
};

@implementation CFAScale {
	CGFloat x, y;
	CFScaleSubtype _subtype;
}

+ (CFAAction *)scaleBy:(CGFloat)scale duration:(NSTimeInterval)sec {
	return [CFAScale scaleXBy:scale y:scale duration:sec];
}

+ (CFAAction *)scaleXBy:(CGFloat)xScale y:(CGFloat)yScale duration:(NSTimeInterval)sec {
	CFAScale *scaleAnimation = [[CFAScale alloc] init];
	
	scaleAnimation->x = xScale;
	scaleAnimation->y = yScale;
	scaleAnimation->_subtype = CFScaleSubtypeDelta;
	scaleAnimation.duration = sec;

	return scaleAnimation;
}

+ (CFAAction *)scaleTo:(CGFloat)scale duration:(NSTimeInterval)sec {
	return [CFAScale scaleXTo:scale y:scale duration:sec];
}

+ (CFAAction *)scaleXTo:(CGFloat)xScale y:(CGFloat)yScale duration:(NSTimeInterval)sec {
	CFAScale *scaleAnimation = [[CFAScale alloc] init];
	
	scaleAnimation->x = xScale;
	scaleAnimation->y = yScale;
	scaleAnimation->_subtype = CFScaleSubtypeDirect;
	scaleAnimation.duration = sec;
	
	return scaleAnimation;
}

+ (CFAAction *)scaleXTo:(CGFloat)scale duration:(NSTimeInterval)sec {
	return [CFAScale scaleXBy:scale y:MAXFLOAT duration:sec];
}

+ (CFAAction *)scaleYTo:(CGFloat)scale duration:(NSTimeInterval)sec {
	return [CFAScale scaleXBy:MAXFLOAT y:scale duration:sec];
}

- (id)copyWithZone:(NSZone *)zone {
	CFAScale *copiedAction = [super copyWithZone:zone];
	copiedAction->x = x;
	copiedAction->y = y;
	copiedAction->_subtype = _subtype;
	return copiedAction;
}

- (CFAAction *)reversedAction {
	if (_subtype == CFScaleSubtypeDirect) {
		return [self copy];
	}
	CFAScale *copiedAction = [super copyWithZone:NULL];
	copiedAction->x = -y;
	copiedAction->y = -x;
	copiedAction->_subtype = _subtype;
	return copiedAction;
}


- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	float newX = CATransform3DGetAffineTransform(target.transform).a;
	float newY = CATransform3DGetAffineTransform(target.transform).b;

	switch (_subtype) {
		case CFScaleSubtypeDelta:
			if (x != MAXFLOAT) {
				newX += x;
			}
			if (y != MAXFLOAT) {
				newY += y;
			}
			break;
		case CFScaleSubtypeDirect:
			if (x != MAXFLOAT) {
				newX = x;
			}
			if (y != MAXFLOAT) {
				newY = y;
			}
			break;
		default:
			break;
	}
	
	CABasicAnimation *scaleX = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
	scaleX.autoreverses = NO;
	scaleX.fromValue = [target.presentationLayer valueForKey:@"transform.scale.x"];
	scaleX.toValue = [NSNumber numberWithFloat:newX];
	scaleX.fillMode = kCAFillModeForwards;
	scaleX.removedOnCompletion = NO;
	scaleX.cumulative = YES;
	scaleX.timingFunction = self.timingFunction;

	CABasicAnimation *scaleY = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
	scaleY.autoreverses = NO;
	scaleY.fromValue = [target.presentationLayer valueForKey:@"transform.scale.y"];
	scaleY.toValue = [NSNumber numberWithFloat:newY];
	scaleY.fillMode = kCAFillModeForwards;
	scaleY.removedOnCompletion = NO;
	scaleY.cumulative = YES;
	scaleY.timingFunction = self.timingFunction;

	[target addAnimation:scaleX forKey:CFAScaleKeypath];
	[target addAnimation:scaleY forKey:CFAScaleKeypath];
}

@end
