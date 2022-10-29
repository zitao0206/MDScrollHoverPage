//
//  MDLeftTableViewController.h
//
//  Created by Leon0206 on 2020/4/20.
//

#import "MDLeftTableViewController.h"

@implementation MDLeftTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}


- (void)handleDataWith:(id)data
{
    [self.tableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
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
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tabCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    tabCell.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    tabCell.accessoryType = UITableViewCellAccessoryNone;
    tabCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        NSString *title = @"TA的唱歌";
        tabCell.textLabel.text = title;
    } else if (indexPath.row == 1) {
        NSString *title = @"你的唱歌";
        tabCell.textLabel.text = title;
    } else {
        NSString *title = @"我的唱歌";
        tabCell.textLabel.text = title;
    }
    return tabCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

@end
