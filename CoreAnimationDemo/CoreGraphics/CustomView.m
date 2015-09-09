//
//  CustomView.m
//  CoreAnimationDemo
//
//  Created by jiechen on 15/9/9.
//  Copyright © 2015年 jch. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (void)setType:(GraphicType)type {
    _type = type;
    [self setNeedsDisplay];
}

#pragma mark -draw method
- (void)drawCustomRect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, CGRectMake(50, 50, 50, 50));
}

- (void)drawCustomCircle
{
    
}

- (void)drawCustomArc
{
    
}

- (void)drawRect:(CGRect)rect
{
    switch (self.type) {
        case GraphicTypeRect:
            [self drawCustomRect];
            break;
        case GraphicTypeCirCle:
            [self drawCustomCircle];
            break;
        case GraphicTypeArc:
            [self drawCustomArc];
            break;
        default:
            break;
    }
}

@end
