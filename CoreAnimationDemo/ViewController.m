//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by jiechen on 15/8/30.
//  Copyright © 2015年 jch. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CustomAnimation.h"

static int CurveValues[] = {
    UIViewAnimationOptionCurveEaseInOut,
    UIViewAnimationOptionCurveEaseIn,
    UIViewAnimationOptionCurveEaseOut,
    UIViewAnimationOptionCurveLinear
};

static NSString *const CellID = @"CellID";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *movingButton;

- (IBAction)onMovingButtonPressed:(UIButton *)sender;
- (IBAction)onButtonPressed:(UIButton *)sender;
- (IBAction)onCurvePickerButtonPressed:(UIButton *)sender;

@property (nonatomic, strong) UITableView *pickerTableView;
@property (nonatomic, strong) NSArray *curveList;
@property (nonatomic, assign) NSInteger selectedCurveIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"CoreAnimationDemo";
    
    self.selectedCurveIndex = 0;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.curveList.count;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = self.curveList[indexPath.row];
    cell.accessoryType = indexPath.row == self.selectedCurveIndex ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    if (indexPath.row != self.selectedCurveIndex) {
        UITableViewCell *pcell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:self.selectedCurveIndex inSection:0]];
        pcell.accessoryType = UITableViewCellAccessoryNone;
        self.selectedCurveIndex = indexPath.row;
    }
    
    [tableView removeWithZoomOutAnimation:1.0 options:CurveValues[self.selectedCurveIndex]];
}

- (NSString *)tableView:(nonnull UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Select the Animation Curve to be used";
}

- (NSString *)tableView:(nonnull UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"Curves will not affect total duration, but instant speed and acceleration";
}

#pragma mark - event response
- (IBAction)onButtonPressed:(UIButton *)sender {
    [self.movingButton moveTo:CGPointMake(sender.center.x - self.movingButton.frame.size.width/2, sender.frame.origin.y - self.movingButton.frame.size.height) duration:1.0 options:CurveValues[self.selectedCurveIndex]];
}

- (IBAction)onCurvePickerButtonPressed:(id)sender {
    if ([self.pickerTableView superview]) {
        [self.pickerTableView removeFromSuperview];
    }
    
    [self.view addsubviewWithZoomInAnimation:self.pickerTableView duration:1 options:CurveValues[self.selectedCurveIndex]];
}

- (IBAction)onMovingButtonPressed:(UIButton *)sender
{
    [self.movingButton rotateCircleWithDuration:1.0 options:CurveValues[self.selectedCurveIndex]];
}

#pragma mark - setter and getter
- (UITableView *)pickerTableView
{
    if (!_pickerTableView) {
        _pickerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 300, 300) style:UITableViewStyleGrouped];
        _pickerTableView.center = self.view.center;
        _pickerTableView.delegate = self;
        _pickerTableView.dataSource = self;
        _pickerTableView.layer.cornerRadius = 10;
        _pickerTableView.layer.masksToBounds = YES;
    }
    return _pickerTableView;
}

- (NSArray *)curveList
{
    if (!_curveList) {
        _curveList = @[@"EaseInOut", @"EaseIn", @"EaseOut", @"Linear"];
    }
    
    return _curveList;
}

@end
