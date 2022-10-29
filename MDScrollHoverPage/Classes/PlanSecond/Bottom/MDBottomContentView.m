//
//  MDBottomContentView.m
//
//  Created by Leon0206 on 2020/2/20.
//

#import "MDBottomContentView.h"
#import "MDSliderTitlesView.h"
#import "MDBottomContentBaseView.h"
@interface MDBottomContentView ()<UIScrollViewDelegate>

@property (nonatomic, strong) MDSliderTitlesView *tabTitleView;
@property (nonatomic, strong) UIScrollView *tabContentView;

@end


@implementation MDBottomContentView

- (instancetype)initWithTabConfigArray:(NSArray *)tabConfigarray
{
    if (self = [super initWithFrame:CGRectZero]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, TableViewHeight);
        
        NSMutableArray *titleArray = [NSMutableArray array];
        for (int i = 0; i < tabConfigarray.count ; i++) {
            NSDictionary *dic = tabConfigarray[i];
            [titleArray addObject:dic[@"title"]];
        }
        
        _tabTitleView = [[MDSliderTitlesView alloc] initWithTitleArray:titleArray];
        __weak typeof(self) weakSelf = self;
        _tabTitleView.titleClickBlock = ^(NSInteger num) {
            if (weakSelf.tabContentView) {
                weakSelf.tabContentView.contentOffset = CGPointMake(num * ScreenWidth, 0);
            }
        };
        [self addSubview:_tabTitleView];
        
        //下面的scrollView
        _tabContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tabTitleView.frame), ScreenWidth, CGRectGetHeight(self.frame) - CGRectGetHeight(_tabTitleView.frame))];
        _tabContentView.pagingEnabled = YES;
        _tabContentView.bounces = NO;
        _tabContentView.showsHorizontalScrollIndicator = NO;
        _tabContentView.contentSize = CGSizeMake(ScreenWidth * titleArray.count, 0);
        [self addSubview:_tabContentView];
        _tabContentView.delegate = self;
        
        
        //添加scrollView的内容视图
        for (int i = 0; i < tabConfigarray.count ; i++) {
            
            NSDictionary *dic = tabConfigarray[i];
            NSString * className = dic[@"view"];
            Class class = NSClassFromString(className);
            MDBottomContentBaseView *contentView = [[class alloc] init];
            [contentView renderUIWithInfo:dic];
            [_tabContentView addSubview:contentView];
            
        }
        
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offSetX = scrollView.contentOffset.x;
    NSInteger pageNum = offSetX / ScreenWidth;
    [_tabTitleView setItemSelected:pageNum];
}

@end
