//
//  MDBottomContentCell.h
//
//  Created by Leon0206 on 2020/4/20.
//


#import "MDBottomContentCell.h"
#import "MDLeftTableViewController.h"
#import "MDRightTableViewController.h"

@interface MDBottomContentCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MDLeftTableViewController *leftTableVC;
@property (nonatomic, strong) MDRightTableViewController *rightTableVC;

@end

@implementation MDBottomContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.scrollView];
    }
    return self;
}

- (void)handleDataWith:(id)data
{
    _leftTableVC = [MDLeftTableViewController new];
    [_leftTableVC handleDataWith:data];
    _rightTableVC = [MDRightTableViewController new];
    [_rightTableVC handleDataWith:data];
    
    [self.scrollView addSubview:_leftTableVC.view];
    [self.scrollView addSubview:_rightTableVC.view];
    
    _leftTableVC.view.frame = CGRectMake(0, 0, ScreenWidth, ContentTableViewHeight);
    _rightTableVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ContentTableViewHeight);
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.isSelectIndex = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 为了横向滑动的时候，外层的tableView不动
    if (!self.isSelectIndex) {
        if (scrollView == self.scrollView) {
            if ([self.delegate respondsToSelector:@selector(containerScrollViewDidScroll:)]) {
                [self.delegate containerScrollViewDidScroll:scrollView];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        if ([self.delegate respondsToSelector:@selector(containerScrollViewDidEndDecelerating:)]) {
            [self.delegate containerScrollViewDidEndDecelerating:scrollView];
        }
    }
}

- (void)setObjectCanScroll:(BOOL)objectCanScroll
{
    _objectCanScroll = objectCanScroll;
    
    self.leftTableVC.vcCanScroll = objectCanScroll;
    self.rightTableVC.vcCanScroll = objectCanScroll;
    
    if (!objectCanScroll) {
        [self.leftTableVC.tableView setContentOffset:CGPointZero animated:NO];
        [self.rightTableVC.tableView setContentOffset:CGPointZero animated:NO];
    }
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentTableViewHeight)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 2, _scrollView.frame.size.height);
    }
    return _scrollView;
}


@end
