//
//  LayerViewController.m
//  CoreAnimationDemo
//
//  Created by jiechen on 15/9/5.
//  Copyright © 2015年 jch. All rights reserved.
//

#import "LayerViewController.h"
#import "CALayer+CustomAnimation.h"

@interface LayerViewController ()

@property (nonatomic, strong) CALayer *subLayer;
@property (nonatomic, strong) CALayer *groupLayer;

@property (weak, nonatomic) IBOutlet UIButton *animateButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;

@end

@implementation LayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Layer Animation";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view.layer addSublayer:self.subLayer];
    [self.view.layer addSublayer:self.groupLayer];
    //ordinaryly, layer.position == view.center
    NSLog(@"sublayer.position:%@", NSStringFromCGPoint(self.subLayer.position));
    self.subLayer.position = CGPointMake(50, 300);
    
    [self.animateButton addTarget:self action:@selector(onAnimateButton) forControlEvents:UIControlEventTouchUpInside];
    [self.pauseButton addTarget:self action:@selector(onPauseButton) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -
- (IBAction)onAnimateButton
{
    switch (self.animateButton.tag) {
        case 0: // implicitly animation
            [self.subLayer implicitlyAnimateOpacity:0];
            break;
        case 1: //explicitly animation
            [self.subLayer explicitlyAnimateOpacity:1];
            break;
        case 2: // keyFrameAnimation
            [self.subLayer curveKeyFrameAnimation];
            break;
        case 3: // two animations together
        {
            //stop subLayer's animation
            [self.subLayer removeAnimationAndStay];
            
            [self.groupLayer borderChangesGroupAnimation];
            break;
        }
        case 4: // transaction
        {
            [self.view1.layer addTransitionAnimation];
            [self.view2.layer addTransitionAnimation];
            self.view1.hidden = YES;
            self.view2.hidden = NO;
            break;
        }
        default:
            break;
    }
    
    self.animateButton.tag++;
    if (self.animateButton.tag == 5) {
        self.animateButton.tag = 0;
    }
}

- (void)onPauseButton
{
    if (self.pauseButton.tag == 0) {
        self.pauseButton.tag = 1;
        [self.subLayer pauseAnimation];
    }
    else {
        self.pauseButton.tag = 0;
        [self.subLayer resumeAnimation];
    }
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
