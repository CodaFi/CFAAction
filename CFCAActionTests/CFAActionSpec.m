//
//  CFAActionSpec.m
//  CFAAction
//
//  Created by Robert Widmann on 10/17/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

SpecBegin(CFAAction)

__block Class CFAActionClass = Nil;

describe(@"Convenience Initializers", ^{
	before(^{
		CFAActionClass = CFAAction.class;
	});
	
	it(@"should always dispense a subclass for move operations", ^{
		CFAAction *action = nil;
		
		action = [CFAAction moveByX:0 y:0 duration:0];
		expect(action.class).notTo.equal(CFAActionClass);

#if CGVECTOR_DEFINED
		action = [CFAAction moveBy:(CGVector){ 0, 0 } duration:0];
		expect(action.class).notTo.equal(CFAActionClass);
#endif
		
		action = [CFAAction moveTo:(CGPoint){ 0, 0 } duration:0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction moveToX:0 duration:0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction moveToY:0 duration:0];
		expect(action.class).notTo.equal(CFAActionClass);
	});
	
	it(@"should always dispense a subclass for rotate operations", ^{
		CFAAction *action = nil;

		action = [CFAAction rotateByAngle:0 duration: 0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction rotateToAngle:0 duration: 0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction rotateToAngle:0 duration: 0 shortestUnitArc:NO];
		expect(action.class).notTo.equal(CFAActionClass);
	});
	
	it(@"should always dispense a subclass for resize operations", ^{
		CFAAction *action = nil;

		action = [CFAAction resizeByWidth:0 height:0 duration:0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction resizeToWidth:0 height:0 duration:0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction resizeToWidth:0 duration:0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction resizeToHeight:0 duration:0];
		expect(action.class).notTo.equal(CFAActionClass);
	});
	
	it(@"should always dispense a subclass for scale operations", ^{
		CFAAction *action = nil;

		action = [CFAAction scaleBy:0 duration: 0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction scaleXBy:0 y:0 duration: 0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction scaleTo:0 duration: 0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction scaleXTo:0 y:0 duration: 0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction scaleXTo:0 duration: 0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction scaleYTo:0 duration: 0];
		expect(action.class).notTo.equal(CFAActionClass);
	});
	
	it(@"should always dispense a subclass for sequencing and grouping operations", ^{
		CFAAction *action = nil;

		action = [CFAAction sequence:@[]];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction group:@[]];
		expect(action.class).notTo.equal(CFAActionClass);
	});
	
	it(@"should always dispense a subclass for repeat operations", ^{
		CFAAction *action = nil;

		action = [CFAAction repeatAction:[CFAAction scaleBy:0 duration: 0] count:0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction repeatActionForever:[CFAAction scaleBy:0 duration: 0]];
		expect(action.class).notTo.equal(CFAActionClass);

	});
	
	it(@"should always dispense a subclass for fade operations", ^{
		CFAAction *action = nil;

		action = [CFAAction fadeInWithDuration:0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction fadeOutWithDuration:0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction fadeAlphaBy:0 duration:0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction fadeAlphaTo:0 duration:0];
		expect(action.class).notTo.equal(CFAActionClass);
	});
	
	it(@"should always dispense a subclass for path following operations", ^{
		CFAAction *action = nil;

		action = [CFAAction followPath:NULL duration:0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction followPath:NULL asOffset:NO orientToPath:NO duration:0];
		expect(action.class).notTo.equal(CFAActionClass);
	});
	
	it(@"should always dispense a subclass for fade operations", ^{
		CFAAction *action = nil;
		
		action = [CFAAction speedBy:0 duration: 0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction speedTo:0 duration: 0];
		expect(action.class).notTo.equal(CFAActionClass);
	});
	
	it(@"should always dispense a subclass for wait operations", ^{
		CFAAction *action = nil;

		action = [CFAAction waitForDuration:0];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction waitForDuration:0 withRange:0];
		expect(action.class).notTo.equal(CFAActionClass);
	});
	
	it(@"should always dispense a subclass for action operations", ^{
		CFAAction *action = nil;

		action = [CFAAction performSelector:NULL onTarget:nil];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction runBlock:NULL];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction runBlock:NULL queue:NULL];
		expect(action.class).notTo.equal(CFAActionClass);

		action = [CFAAction customActionWithDuration:0 actionBlock:NULL];
		expect(action.class).notTo.equal(CFAActionClass);
	});
});

SpecEnd