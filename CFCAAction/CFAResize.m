//
//  CFCAResize.m
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAResize.h"
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
#import <UIKit/UIKit.h>
#endif

static NSString *const CFCAResizeKeypath = @"bounds";

typedef NS_ENUM(int, CFResizeSubtype) {
	CFResizeSubtypeNone = 0,
	CFResizeSubtypeDelta,
	CFResizeSubtypeDirect
};

@implementation CFAResize {
	double width, height;
	CFResizeSubtype _subtype;
}

+ (CFAAction *)resizeByWidth:(CGFloat)width height:(CGFloat)height duration:(NSTimeInterval)duration {
	CFAResize *resizeAction = [[CFAResize alloc] init];
	
	resizeAction->width = width;
	resizeAction->height = height;
	resizeAction.duration = duration;
	resizeAction->_subtype = CFResizeSubtypeDelta;
	
	return resizeAction;
}

+ (CFAAction *)resizeToWidth:(CGFloat)width height:(CGFloat)height duration:(NSTimeInterval)duration {
	CFAResize *resizeAction = [[CFAResize alloc] init];
	
	resizeAction->width = width;
	resizeAction->height = height;
	resizeAction.duration = duration;
	resizeAction->_subtype = CFResizeSubtypeDirect;
	
	return resizeAction;
}

+ (CFAAction *)resizeToWidth:(CGFloat)width duration:(NSTimeInterval)duration {
	return [CFAResize resizeToWidth:width height:MAXFLOAT duration:duration];
}

+ (CFAAction *)resizeToHeight:(CGFloat)height duration:(NSTimeInterval)duration {
	return [CFAResize resizeToWidth:MAXFLOAT height:height duration:duration];
}

- (id)copyWithZone:(NSZone *)zone {
	CFAResize *copiedAction = [super copyWithZone:zone];
	copiedAction->width = width;
	copiedAction->height = height;
	copiedAction->_subtype = _subtype;
	copiedAction.duration = self.duration;
	return copiedAction;
}

- (CFAAction *)reversedAction {
	if (_subtype == CFResizeSubtypeDirect) {
		return [self copy];
	}
	CFAResize *copiedAction = [super copyWithZone:NULL];
	copiedAction->width = -width;
	copiedAction->height = -height;
	copiedAction->_subtype = _subtype;
	return copiedAction;
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	CGRect newFrame = [target.presentationLayer ?:target bounds];
	switch (_subtype) {
		case CFResizeSubtypeDelta:
			if (width != MAXFLOAT)
				newFrame.size.width += width;
			if (height != MAXFLOAT)
				newFrame.size.height += height;
			break;
		case CFResizeSubtypeDirect:
			if (width != MAXFLOAT)
				newFrame.size.width = width;
			if (height != MAXFLOAT)
				newFrame.size.height = height;
			break;
		default:
			break;
	}
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:CFCAResizeKeypath];
	animation.fillMode = kCAFillModeForwards;
	animation.beginTime = time;
	animation.removedOnCompletion = NO;
#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
	animation.fromValue = [NSValue valueWithCGRect:[target.presentationLayer ?:target bounds]];
	animation.toValue = [NSValue valueWithCGRect:newFrame];
#else
	animation.fromValue = [NSValue valueWithRect:[target.presentationLayer ?:target bounds]];
	animation.toValue = [NSValue valueWithRect:newFrame];
#endif
	animation.duration = self.duration;
	animation.repeatCount = self.repeatCount;
	animation.cumulative = YES;
	animation.timingFunction = self.timingFunction;
	[target.presentationLayer ?:target addAnimation:animation forKey:CFCAResizeKeypath];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	self.finished = YES;
}

@end

