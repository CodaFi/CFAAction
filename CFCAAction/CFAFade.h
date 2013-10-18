//
//  CFCAFade.h
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFAAction+Private.h"

@interface CFAFade : CFAAction

+ (CFAAction *)fadeInWithDuration:(NSTimeInterval)sec;
+ (CFAAction *)fadeOutWithDuration:(NSTimeInterval)sec;
+ (CFAAction *)fadeAlphaBy:(CGFloat)factor duration:(NSTimeInterval)sec;
+ (CFAAction *)fadeAlphaTo:(CGFloat)alpha duration:(NSTimeInterval)sec;

@end
