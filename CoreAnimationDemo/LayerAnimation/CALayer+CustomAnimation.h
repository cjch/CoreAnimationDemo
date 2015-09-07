//
//  CALayer+CustomAnimation.h
//  CoreAnimationDemo
//
//  Created by jiechen on 15/9/7.
//  Copyright © 2015年 jch. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (CustomAnimation)

// implicit and explicit animation
- (void)implicitlyAnimateOpacity:(CGFloat)opacity;
- (void)explicitlyAnimateOpacity:(CGFloat)opacity;

// keyFrame and group animation
- (void)curveKeyFrameAnimation;
- (void)borderChangesGroupAnimation;

// transation
- (void)addTransitionAnimation;

// pause and resume animation
- (void)pauseAnimation;
- (void)resumeAnimation;

- (void)removeAnimationAndStay;


@end
