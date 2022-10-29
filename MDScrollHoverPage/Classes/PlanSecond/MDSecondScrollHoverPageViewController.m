//
//  MDSecondScrollHoverPageViewController.m
//
//  Created by Leon0206 on 2020/2/20.
//

#import "MDSecondScrollHoverPageViewController.h"
#import "MDBottomContentView.h"
#import "MDShellTableView.h"

@interface MDSecondScrollHoverPageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) MDShellTableView *tableView;

@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, assign) BOOL isTopCanNotMoveTableView;
@property (nonatomic, assign) BOOL isTopCanNotMoveTableViewPre;

@end

@implementation MDSecondScrollHoverPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMes:) name:TABLELEAVETOP object:nil];
}

//titleView
- (void)acceptMes:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSString *canScroll = userInfo[@"canScroll"];
    if ([canScroll isEqualToString:@"1"]) {
        _canScroll = YES;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    CGFloat height = 0;
    if (section == 0) {
        height = TopContentViewHeight;
    } else {
        height = TableViewHeight;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger section  = indexPath.section;
    
    if (section == 0) {
        UILabel *textlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, CGRectGetWidth(self.view.frame), 60)];
        [cell.contentView addSubview:textlabel];
        cell.contentView.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.3];
        textlabel.text = @"上部区域";
        textlabel.textAlignment = NSTextAlignmentCenter;
    } else {
        NSArray *tabConfigArray = @[@{
                                        @"title":@"第一个",
                                        @"view":@"PicAndTextIntroduceView",
                                        @"data":@"图文介绍的数据",
                                        @"position":@0
                                        },@{
                                        @"title":@"第二个",
                                        @"view":@"ItemDetailView",
                                        @"data":@"商品详情的数据",
                                        @"position":@1
                                        },@{
                                        @"title":@"第三个",
                                        @"view":@"CommentView",
                                        @"data":@"评价的数据",
                                        @"position":@2
                                        }];
        MDBottomContentView *tabView = [[MDBottomContentView alloc] initWithTabConfigArray:tabConfigArray];
        [cell.contentView addSubview:tabView];
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat tableViewOffsetY = [_tableView rectForSection:1].origin.y;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    
    _isTopCanNotMoveTableViewPre = _isTopCanNotMoveTableView;
    
    if (contentOffsetY >= tableViewOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tableViewOffsetY);
        _isTopCanNotMoveTableView = YES;
    }else{
        _isTopCanNotMoveTableView = NO;
    }
    
    if (_isTopCanNotMoveTableViewPre != _isTopCanNotMoveTableView) {
        if (_isTopCanNotMoveTableView && !_isTopCanNotMoveTableViewPre) {
            [[NSNotificationCenter defaultCenter] postNotificationName:TABLETOP object:nil userInfo:@{@"canScroll": @"1"}];
            _canScroll = NO;
        }
        
        if (_isTopCanNotMoveTableViewPre && !_isTopCanNotMoveTableView) {//轻
            if (!_canScroll) {
                scrollView.contentOffset = CGPointMake(0, tableViewOffsetY);
            }
            
        }
        
    }
    
}

#pragma mark -- setters and getters

- (MDShellTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[MDShellTableView alloc] initWithFrame:CGRectMake(0, NavigatorHeight, ScreenWidth,TableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

@end
