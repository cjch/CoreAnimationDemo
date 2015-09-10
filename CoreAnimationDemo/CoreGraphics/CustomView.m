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
- (void)drawCustomRect:(CGContextRef)context inRect:(CGRect)rect
{
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, rect);
}

- (void)drawCustomEllispe:(CGContextRef)context inRect:(CGRect)rect
{
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextFillPath(context);
}

- (void)drawCustomArc:(CGContextRef)context
{
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 5);
    CGContextAddArc(context, 100, 100, 50, M_PI/4, M_PI, 0);
    CGContextStrokePath(context);
}

- (void)drawCustomTriangle:(CGContextRef)context
{
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 50, 50);
    CGContextAddLineToPoint(context, 50, 150);
    CGContextAddLineToPoint(context, 150, 150);
    CGContextClosePath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokePath(context);
}

- (void)drawCurve:(CGContextRef)context
{
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 50, 100);
    CGContextAddCurveToPoint(context, 100, 50, 150, 150, 200, 100);
    
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextStrokePath(context);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect cRect = CGRectMake(50, 50, 100, 50);
    switch (self.type) {
        case GraphicTypeRect:
            [self drawCustomRect:context inRect:cRect];
            break;
        case GraphicTypeEllispe:
            [self drawCustomEllispe:context inRect:cRect];
            break;
        case GraphicTypeArc:
            [self drawCustomArc:context];
            break;
        case GraphicTypeTriangle:
            [self drawCustomTriangle:context];
            break;
        case GraphicTypeCurve:
            [self drawCurve:context];
        default:
            break;
    }
}

@end
