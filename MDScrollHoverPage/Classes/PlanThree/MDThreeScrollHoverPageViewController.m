//
//  MDThreeScrollHoverPageViewController.m
//
//  Created by Leon0206 on 2020/2/20.
//

#import "MDThreeScrollHoverPageViewController.h"
#import "MDSlideBarView.h"

@interface MDThreeScrollHoverPageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MDSlideBarView *sliderSectionView;

@end

@implementation MDThreeScrollHoverPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.sliderSectionView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  
    if (scrollView.contentOffset.y > TopContentViewHeight) {
        [self.sliderSectionView removeFromSuperview];
        self.sliderSectionView.frame = CGRectMake(0, NavigatorHeight, ScreenWidth, SliderSectionHeight);
        [self.view addSubview:self.sliderSectionView];
        
    } else {
        [self.sliderSectionView removeFromSuperview];
        self.sliderSectionView.frame = CGRectMake(0, TopContentViewHeight, ScreenWidth, SliderSectionHeight);
        [self.scrollView addSubview:self.sliderSectionView];
    }
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
 
}


#pragma mark -- setters and getters

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavigatorHeight, ScreenWidth, TableViewHeight)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(ScreenWidth, 1000);
        _scrollView.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.3];
    }
    return _scrollView;
}

- (MDSlideBarView *)sliderSectionView
{
    //滑块部分可任意替换
    if (!_sliderSectionView) {
        NSArray *itemArr = @[@"第一"];
        _sliderSectionView = [[MDSlideBarView alloc] initWithFrame:CGRectMake(0, TopContentViewHeight, ScreenWidth, SliderSectionHeight)];
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
//                weakSelf.bottomContentCell.isSelectIndex = YES;
                [weakSelf.scrollView setContentOffset:CGPointMake(idx*ScreenWidth, 0) animated:YES];
            }];
        }];
        [_sliderSectionView setDefaultSlideBarItemIndex:0];
    }
    return _sliderSectionView;
}


@end
