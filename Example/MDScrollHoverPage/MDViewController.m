//
//  MDViewController.m
//  MDScrollHoverPage
//
//  Created by Leon0206 on 07/28/2021.
//  Copyright (c) 2021 Leon0206. All rights reserved.
//

#import "MDViewController.h"
#import "MDFirstScrollHoverPageViewController.h"
#import "MDSecondScrollHoverPageViewController.h"
#import "MDThreeScrollHoverPageViewController.h"
#import "MDFourScrollHoverPageViewController.h"

@interface MDViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView  alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.title = @"悬停方案";
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!contentCell) {
        contentCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    contentCell.backgroundColor = [UIColor lightGrayColor];
    contentCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (0 == indexPath.row) {
        contentCell.textLabel.text = @"方案一";
    }
    if (1 == indexPath.row) {
        contentCell.textLabel.text = @"方案二";
    }
    if (2 == indexPath.row) {
        contentCell.textLabel.text = @"方案三";
    }
    if (3 == indexPath.row) {
        contentCell.textLabel.text = @"方案四";
    }
    return contentCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row) {
        MDFirstScrollHoverPageViewController *vc = [MDFirstScrollHoverPageViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (1 == indexPath.row) {
        MDSecondScrollHoverPageViewController *vc = [MDSecondScrollHoverPageViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (2 == indexPath.row) {
        MDThreeScrollHoverPageViewController *vc = [MDThreeScrollHoverPageViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (3 == indexPath.row) {
        MDFourScrollHoverPageViewController *vc = [MDFourScrollHoverPageViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
