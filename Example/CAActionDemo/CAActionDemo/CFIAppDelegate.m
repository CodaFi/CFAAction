//
//  CFIAppDelegate.m
//  CAActionDemo
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "CFIAppDelegate.h"
#import <CFAAction/CFAAction.h>

@interface CFIAppDelegate ()

@property (nonatomic, strong) CALayer *greenLayer;
@property (nonatomic, strong) CALayer *redLayer;
@property (nonatomic, strong) CALayer *yellowLayer;

@end

@implementation CFIAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	_greenLayer = CALayer.layer;
	_greenLayer.frame =  CGRectMake(-200, NSMidY([self.window.contentView frame]) - 50, 100, 100);
	_greenLayer.backgroundColor = [NSColor.greenColor CGColor];
	_greenLayer.anchorPoint = CGPointMake(0.5, 0.5);
	
	_redLayer = CALayer.layer;
	_redLayer.frame =  CGRectMake(NSMidX([self.window.contentView frame]) - 50, NSMidY([self.window.contentView frame]) - 50, 100, 100);
	_redLayer.backgroundColor = [NSColor.redColor CGColor];
	_redLayer.anchorPoint = CGPointMake(0.5, 0.5);
	
	_yellowLayer = CALayer.layer;
	_yellowLayer.frame =  CGRectMake(850, NSMidY([self.window.contentView frame]) - 50, 100, 100);
	_yellowLayer.backgroundColor = [NSColor.yellowColor CGColor];
	_yellowLayer.anchorPoint = CGPointMake(0.5, 0.5);
	
	[[self.window.contentView layer]addSublayer:_greenLayer];
	[[self.window.contentView layer]addSublayer:_redLayer];
	[[self.window.contentView layer]addSublayer:_yellowLayer];

	CFAAction *moveAction = [CFAAction moveByX:250 y:0 duration:1];
	CFAAction *rotateAction = [CFAAction rotateToAngle:M_PI duration:1];
	CFAAction *scaleAnimation = [CFAAction scaleBy:-0.25 duration:0.25];
	CFAAction *growAnimation = [CFAAction resizeToHeight:400 duration:0.25];

	[self.redLayer runAction:[CFAAction repeatAction:rotateAction count:7] completion:^{
		[self.redLayer runAction:growAnimation];
	}];
	
	[self.greenLayer runAction:[CFAAction waitForDuration:0.5] completion:^{
		[self.greenLayer runAction:[CFAAction sequence:@[ moveAction, [CFAAction repeatAction:rotateAction count:6], growAnimation ]] completion:^{
			[self.greenLayer runAction:[CFAAction group:@[ scaleAnimation ]]];
		}];
	}];
	
	[self.yellowLayer runAction:[CFAAction waitForDuration:0.5] completion:^{
		[self.yellowLayer runAction:[CFAAction sequence:@[ [moveAction reversedAction], [CFAAction repeatAction:rotateAction count:6], growAnimation ]] completion:^{
			[self.yellowLayer runAction:[CFAAction group:@[ scaleAnimation ]]];
		}];
	}];
}

@end
