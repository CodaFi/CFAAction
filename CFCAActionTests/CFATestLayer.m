//
//  CFATestLayer.m
//  CFAAction
//
//  Created by Robert Widmann on 4/23/14.
//  Copyright (c) 2014 CodaFi. All rights reserved.
//

#import "CFATestLayer.h"

@implementation CFATestLayer {
	CGRect _frame;
}

- (void)knockKnock {
	self.gotIt = YES;
}

- (void)setFrame:(CGRect)frame {
	_frame = frame;
}

- (CGRect)frame {
	return _frame;
}

@end
