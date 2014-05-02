//
//  CFARunBlock.h
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import "CFAAction+Private.h"

@interface CFARunBlock : CFAAction

+ (CFAAction *)runBlock:(dispatch_block_t)block;
+ (CFAAction *)runBlock:(dispatch_block_t)block queue:(dispatch_queue_t)queue;

@end
