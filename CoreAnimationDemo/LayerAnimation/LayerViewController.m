//
//  LayerViewController.m
//  CoreAnimationDemo
//
//  Created by jiechen on 15/9/5.
//  Copyright © 2015年 jch. All rights reserved.
//

#import "LayerViewController.h"

@interface LayerViewController ()

@property (nonatomic, strong) CALayer *subLayer;
@property (nonatomic, strong) CALayer *groupLayer;

@property (weak, nonatomic) IBOutlet UIButton *animateButton;
- (IBAction)onbutton:(UIButton *)sender;

@end

@implementation LayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Layer Animation";
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view.layer addSublayer:self.subLayer];
    [self.view.layer addSublayer:self.groupLayer];
    //ordinaryly, layer.position == view.center
    NSLog(@"sublayer.position:%@", NSStringFromCGPoint(self.subLayer.position));
    self.subLayer.position = CGPointMake(50, 300);
}

- (IBAction)onbutton:(UIButton *)sender {
    switch (sender.tag) {
        case 0: // implicitly animation
            self.subLayer.opacity = 0;
            break;
        case 1: //explicitly animation
            [self AnimationOpacityFrom:0 to:1];
            break;
        case 2: // keyFrameAnimation
            [self keyFrameAnimation];
            break;
        case 3: // two animations together
        {
            //stop subLayer's animation
            [self.subLayer removeAllAnimations];
            CALayer *currentLayer = self.subLayer.presentationLayer;
            self.subLayer.position = currentLayer.position;
            
            [self groupAnimation];
            break;
        }
        default:
            break;
    }
    
    sender.tag++;
    if (sender.tag == 4) {
        sender.tag = 0;
    }
}

#pragma mark - layer animation
- (void)AnimationOpacityFrom:(CGFloat)from to:(CGFloat)to
{
    self.subLayer.opacity = to;
    CABasicAnimation *fadeA = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeA.fromValue = @(from);
    fadeA.toValue = @(to);
    fadeA.duration = 5.0;
    [self.subLayer addAnimation:fadeA forKey:@"opacity"];

}

- (void)keyFrameAnimation
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 300);
    CGPathAddCurveToPoint(path, NULL, 50, 100, 150, 100, 150, 300);
    CGPathAddCurveToPoint(path, NULL, 150, 100, 300, 100, 300, 300);
    
    CAKeyframeAnimation *keyA = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyA.path = path;
    keyA.duration = 5;
    
    [self.subLayer addAnimation:keyA forKey:@"position"];
}

- (void)groupAnimation
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
    [self.groupLayer addAnimation:group forKey:@"BorderChanges"];
}

#pragma mark - setter and getter
- (CALayer *)subLayer
{
    if (!_subLayer) {
        _subLayer = [CALayer layer];
        _subLayer.backgroundColor = [UIColor orangeColor].CGColor;
        _subLayer.cornerRadius = 25;
        _subLayer.frame = CGRectMake(50, 300, 50, 50);
        _subLayer.shadowOffset = CGSizeMake(2, 5);
        _subLayer.shadowOpacity = 0.8;
        _subLayer.shadowRadius = 5;
        _subLayer.contents = (id)[UIImage imageNamed:@"arrow"].CGImage;
    }
    return _subLayer;
}

- (CALayer *)groupLayer
{
    if (!_groupLayer) {
        _groupLayer = [CALayer layer];
        _groupLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _groupLayer.frame = CGRectMake(50, 400, 200, 200);
        _groupLayer.borderColor = [UIColor blackColor].CGColor;
        _groupLayer.borderWidth = 5;
        _groupLayer.cornerRadius = 5;
    }
    return _groupLayer;
}

@end
