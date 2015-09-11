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

#pragma mark - draw method
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

- (void)drawPattern:(CGContextRef)context
{
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1].CGColor);
    CGContextFillRect(context, self.bounds);
    
    CGContextSaveGState(context);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);
    CGPatternCallbacks callBacks = {0, &MyDrawPattern, NULL};
    CGPatternRef pattern = CGPatternCreate(NULL, self.bounds, CGAffineTransformIdentity, 24, 24, kCGPatternTilingConstantSpacing, true, &callBacks);
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGContextFillRect(context, self.bounds);
    CGContextRestoreGState(context);
}

void MyDrawPattern(void *info, CGContextRef context)
{
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1].CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1, [UIColor whiteColor].CGColor);
    
    CGContextAddArc(context, 3, 3, 4, 0, M_PI*2, 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, 16, 16, 4, 0, M_PI*2, 0);
    CGContextFillPath(context);
}

#pragma mark -
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect cRect = CGRectMake(50, 50, 100, 50);
    switch (self.type) {
        case GraphicTypeRect:
            [self drawCustomRect:context inRect:cRect];
//            break;
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
            break;
        case GraphicTypePattern:
            [self drawPattern:context];
            break;
        default:
            break;
    }
}

@end
