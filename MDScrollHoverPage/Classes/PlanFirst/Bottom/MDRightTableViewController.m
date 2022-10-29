//
//  NMLKLeftTableViewController.h
//
//  Created by Leon0206 on 2020/2/20.
//

#import "MDRightTableViewController.h"

@interface MDRightTableViewController ()

@end

@implementation MDRightTableViewController

- (void)handleDataWith:(id)data
{
    [self.tableView reloadData];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!self.vcCanScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) {
        self.vcCanScroll = NO;
        scrollView.contentOffset = CGPointZero;
        //到顶通知父视图改变状态
        [[NSNotificationCenter defaultCenter] postNotificationName:@"md_leave_top" object:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    tabCell.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    tabCell.accessoryType = UITableViewCellAccessoryNone;
    tabCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        NSString *title = @"TA的声音";
        tabCell.textLabel.text = title;
    } else if (indexPath.row == 1) {
        NSString *title = @"你的声音";
        tabCell.textLabel.text = title;
    } else {
        NSString *title = @"我的声音";
        tabCell.textLabel.text = title;
    }
    return tabCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


@end
