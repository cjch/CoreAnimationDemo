//
//  UIView+CustomAnimation.h
//  CoreAnimationDemo
//
//  Created by jiechen on 15/9/4.
//  Copyright © 2015年 jch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CustomAnimation)

- (void)moveTo:(CGPoint)point duration:(double)duration options:(UIViewAnimationOptions)options;
- (void)rotateCircleWithDuration:(double)duration options:(UIViewAnimationOptions)options;

- (void)addsubviewWithZoomInAnimation:(UIView *)view duration:(double)duration options:(UIViewAnimationOptions)options;
- (void)removeWithZoomOutAnimation:(double)duration options:(UIViewAnimationOptions)options;

@end
