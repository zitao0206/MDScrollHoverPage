//
//  MDFirstScrollHoverPageViewController.m
//
//  Created by Leon0206 on 2020/2/20.
//

#import "MDFirstScrollHoverPageViewController.h"
#import "MDShellTableView.h"
#import "MDTopContentCell.h"
#import "MDBottomContentCell.h"
#import "MDSlideBarView.h"

@interface MDFirstScrollHoverPageViewController ()<UITableViewDelegate, UITableViewDataSource, MDBottomContentCellDelegate>
@property (nonatomic, strong) MDShellTableView *tableView;
@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, strong) MDTopContentCell *topContentCell;
@property (nonatomic, strong) MDBottomContentCell *bottomContentCell;
@property (nonatomic, strong) MDSlideBarView *sliderSectionView;

@end

@implementation MDFirstScrollHoverPageViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -- initialize and dealloc


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollStatus) name:@"md_leave_top" object:nil];
    
    [self.view addSubview:self.tableView];
   
    self.canScroll = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self handleData];
    });
}

- (void)handleData
{
    NSObject *obj = [NSObject new];
    [self.topContentCell handleDataWith:obj];
    [self.bottomContentCell handleDataWith:obj];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.width = self.view.width;
    self.tableView.top = NavigatorHeight;
    self.tableView.height = TableViewHeight;
}

- (void)changeScrollStatus
{
    self.canScroll = YES;
    self.bottomContentCell.objectCanScroll = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    if (scrollView == self.tableView) {
        
        CGFloat SliderSectionHeightOffset = [self.tableView rectForSection:1].origin.y - 1;
        SliderSectionHeightOffset = floorf(SliderSectionHeightOffset);
        
        if (scrollView.contentOffset.y >= SliderSectionHeightOffset) {
            scrollView.contentOffset = CGPointMake(0, SliderSectionHeightOffset);
            self.bottomContentCell.objectCanScroll = YES;
            self.canScroll = NO;
                
        } else {
            if (self.canScroll) {
                self.bottomContentCell.objectCanScroll = NO;
            } else {
                scrollView.contentOffset = CGPointMake(0, SliderSectionHeightOffset);
            }
        }
    }
}

#pragma mark -- UITableViewDelegate and UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return SliderSectionHeight;
    }
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return self.sliderSectionView;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.topContentCell;
    }
    if (indexPath.section == 1) {
        return self.bottomContentCell;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return TopContentViewHeight;
    }
    if (indexPath.section == 1) {
        return ContentTableViewHeight;
    }
    return 0;
}


#pragma mark -- FloatContainerCellDelegate

- (void)containerScrollViewDidScroll:(UIScrollView *)scrollView
{
    self.tableView.scrollEnabled = NO;
}

- (void)containerScrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger page = scrollView.contentOffset.x / (ScreenWidth);
    [UIView animateWithDuration:0.2 animations:^{
        [self.sliderSectionView selectSlideBarItemAtIndex:page];
    }];
    self.tableView.scrollEnabled = YES;
}

#pragma mark -- setters and getters

- (MDShellTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[MDShellTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth,TableViewHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (MDTopContentCell *)topContentCell
{
    if (!_topContentCell) {
        _topContentCell = [[MDTopContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MDTopContentCell"];
        _topContentCell.clipsToBounds = YES;
        _topContentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _topContentCell.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
    }
    return _topContentCell;
}

- (MDBottomContentCell *)bottomContentCell
{
    if (!_bottomContentCell) {
        _bottomContentCell = [[MDBottomContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MDBottomContentCell"];
        _bottomContentCell.clipsToBounds = YES;
        _bottomContentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _bottomContentCell.delegate = self;
    }
    return _bottomContentCell;
}

- (MDSlideBarView *)sliderSectionView
{
    //滑块部分可任意替换
    if (!_sliderSectionView) {
        NSArray *itemArr = @[@"音乐",@"动态"];
        _sliderSectionView = [[MDSlideBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, SliderSectionHeight)];
        _sliderSectionView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        _sliderSectionView.itemsWidth = 72;
        _sliderSectionView.itemColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        _sliderSectionView.itemFontSize = 16;
        _sliderSectionView.itemSelectedFontSize = 20;
        _sliderSectionView.itemSelectedColor = [UIColor blackColor];
        _sliderSectionView.itemTextAlignment = NSTextAlignmentLeft;
        _sliderSectionView.showSliderView = YES;
        _sliderSectionView.top = 5;
        _sliderSectionView.left = 15;
        _sliderSectionView.itemsTitle = itemArr;
        __weak typeof(self) weakSelf = self;
        [_sliderSectionView slideBarItemSelectedCallback:^(NSUInteger idx) {
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.bottomContentCell.isSelectIndex = YES;
                [weakSelf.bottomContentCell.scrollView setContentOffset:CGPointMake(idx*ScreenWidth, 0) animated:YES];
            }];
        }];
        [_sliderSectionView setDefaultSlideBarItemIndex:0];
    }
    return _sliderSectionView;
}


@end
