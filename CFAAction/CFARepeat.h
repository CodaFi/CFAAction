//
//  CFARepeat.h
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAAction+Private.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFARepeat : CFAAction

+ (CFAAction *)repeatAction:(CFAAction *)action count:(NSUInteger)count;
+ (CFAAction *)repeatActionForever:(CFAAction *)action;

@end

NS_ASSUME_NONNULL_END
