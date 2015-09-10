//
//  GraphicsViewController.m
//  CoreAnimationDemo
//
//  Created by jiechen on 15/9/9.
//  Copyright © 2015年 jch. All rights reserved.
//

#import "GraphicsViewController.h"
#import "CustomView.h"

static NSString * const BasicCellIdentifier = @"BasicCell";

@interface GraphicsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet CustomView *customView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *graphicsArray;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation GraphicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Core Graphics";
    self.selectedIndex = -1;
    self.customView.layer.borderWidth = 0.5;
    self.customView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BasicCellIdentifier];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.graphicsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BasicCellIdentifier];
    cell.textLabel.text = self.graphicsArray[indexPath.row];
    cell.backgroundColor = self.selectedIndex == indexPath.row  ? [UIColor redColor] : [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndex = indexPath.row;
    self.customView.type = indexPath.row + 1;
    [self.tableView reloadData];
}

#pragma mark - getter
- (NSArray *)graphicsArray
{
    if (!_graphicsArray) {
        _graphicsArray = @[@"Rect", @"Ellispe", @"Arc", @"Triangle", @"Curve"];
    }
    return _graphicsArray;
}

@end
