//
//  CFCAFade.m
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFAFade.h"

static NSString *const CFCAFadeKeypath = @"opacity";

typedef NS_ENUM(int, CFFadeSubtype) {
	CFFadeSubtypeNone = 0,
	CFFadeSubtypeDelta,
	CFFadeSubtypeDirect,
	CFFadeSubtypeIn,
	CFFadeSubtypeOut
};

@implementation CFAFade {
	CGFloat _opacity;
	CFFadeSubtype _subtype;
}

+ (CFAAction *)fadeInWithDuration:(NSTimeInterval)sec {
	CFAFade *fade = (CFAFade *)[CFAFade fadeAlphaTo:1.0f duration:sec];
	fade->_subtype = CFFadeSubtypeIn;
	return fade;
}

+ (CFAAction *)fadeOutWithDuration:(NSTimeInterval)sec {
	CFAFade *fade = (CFAFade *)[CFAFade fadeAlphaTo:0.0f duration:sec];
	fade->_subtype = CFFadeSubtypeOut;
	return fade;
}

+ (CFAAction *)fadeAlphaBy:(CGFloat)factor duration:(NSTimeInterval)sec {
	CFAFade *fadeAnimation = [[CFAFade alloc] init];
	
	fadeAnimation->_opacity = factor;
	fadeAnimation->_subtype = CFFadeSubtypeDelta;
	fadeAnimation.duration = sec;
	
	return fadeAnimation;
}

+ (CFAAction *)fadeAlphaTo:(CGFloat)alpha duration:(NSTimeInterval)sec {
	CFAFade *fadeAnimation = [[CFAFade alloc] init];
	
	fadeAnimation->_opacity = alpha;
	fadeAnimation->_subtype = CFFadeSubtypeDirect;
	fadeAnimation.duration = sec;
	
	return fadeAnimation;
}

- (id)copyWithZone:(NSZone *)zone {
	CFAFade *copiedAction = [super copyWithZone:NULL];
	copiedAction->_opacity = _opacity;
	copiedAction->_subtype = _subtype;
	copiedAction.duration = self.duration;
	return copiedAction;
}

- (CFAAction *)reversedAction {
	if (_subtype == CFFadeSubtypeDirect) {
		return [self copy];
	} else if (_subtype == CFFadeSubtypeIn) {
		return [CFAFade fadeOutWithDuration:self.duration];
	} else if (_subtype == CFFadeSubtypeOut) {
		return [CFAFade fadeInWithDuration:self.duration];
	}
	CFAFade *copiedAction = [super copyWithZone:NULL];
	copiedAction->_opacity = -_opacity;
	copiedAction->_subtype = _subtype;
	copiedAction.duration = self.duration;
	return copiedAction;
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	CGFloat newOpacity = [target.presentationLayer opacity];
	switch (_subtype) {
		case CFFadeSubtypeDelta:
			newOpacity += _opacity;
			break;
		case CFFadeSubtypeOut:
		case CFFadeSubtypeIn:
		case CFFadeSubtypeDirect:
			newOpacity = _opacity;
			break;
		default:
			break;
	}
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:CFCAFadeKeypath];
	animation.removedOnCompletion = NO;
	animation.fillMode = kCAFillModeForwards;
	animation.beginTime = time;
	animation.fromValue = [target.presentationLayer ?: target valueForKeyPath:CFCAFadeKeypath];
	animation.toValue = @(newOpacity);
	animation.duration = self.duration;
	animation.timingFunction = self.timingFunction;
	[animation setDelegate:self];
	[target.presentationLayer ?: target addAnimation:animation forKey:CFCAFadeKeypath];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	self.finished = flag;
}

@end
