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

@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
// end-0, animating 1, pause 2
@property (nonatomic, assign) int animationState;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@property (weak, nonatomic) IBOutlet UIButton *animateButton;
- (IBAction)onbutton:(UIButton *)sender;

@end

@implementation LayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Layer Animation";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.pauseButton addTarget:self action:@selector(onPauseButton) forControlEvents:UIControlEventTouchUpInside];
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
        case 4:
            [self transitionAnimation];
            break;
        default:
            break;
    }
    
    sender.tag++;
    if (sender.tag == 5) {
        sender.tag = 0;
    }
}

- (void)onPauseButton
{
    if (self.animationState == 1) {
        self.animationState = 2;
        CFTimeInterval pausedTime = [self.subLayer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.subLayer.speed = 0;
        self.subLayer.timeOffset = pausedTime;
    }
    else if (self.animationState == 2){
        self.animationState = 1;
        CFTimeInterval pausedTime = [self.subLayer timeOffset];
        self.subLayer.speed = 1;
        self.subLayer.timeOffset = 0;
        self.subLayer.beginTime = 0;
        
        CFTimeInterval timeSincePause = [self.subLayer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
        self.subLayer.beginTime = timeSincePause;
    }
}

#pragma mark - layer animation
- (void)AnimationOpacityFrom:(CGFloat)from to:(CGFloat)to
{
    self.subLayer.opacity = to;
    CABasicAnimation *fadeA = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeA.fromValue = @(from);
    fadeA.toValue = @(to);
    fadeA.duration = 2;
    [self.subLayer addAnimation:fadeA forKey:@"opacity"];

}

- (void)keyFrameAnimation
{
    self.animationState = 1;
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

- (void)transitionAnimation
{
    CATransition *transition = [CATransition animation];
    transition.startProgress = 0;
    transition.endProgress = 1;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    transition.duration = 2;
    
    [self.view1.layer addAnimation:transition forKey:@"transition"];
    [self.view2.layer addAnimation:transition forKey:@"transition"];
    
    self.view1.hidden = YES;
    self.view2.hidden = NO;
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
        _groupLayer.frame = CGRectMake(50, 350, 100, 100);
        _groupLayer.borderColor = [UIColor blackColor].CGColor;
        _groupLayer.borderWidth = 5;
        _groupLayer.cornerRadius = 5;
        
        /// perspective, set zPosition and parentLayer's sublayerTransform
        //   |     subLayer.zPosition
        //   |-----------|------------(eyePosition)
        //   |
        CGFloat zPosition = 40;
        CGFloat eyePosition = 100;
        CALayer *zLayer = [CALayer layer];
        zLayer.backgroundColor = [UIColor blueColor].CGColor;
        zLayer.frame = CGRectMake(0, 0, 25, 25);
        zLayer.position = CGPointMake(50, 50);
        zLayer.zPosition = zPosition;
        [_groupLayer addSublayer:zLayer];
        
        CATransform3D pers = CATransform3DIdentity;
        pers.m34 = -1.0 / eyePosition;
        _groupLayer.sublayerTransform = pers;
    }
    return _groupLayer;
}

@end
