//
//  CFAAction.h
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, CFAActionTimingMode) {
	CFCActionTimingLinear,
	CFCActionTimingEaseIn,
	CFCActionTimingEaseOut,
	CFCActionTimingEaseInEaseOut
};

/**
 * A CFAAction is an action that is executed on a layer.  Actions are most often used to change the
 * structure and appearance of layers, but can also be used to make other changes to the layer tree,
 * or execute custom actions.
 *
 * Most actions allow you to change a layer's properties such as its position, rotation, or scale.
 * When an action is animated, the duration property states how long the action takes to complete in
 * seconds, and its timing mode property determines the rate at which the animation executes.
 *
 * Many actions can be reversed, allowing you to create another action object that reverses the
 * effect of that action.  Actions that cannot be reversed will often return the same action, or a 
 * copy of the original.
 *
 * Some actions include other actions as children:
 *
 * - A sequence action has multiple child actions. Each action in the sequence begins after the 
 *   previous action ends.
 * - A group action has multiple child actions. All actions stored in the group begin executing at 
 *   the same time.
 * - A repeating action stores a single child action. When the child action completes, it is 
 *   restarted.
 * - Groups, sequences, and repeating actions can be nested. The ability to combine actions together
 *   allows you to add very sophisticated behaviors to a node.
 */
@interface CFAAction : NSObject <NSCopying>

/// The duration required to complete an action.
@property (NS_NONATOMIC_IOSONLY) NSTimeInterval duration;

/// The timing mode used to execute an action.
@property (NS_NONATOMIC_IOSONLY) CFAActionTimingMode timingMode;

/// A speed factor that modifies how fast an action runs.
@property (NS_NONATOMIC_IOSONLY) CGFloat speed;

/// Creates an action that reverses the behavior of another action.
- (CFAAction *)reversedAction;

@end

@interface CFAAction (CFAActions)

+ (CFAAction *)moveByX:(CGFloat)deltaX y:(CGFloat)deltaY duration:(NSTimeInterval)sec;
#if CGVECTOR_DEFINED
+ (CFAAction *)moveBy:(CGVector)delta duration:(NSTimeInterval)sec;
#endif
+ (CFAAction *)moveTo:(CGPoint)location duration:(NSTimeInterval)sec;
+ (CFAAction *)moveToX:(CGFloat)x duration:(NSTimeInterval)sec;
+ (CFAAction *)moveToY:(CGFloat)y duration:(NSTimeInterval)sec;

+ (CFAAction *)rotateByAngle:(CGFloat)radians duration:(NSTimeInterval)sec;
+ (CFAAction *)rotateToAngle:(CGFloat)radians duration:(NSTimeInterval)sec;
+ (CFAAction *)rotateToAngle:(CGFloat)radians duration:(NSTimeInterval)sec shortestUnitArc:(BOOL)shortestUnitArc;

+ (CFAAction *)resizeByWidth:(CGFloat)width height:(CGFloat)height duration:(NSTimeInterval)duration;
+ (CFAAction *)resizeToWidth:(CGFloat)width height:(CGFloat)height duration:(NSTimeInterval)duration;
+ (CFAAction *)resizeToWidth:(CGFloat)width duration:(NSTimeInterval)duration;
+ (CFAAction *)resizeToHeight:(CGFloat)height duration:(NSTimeInterval)duration;

+ (CFAAction *)scaleBy:(CGFloat)scale duration:(NSTimeInterval)sec;
+ (CFAAction *)scaleXBy:(CGFloat)xScale y:(CGFloat)yScale duration:(NSTimeInterval)sec;
+ (CFAAction *)scaleTo:(CGFloat)scale duration:(NSTimeInterval)sec;
+ (CFAAction *)scaleXTo:(CGFloat)xScale y:(CGFloat)yScale duration:(NSTimeInterval)sec;
+ (CFAAction *)scaleXTo:(CGFloat)scale duration:(NSTimeInterval)sec;
+ (CFAAction *)scaleYTo:(CGFloat)scale duration:(NSTimeInterval)sec;

+ (CFAAction *)sequence:(NSArray *)actions;

+ (CFAAction *)group:(NSArray *)actions;

+ (CFAAction *)repeatAction:(CFAAction *)action count:(NSUInteger)count;
+ (CFAAction *)repeatActionForever:(CFAAction *)action;

+ (CFAAction *)fadeInWithDuration:(NSTimeInterval)sec;
+ (CFAAction *)fadeOutWithDuration:(NSTimeInterval)sec;
+ (CFAAction *)fadeAlphaBy:(CGFloat)factor duration:(NSTimeInterval)sec;
+ (CFAAction *)fadeAlphaTo:(CGFloat)alpha duration:(NSTimeInterval)sec;

+ (CFAAction *)followPath:(CGPathRef)path duration:(NSTimeInterval)sec;
+ (CFAAction *)followPath:(CGPathRef)path asOffset:(BOOL)offset orientToPath:(BOOL)orient duration:(NSTimeInterval)sec;

+ (CFAAction *)speedBy:(CGFloat)speed duration:(NSTimeInterval)sec;
+ (CFAAction *)speedTo:(CGFloat)speed duration:(NSTimeInterval)sec;

+ (CFAAction *)waitForDuration:(NSTimeInterval)sec;
+ (CFAAction *)waitForDuration:(NSTimeInterval)sec withRange:(NSTimeInterval)durationRange;

+ (CFAAction *)performSelector:(SEL)selector onTarget:(id)target;

+ (CFAAction *)runBlock:(dispatch_block_t)block;
+ (CFAAction *)runBlock:(dispatch_block_t)block queue:(dispatch_queue_t)queue;

+ (CFAAction *)customActionWithDuration:(NSTimeInterval)seconds actionBlock:(void (^)(CALayer *node, CGFloat elapsedTime))block;

@end

@interface CALayer (CFAAction)

/// Adds an action to the list of actions executed by the node.
- (void)runAction:(CFAAction *)action;

/// Adds an action to the list of actions executed by the node. Your block is called when the action
/// completes.
- (void)runAction:(CFAAction *)action completion:(void (^)(void))block;

@end