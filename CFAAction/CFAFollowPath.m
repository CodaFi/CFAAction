//
//  CFAFollowPath.m
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAFollowPath.h"
#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
#import "NSBezierPath+CFABezierPathQuartzAssistant.h"
#else
#import <UIKit/UIKit.h>
#endif

static NSString *const CFAFollowPathKeypath = @"position";

@implementation CFAFollowPath {
	CGPathRef _cgPath;
}

+ (CFAAction *)followPath:(CGPathRef)path duration:(NSTimeInterval)sec {
	CFAFollowPath *pathFollowAction = [[CFAFollowPath alloc] init];
	
	pathFollowAction->_cgPath = CGPathRetain(path);
	pathFollowAction.duration = sec;
	
	return pathFollowAction;
}

+ (CFAAction *)followPath:(CGPathRef)path asOffset:(BOOL)offset orientToPath:(BOOL)orient duration:(NSTimeInterval)sec {
	CFAFollowPath *pathFollowAction = [[CFAFollowPath alloc] init];
	
	pathFollowAction->_cgPath = CGPathRetain(path);
	pathFollowAction.duration = sec;
	
	return pathFollowAction;
}

- (id)copyWithZone:(NSZone *)zone {
	CFAFollowPath *copiedAction = [super copyWithZone:NULL];
	copiedAction->_cgPath = CGPathRetain(_cgPath);
	copiedAction.duration = self.duration;
	return copiedAction;
}

- (CFAAction *)reversedAction {
	CFAFollowPath *reversedAction = [super copyWithZone:NULL];
#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
	NSBezierPath *path = [NSBezierPath bezierPath];
	CGPathApply(_cgPath, (__bridge void *)path, CFAPathToBezierApplier);
	reversedAction->_cgPath = path.bezierPathByReversingPath.quartzPath;
#else
	UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:_cgPath];
	reversedAction->_cgPath = CGPathRetain(path.bezierPathByReversingPath.CGPath);
#endif
	reversedAction.duration = self.duration;
	return reversedAction;
}

- (void)dealloc {
	if (_cgPath) {
		CGPathRelease(_cgPath);
	}
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
	CAKeyframeAnimation * pathAnimation = [CAKeyframeAnimation animationWithKeyPath:CFAFollowPathKeypath];
	pathAnimation.path = _cgPath;
	pathAnimation.duration = self.duration;
	pathAnimation.calculationMode = kCAAnimationPaced;
	pathAnimation.beginTime = time;
	pathAnimation.removedOnCompletion = NO;
	pathAnimation.fillMode = kCAFillModeForwards;
	pathAnimation.timingFunction = self.timingFunction;
	[pathAnimation setDelegate:self];
	[target addAnimation:pathAnimation forKey:CFAFollowPathKeypath];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	self.finished = YES;
}

#ifdef __MAC_OS_X_VERSION_MAX_ALLOWED
static void CFAPathToBezierApplier(void *info, const CGPathElement *element) {
	NSBezierPath *path = (__bridge NSBezierPath *)info;
	switch (element->type) {
		case kCGPathElementMoveToPoint:
			[path moveToPoint:element->points[0]];
			break;
			
		case kCGPathElementAddLineToPoint:
			[path lineToPoint:element->points[0]];
			break;
			
		case kCGPathElementAddQuadCurveToPoint:
			[path curveToPoint:element->points[1] controlPoint1:element->points[0] controlPoint2:element->points[0]];
			break;
			
		case kCGPathElementAddCurveToPoint:
			[path curveToPoint:element->points[2] controlPoint1:element->points[0] controlPoint2:element->points[1]];
			break;
			
		case kCGPathElementCloseSubpath:
			[path closePath];
			break;
	}
}
#endif

@end
