//
//  CFARunBlockSpec.m
//  CFAAction
//
//  Created by Robert Widmann on 4/23/14.
//  Copyright (c) 2014 CodaFi. All rights reserved.
//

SpecBegin(CFARunBlock)

static CGRect const CFITestLayerRect = (CGRect){ 100, 100, 100, 100 };
__block CFATestLayer *layer = nil;

describe(@"performSelector:onTarget:", ^{
	beforeEach(^{
		layer = CFATestLayer.layer;
		layer.frame = CFITestLayerRect;
	});
	
	it(@"should recieve a selector", ^{
		CFAAction *action = nil;
		
		expect(layer.gotIt).to.beFalsy();
		action = [CFAAction runBlock:^{
			[layer knockKnock];
		}];
		[layer cfa_runAction:action completion:^{
			expect(layer.gotIt).will.beTruthy();
		}];
	});
});


SpecEnd