//
//  MDFourScrollHoverPageViewController.m
//
//  Created by Leon0206 on 2020/2/20.
//

#import "MDFourScrollHoverPageViewController.h"
#import "MDShellTableView.h"
#import <EasyLayout/EasyLayout.h>

@interface MDFourScrollHoverPageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MDShellTableView *tableView;

@property (nonatomic, strong) UIView *hoverView;

@end

@implementation MDFourScrollHoverPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, NavigatorHeight, self.view.frame.size.width, TopContentViewHeight)];
    topView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = topView;
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.hoverView];

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.hoverView.top = NavigatorHeight + TopContentViewHeight - SliderSectionHeight;
    self.tableView.top = NavigatorHeight;
    self.tableView.height = TableViewHeight;
}

#pragma mark -- UITableViewDelegate and UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger row  = indexPath.row;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",@(row)];
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"-------->%@",@(scrollView.contentOffset.y));

    if (scrollView.contentOffset.y >= 0) {
        if (scrollView.contentOffset.y >= TopContentViewHeight - SliderSectionHeight) {
            self.hoverView.top = NavigatorHeight;
        } else {
            self.hoverView.top = NavigatorHeight + TopContentViewHeight - SliderSectionHeight - scrollView.contentOffset.y;
        }
    } else {
        self.hoverView.top = NavigatorHeight + TopContentViewHeight - SliderSectionHeight - scrollView.contentOffset.y;
    }

}

#pragma mark -- setters and getters

- (UIView*)hoverView
{
    if (!_hoverView) {
        //创建顶部的条
        _hoverView = [[UIView alloc]initWithFrame:CGRectMake(0, NavigatorHeight, self.view.frame.size.width, SliderSectionHeight)];
        _hoverView.backgroundColor = [UIColor greenColor];
    }
    return _hoverView;
}

- (MDShellTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[MDShellTableView alloc]initWithFrame:CGRectMake(0, NavigatorHeight + SliderSectionHeight, self.view.frame.size.width, TableViewHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
