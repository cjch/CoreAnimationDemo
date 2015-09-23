//
//  CustomView.h
//  CoreAnimationDemo
//
//  Created by jiechen on 15/9/9.
//  Copyright © 2015年 jch. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GraphicType)
{
    GraphicTypeNone,
    GraphicTypeRect,
    GraphicTypeEllispe,
    GraphicTypeArc,
    GraphicTypeTriangle,
    GraphicTypeCurve,
    GraphicTypePattern,
    GraphicTypeText
};
@interface CustomView : UIView

@property (nonatomic, assign) GraphicType type;

@end
