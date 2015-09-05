//
//  UIView+CustomAnimation.m
//  CoreAnimationDemo
//
//  Created by jiechen on 15/9/4.
//  Copyright © 2015年 jch. All rights reserved.
//

#import "UIView+CustomAnimation.h"

@implementation UIView (CustomAnimation)

- (void)moveTo:(CGPoint)point duration:(double)duration options:(UIViewAnimationOptions)options
{
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished){
        
    }];
}

- (void)rotateCircleWithDuration:(double)duration options:(UIViewAnimationOptions)options
{
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.transform = CGAffineTransformRotate(self.transform, M_PI);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:duration animations:^{
            self.transform = CGAffineTransformMakeRotation(0);
        }];
    }];
}

- (void)addsubviewWithZoomInAnimation:(UIView *)view duration:(double)duration options:(UIViewAnimationOptions)options
{
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [self addSubview:view];
    
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        view.transform = CGAffineTransformMakeScale(1, 1);
    } completion:nil];
}

- (void)removeWithZoomOutAnimation:(double)duration options:(UIViewAnimationOptions)options
{
    [UIView animateWithDuration:duration delay:0 options:options animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
