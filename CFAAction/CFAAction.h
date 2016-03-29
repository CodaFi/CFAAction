//
//  CFAAction.h
//  CFAAction
//
//  Created by Robert Widmann on 10/16/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//  Released under the MIT license.
//

#import <QuartzCore/QuartzCore.h>

/// The modes that an action can use to adjust the apparent timing of the action.
typedef NS_ENUM(NSInteger, CFAActionTimingMode) {
	/// Specifies linear pacing. Linear pacing causes an animation to occur evenly over its duration.
	CFAActionTimingLinear,
	/// Specifies ease-in pacing. Ease-in pacing causes the animation to begin slowly, and then
	/// speed up as it progresses.
	CFAActionTimingEaseIn,
	/// Specifies ease-out pacing. Ease-out pacing causes the animation to begin quickly, and then
	/// slow as it completes.
	CFAActionTimingEaseOut,
	/// Specifies ease-in ease-out pacing. An ease-in ease-out animation begins slowly, accelerates
	/// through the middle of its duration, and then slows again before completing.
	CFAActionTimingEaseInEaseOut
};

NS_ASSUME_NONNULL_BEGIN

/// A CFAAction is an action that is executed on a layer.  Actions are most often used to change the
/// structure and appearance of layers, but can also be used to make other changes to the layer tree,
/// or execute custom actions.
///
/// Most actions allow you to change a layer's properties such as its position, rotation, or scale.
/// When an action is animated, the duration property states how long the action takes to complete in
/// seconds, and its timing mode property determines the rate at which the animation executes.
///
/// Many actions can be reversed, allowing you to create another action object that reverses the
/// effect of that action.  Actions that cannot be reversed will often return the same action, or a 
/// copy of the original.
///
/// Some actions include other actions as children:
///
/// - A sequence action has multiple child actions. Each action in the sequence begins after the 
///   previous action ends.
/// - A group action has multiple child actions. All actions stored in the group begin executing at 
///   the same time.
/// - A repeating action stores a single child action. When the child action completes, it is 
///   restarted.
/// - Groups, sequences, and repeating actions can be nested. The ability to combine actions together
///   allows you to add very sophisticated behaviors to a node.
///
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


#pragma mark - Move Actions


/// Creates an action that moves a node relative to its current position.
+ (CFAAction *)moveByX:(CGFloat)deltaX y:(CGFloat)deltaY duration:(NSTimeInterval)sec;

#if CGVECTOR_DEFINED
/// Creates an action that moves a node relative to its current position.
+ (CFAAction *)moveBy:(CGVector)delta duration:(NSTimeInterval)sec;
#endif

/// Creates an action that moves a node to a new position.
+ (CFAAction *)moveTo:(CGPoint)location duration:(NSTimeInterval)sec;

/// Creates an action that moves a node horizontally.
+ (CFAAction *)moveToX:(CGFloat)x duration:(NSTimeInterval)sec;

/// Creates an action that moves a node vertically.
+ (CFAAction *)moveToY:(CGFloat)y duration:(NSTimeInterval)sec;

/// Creates an action that moves the node along a relative path, orienting the node to the path.
+ (CFAAction *)followPath:(CGPathRef)path duration:(NSTimeInterval)sec;

/// Creates an action that moves the node along a path.
+ (CFAAction *)followPath:(CGPathRef)path asOffset:(BOOL)offset orientToPath:(BOOL)orient duration:(NSTimeInterval)sec;


#pragma mark - Rotate Actions


/// Creates an action that rotates the node by a relative value.
+ (CFAAction *)rotateByAngle:(CGFloat)radians duration:(NSTimeInterval)sec;

/// Creates an action that rotates the node counterclockwise to an absolute angle.
+ (CFAAction *)rotateToAngle:(CGFloat)radians duration:(NSTimeInterval)sec;

/// Creates an action that rotates the node to an absolute value.
+ (CFAAction *)rotateToAngle:(CGFloat)radians duration:(NSTimeInterval)sec shortestUnitArc:(BOOL)shortestUnitArc;


#pragma mark - Transparency Actions


/// Creates an action that changes the alpha value of the node to 1.0.
+ (CFAAction *)fadeInWithDuration:(NSTimeInterval)sec;

/// Creates an action that changes the alpha value of the node to 0.0.
+ (CFAAction *)fadeOutWithDuration:(NSTimeInterval)sec;

/// Creates an action that adjusts the alpha value of a node by a relative value.
+ (CFAAction *)fadeAlphaBy:(CGFloat)factor duration:(NSTimeInterval)sec;

