//
//  CALayer+CustomAnimation.m
//  CoreAnimationDemo
//
//  Created by jiechen on 15/9/7.
//  Copyright © 2015年 jch. All rights reserved.
//

#import "CALayer+CustomAnimation.h"
#import <UIKit/UIKit.h>

@implementation CALayer (CustomAnimation)

- (void)implicitlyAnimateOpacity:(CGFloat)opacity
{
    self.opacity = opacity;
}

- (void)explicitlyAnimateOpacity:(CGFloat)opacity
{
    CGFloat oldOpacity = self.opacity;
    self.opacity = opacity;
    CABasicAnimation *fadeA = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeA.fromValue = @(oldOpacity);
    fadeA.toValue = @(opacity);
    fadeA.duration = 2;
    [self addAnimation:fadeA forKey:@"opacity"];
}

- (void)curveKeyFrameAnimation
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 300);
    CGPathAddCurveToPoint(path, NULL, 50, 100, 150, 100, 150, 300);
    CGPathAddCurveToPoint(path, NULL, 150, 100, 300, 100, 300, 300);
    
    CAKeyframeAnimation *keyA = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyA.path = path;
    keyA.duration = 5;
    
    [self addAnimation:keyA forKey:@"position"];
}

- (void)borderChangesGroupAnimation
{
    CAKeyframeAnimation *keyAniation1 = [CAKeyframeAnimation animationWithKeyPath:@"borderWidth"];
    keyAniation1.values = @[@1, @10, @5, @30, @0.5, @15, @2, @50, @0];
    keyAniation1.calculationMode = kCAAnimationPaced;
    
    CAKeyframeAnimation *keyAniation2 = [CAKeyframeAnimation animationWithKeyPath:@"borderColor"];
    keyAniation2.values = @[(id)[UIColor redColor].CGColor, (id)[UIColor greenColor].CGColor, (id)[UIColor blueColor].CGColor];
    keyAniation2.calculationMode = kCAAnimationPaced;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[keyAniation1, keyAniation2];
    group.duration = 5;
    [self addAnimation:group forKey:@"BorderChanges"];
}

- (void)addTransitionAnimation
{
    CATransition *transition = [CATransition animation];
    transition.startProgress = 0;
    transition.endProgress = 1;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    transition.duration = 2;
    
    [self addAnimation:transition forKey:@"transition"];
}

- (void)pauseAnimation
{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0;
    self.timeOffset = pausedTime;
}

- (void)resumeAnimation
{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1;
    self.timeOffset = 0;
    NSLog(@"beginTime = %f", self.beginTime);
    NSLog(@"time: %f", [self convertTime:CACurrentMediaTime() fromLayer:nil]);
    // reset beginTime = 0 with 2 reason:
    // 1 currentMediaTime is related to beginTime
    // 2 adjust time in multiple pause-resume case
    self.beginTime = 0;
    NSLog(@"time: %f", [self convertTime:CACurrentMediaTime() fromLayer:nil]);
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

- (void)removeAnimationAndStay
{
    [self removeAllAnimations];
    CALayer *currentLayer = self.presentationLayer;
    self.position = currentLayer.position;
}

@end
