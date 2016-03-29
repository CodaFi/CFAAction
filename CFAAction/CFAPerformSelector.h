//
//  CFAPerformSelector.h
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAAction+Private.h"

NS_ASSUME_NONNULL_BEGIN

@interface CFAPerformSelector : CFAAction

+ (CFAAction *)performSelector:(SEL)selector onTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
