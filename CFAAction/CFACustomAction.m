//
//  CFACustomAction.m
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFACustomAction.h"

@interface CFACustomAction()
    - (void)update;
    - (void)killDisplayLink;
@end

@implementation CFACustomAction {
    __weak CALayer *_target;
    
    CADisplayLink *_displayLink;

    BOOL _started;
    double _frameTimestamp;
    
	void (^_actionBlock)(CALayer *target, CGFloat elapsedTime);
}

+ (CFAAction *)customActionWithDuration:(NSTimeInterval)seconds actionBlock:(void (^)(CALayer *node, CGFloat elapsedTime))block {
    CFACustomAction *action = [[CFACustomAction alloc] init];
    
    action->_actionBlock = [block copy];
    action.duration = seconds;
    
    return action;
}

- (void)dealloc {
//    NSLog(@"dealloc");

    _target = nil;
    [self killDisplayLink];
}

- (id)copyWithZone:(NSZone *)zone {
    CFACustomAction *action = [super copyWithZone:zone];
    action->_actionBlock = [_actionBlock copy];
    action.duration = self.duration;
    
    return action;
}

- (void)update {
    if(_started == NO) {
        return;
    }
    
    double currentTime = _displayLink.timestamp;
    double elapsedTime = currentTime - _frameTimestamp;

    if(elapsedTime < 0) {
        return;
    }
    
    if(elapsedTime >= self.duration) {
        self.finished = YES;
        [self killDisplayLink];
        elapsedTime = self.duration;
    }
    
//    NSLog(@"Updating :: %f. Finished? %i", elapsedTime, self.finished);

    _actionBlock( _target, elapsedTime );
}


- (void)killDisplayLink {
    if(_displayLink != nil) {
        [_displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _displayLink = nil;
    }
}

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time {
//    NSLog(@"Starting.");
    _started = YES;
    
    _target = target;
    _frameTimestamp = time;

    if(_target == nil || _actionBlock == NULL) {
        NSLog(@"Skipping this CFACustomAction since there is no target layer or block associated with it.");

        self.finished = YES;
    }
    else {
        self.finished = NO;

        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }


}

@end
