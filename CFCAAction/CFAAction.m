//
//  CFAAction.m
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAAction.h"
#import "CFARunBlock.h"
#import "CFASequence.h"
#import "CFAGroup.h"
#import "CFACustomAction.h"
#import "CFAFade.h"
#import "CFAFollowPath.h"
#import "CFAMove.h"
#import "CFAPerformSelector.h"
#import "CFARotate.h"
#import "CFAResize.h"
#import "CFARepeat.h"
#import "CFAScale.h"
#import "CFASpeed.h"
#import "CFAWait.h"

@implementation CFAAction {
	BOOL _finished;
	void (^_completionBlock)(void);
}

- (id)copyWithZone:(NSZone *)zone {
	CFAAction *copyAction = [[self.class alloc] init];
	copyAction.duration = self.duration;
	copyAction.timingMode = self.timingMode;
	copyAction.speed = self.speed;
	
	return copyAction;
}

- (CFAAction *)reversedAction {
	return [self copy];
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time { }

- (void)setOnCompletion:(void(^)(void))block {
	_completionBlock = [block copy];
}

- (void)setFinished:(BOOL)finished {
	if (finished && _completionBlock) {
		_completionBlock();
	}
	_finished = finished;
}

- (CAMediaTimingFunction *)timingFunction {
	return [CAMediaTimingFunction functionWithName:CFAMediaTimingFunctionName[self.timingMode]];
}

static NSString * CFAMediaTimingFunctionName[4] = {
	@"linear",   // CFCActionTimingLinear
	@"easeIn",   // CFCActionTimingEaseIn
	@"easeOut",  // CFCActionTimingEaseOut
	@"easeInOut" // CFCActionTimingEaseInEaseOut
};

@end

@implementation CFAAction (CFAActions)

+ (CFAAction *)moveByX:(CGFloat)deltaX y:(CGFloat)deltaY duration:(NSTimeInterval)sec {
	return [CFAMove moveByX:deltaX y:deltaY duration:sec];
}

#if CGVECTOR_DEFINED
+ (CFAAction *)moveBy:(CGVector)delta duration:(NSTimeInterval)sec {
	return [CFAMove moveBy:delta  duration:sec];
}
#endif

+ (CFAAction *)moveTo:(CGPoint)location duration:(NSTimeInterval)sec {
	return [CFAMove moveTo:location duration:sec];
}

+ (CFAAction *)moveToX:(CGFloat)x duration:(NSTimeInterval)sec {
	return [CFAMove moveToX:x duration:sec];
}

+ (CFAAction *)moveToY:(CGFloat)y duration:(NSTimeInterval)sec {
	return [CFAMove moveToY:y duration:sec];
}

+ (CFAAction *)rotateByAngle:(CGFloat)radians duration:(NSTimeInterval)sec {
	return [CFARotate rotateByAngle:radians duration:sec];
}

+ (CFAAction *)rotateToAngle:(CGFloat)radians duration:(NSTimeInterval)sec {
	return [CFARotate rotateToAngle:radians duration:sec];
}

+ (CFAAction *)rotateToAngle:(CGFloat)radians duration:(NSTimeInterval)sec shortestUnitArc:(BOOL)shortestUnitArc {
	return [CFARotate rotateToAngle:radians duration:sec shortestUnitArc:shortestUnitArc];
}

+ (CFAAction *)resizeByWidth:(CGFloat)width height:(CGFloat)height duration:(NSTimeInterval)duration {
	return [CFAResize resizeByWidth:width height:height duration:duration];
}

+ (CFAAction *)resizeToWidth:(CGFloat)width height:(CGFloat)height duration:(NSTimeInterval)duration {
	return [CFAResize resizeToWidth:width height:height duration:duration];
}

+ (CFAAction *)resizeToWidth:(CGFloat)width duration:(NSTimeInterval)duration {
	return [CFAResize resizeToWidth:width duration:duration];
}

+ (CFAAction *)resizeToHeight:(CGFloat)height duration:(NSTimeInterval)duration {
	return [CFAResize resizeToHeight:height duration:duration];
}

+ (CFAAction *)scaleBy:(CGFloat)scale duration:(NSTimeInterval)sec {
	return [CFAScale scaleBy:scale duration:sec];
}

+ (CFAAction *)scaleXBy:(CGFloat)xScale y:(CGFloat)yScale duration:(NSTimeInterval)sec {
	return [CFAScale scaleXBy:xScale y:yScale duration:sec];
}

+ (CFAAction *)scaleTo:(CGFloat)scale duration:(NSTimeInterval)sec {
	return [CFAScale scaleTo:scale duration:sec];
}

+ (CFAAction *)scaleXTo:(CGFloat)xScale y:(CGFloat)yScale duration:(NSTimeInterval)sec {
	return [CFAScale scaleXTo:xScale y:yScale duration:sec];
}

+ (CFAAction *)scaleXTo:(CGFloat)scale duration:(NSTimeInterval)sec {
	return [CFAScale scaleXTo:scale duration:sec];
}

+ (CFAAction *)scaleYTo:(CGFloat)scale duration:(NSTimeInterval)sec {
	return [CFAScale scaleYTo:scale duration:sec];
}

+ (CFAAction *)sequence:(NSArray *)actions {
	return [CFASequence sequenceWithActions:actions];
}

+ (CFAAction *)group:(NSArray *)actions {
	return [CFAGroup groupWithActions:actions];
}

+ (CFAAction *)repeatAction:(CFAAction *)action count:(NSUInteger)count {
	return [CFARepeat repeatAction:action count:count];
}

+ (CFAAction *)repeatActionForever:(CFAAction *)action {
	return [CFARepeat repeatActionForever:action];
}

+ (CFAAction *)fadeInWithDuration:(NSTimeInterval)sec {
	return [CFAFade fadeInWithDuration:sec];
}

+ (CFAAction *)fadeOutWithDuration:(NSTimeInterval)sec {
	return [CFAFade fadeOutWithDuration:sec];
}

+ (CFAAction *)fadeAlphaBy:(CGFloat)factor duration:(NSTimeInterval)sec {
	return [CFAFade fadeAlphaBy:factor duration:sec];
}

+ (CFAAction *)fadeAlphaTo:(CGFloat)alpha duration:(NSTimeInterval)sec {
	return [CFAFade fadeAlphaTo:alpha duration:sec];
}

+ (CFAAction *)followPath:(CGPathRef)path duration:(NSTimeInterval)sec {
	return [CFAFollowPath followPath:path duration:sec];
}

+ (CFAAction *)followPath:(CGPathRef)path asOffset:(BOOL)offset orientToPath:(BOOL)orient duration:(NSTimeInterval)sec {
	return [CFAFollowPath followPath:path asOffset:offset orientToPath:orient duration:sec];
}

+ (CFAAction *)speedBy:(CGFloat)speed duration:(NSTimeInterval)sec {
	return [CFASpeed speedBy:speed duration:sec];
}

+ (CFAAction *)speedTo:(CGFloat)speed duration:(NSTimeInterval)sec {
	return [CFASpeed speedTo:speed duration:sec];
}

+ (CFAAction *)waitForDuration:(NSTimeInterval)sec {
	return [CFAWait waitForDuration:sec];
}

+ (CFAAction *)waitForDuration:(NSTimeInterval)sec withRange:(NSTimeInterval)durationRange {
	return [CFAWait waitForDuration:sec withRange:durationRange];
}

+ (CFAAction *)performSelector:(SEL)selector onTarget:(id)target {
	return [CFAPerformSelector performSelector:selector onTarget:target];
}

+ (CFAAction *)runBlock:(dispatch_block_t)block {
	return [CFARunBlock runBlock:block queue:NULL];
}

+ (CFAAction *)runBlock:(dispatch_block_t)block queue:(dispatch_queue_t)queue {
	return [CFARunBlock runBlock:block queue:queue];
}

+ (CFAAction *)customActionWithDuration:(NSTimeInterval)seconds actionBlock:(void (^)(CALayer *node, CGFloat elapsedTime))block {
	return [CFACustomAction customActionWithDuration:seconds actionBlock:block];
}

@end

@implementation CALayer (CFAAction)

- (void)runAction:(CFAAction *)action {
	[action executeWithTarget:self forTime:CACurrentMediaTime()];
}

- (void)runAction:(CFAAction *)action completion:(void (^)(void))block {
	[action setOnCompletion:block];
	[action executeWithTarget:self forTime:CACurrentMediaTime()];
}

@end