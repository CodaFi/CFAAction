//
//  CFAAction_Private.h
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFAAction.h"

@interface CFAAction ()

@property (nonatomic) BOOL finished;
@property (NS_NONATOMIC_IOSONLY) float repeatCount;
@property (nonatomic) CAMediaTimingFunction *timingFunction;

- (void)executeWithTarget:(CALayer *)target forTime:(NSTimeInterval)time;
- (void)setOnCompletion:(void(^)(void))block;

@end
