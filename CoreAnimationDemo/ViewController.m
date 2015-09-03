//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by jiechen on 15/8/30.
//  Copyright © 2015年 jch. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *movingButton;

- (IBAction)onMovingButtonPressed:(UIButton *)sender;
- (IBAction)onButtonPressed:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"CoreAnimationDemo";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - animation
- (IBAction)onButtonPressed:(UIButton *)sender {
    CGRect newFrame = CGRectMake(sender.center.x - self.movingButton.frame.size.width/2, sender.frame.origin.y - self.movingButton.frame.size.height, self.movingButton.frame.size.width, self.movingButton.frame.size.height);
    
    [UIView animateWithDuration:1.0 animations:^{
        self.movingButton.frame = newFrame;
    }];
}

- (IBAction)onMovingButtonPressed:(UIButton *)sender
{
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.movingButton.transform = CGAffineTransformRotate(self.movingButton.transform, M_PI);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            self.movingButton.transform = CGAffineTransformMakeRotation(0);
        }];
    }];
}

@end