/// Creates an action that adjusts the alpha value of a node to a new value.
+ (CFAAction *)fadeAlphaTo:(CGFloat)alpha duration:(NSTimeInterval)sec;


#pragma mark - Resize Actions


/// Creates an action that adjusts the size of a sprite.
+ (CFAAction *)resizeByWidth:(CGFloat)width height:(CGFloat)height duration:(NSTimeInterval)duration;

/// Creates an action that changes the width and height of a sprite to a new absolute value.
+ (CFAAction *)resizeToWidth:(CGFloat)width height:(CGFloat)height duration:(NSTimeInterval)duration;

/// Creates an action that changes the width of a sprite to a new absolute value.
+ (CFAAction *)resizeToWidth:(CGFloat)width duration:(NSTimeInterval)duration;

/// Creates an action that changes the height of a sprite to a new absolute value.
+ (CFAAction *)resizeToHeight:(CGFloat)height duration:(NSTimeInterval)duration;


#pragma mark - Scale Actions


/// Creates an action that changes the x and y scale values of a node by a relative value.
+ (CFAAction *)scaleBy:(CGFloat)scale duration:(NSTimeInterval)sec;

/// Creates an action that adds relative values to the x and y scale values of a node.
+ (CFAAction *)scaleXBy:(CGFloat)xScale y:(CGFloat)yScale duration:(NSTimeInterval)sec;

/// Creates an action that changes the x and y scale values of a node.
+ (CFAAction *)scaleTo:(CGFloat)scale duration:(NSTimeInterval)sec;

/// Creates an action that changes the x and y scale values of a node.
+ (CFAAction *)scaleXTo:(CGFloat)xScale y:(CGFloat)yScale duration:(NSTimeInterval)sec;

/// Creates an action that changes the x scale value of a node to a new value.
+ (CFAAction *)scaleXTo:(CGFloat)scale duration:(NSTimeInterval)sec;

/// Creates an action that changes the y scale value of a node to a new value.
+ (CFAAction *)scaleYTo:(CGFloat)scale duration:(NSTimeInterval)sec;

#pragma mark - Show or Hide Actions

/// Creates an action that hides a node.
+ (CFAAction *)hide;

/// Creates an action that unhides a node.
+ (CFAAction *)unhide;


#pragma mark - Combine Actions


/// Creates an action that runs a collection of actions sequentially.
+ (CFAAction *)sequence:(NSArray *)actions;

/// Creates an action that runs a collection of actions in parallel.
+ (CFAAction *)group:(NSArray *)actions;


#pragma mark - Repeat Actions


/// Creates an action that repeats another action a specified number of times.
+ (CFAAction *)repeatAction:(CFAAction *)action count:(NSUInteger)count;

/// Creates an action that repeats another action forever.
+ (CFAAction *)repeatActionForever:(CFAAction *)action;


#pragma mark - Speed Actions


/// Creates an action that changes how fast the node executes actions by a relative value.
+ (CFAAction *)speedBy:(CGFloat)speed duration:(NSTimeInterval)sec;

/// Creates an action that changes how fast the node executes actions.
+ (CFAAction *)speedTo:(CGFloat)speed duration:(NSTimeInterval)sec;


#pragma mark - Delay Actions


/// Creates an action that idles for a specified period of time.
+ (CFAAction *)waitForDuration:(NSTimeInterval)sec;

/// Creates an action that idles for a randomized period of time.
+ (CFAAction *)waitForDuration:(NSTimeInterval)sec withRange:(NSTimeInterval)durationRange;


#pragma mark - Custom Actions


/// Creates an action that calls a method on an object.
+ (CFAAction *)performSelector:(SEL)selector onTarget:(id)target;

/// Creates an action that executes a block.
+ (CFAAction *)runBlock:(dispatch_block_t)block;

/// Creates an action that executes a block on a specific dispatch queue.
+ (CFAAction *)runBlock:(dispatch_block_t)block queue:(dispatch_queue_t)queue;

/// Creates an action that executes a block over a duration.
+ (CFAAction *)customActionWithDuration:(NSTimeInterval)seconds actionBlock:(void (^)(CALayer *node, CGFloat elapsedTime))block;

@end

@interface CALayer (CFAAction)

/// Adds an action to the list of actions executed by the node.
- (void)cfa_runAction:(CFAAction *)action;

/// Adds an action to the list of actions executed by the node. Your block is called when the action
/// completes.
- (void)cfa_runAction:(CFAAction *)action completion:(void (^)(void))block;

@end

NS_ASSUME_NONNULL_END
