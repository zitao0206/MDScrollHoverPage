//
//  MDSlideBarView.h
//
//  Created by Leon0206 on 2020/2/20.
//

#import "MDSlideBarView.h"
#import "MDSlideBarItem.h"

#define DEVICE_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define DEFAULT_SLIDER_COLOR [UIColor redColor]
#define SLIDER_VIEW_HEIGHT 2

@interface MDSlideBarView () <MDSlideBarItemDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) UIView *sliderView;

@property (strong, nonatomic) MDSlideBarItem *selectedItem;
@property (strong, nonatomic) MDSlideBarItemSelectedCallback callback;
@end

@implementation MDSlideBarView

#pragma mark - Lifecircle
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self= [super initWithFrame:frame]) {
        _items = [NSMutableArray array];
        [self initScrollView];
        [self initSliderView];
    }
    return self;
}

- (void)setItemFontSize:(NSInteger)itemFontSize
{
    _itemFontSize = itemFontSize;
}

#pragma - mark Custom Accessors

- (void)setItemsTitle:(NSArray *)itemsTitle
{
    _itemsTitle = itemsTitle;
    [self setupItems];
}

- (void)setItemColor:(UIColor *)itemColor
{
    _itemColor = itemColor;
    for (MDSlideBarItem *item in _items) {
        [item setItemTitleColor:itemColor];
    }
}

- (void)setItemSelectedFontSize:(NSInteger)itemSelectedFontSize
{
    _itemSelectedFontSize = itemSelectedFontSize;
    for (MDSlideBarItem *item in _items) {
        [item setItemSelectedTileFont:itemSelectedFontSize];
    }
}

- (void)setItemSelectedColor:(UIColor *)itemSelectedColor
{
    _itemSelectedColor = itemSelectedColor;
    for (MDSlideBarItem *item in _items) {
        [item setItemSelectedTitleColor:itemSelectedColor];
    }
}

- (void)setShowSliderView:(BOOL)showSliderView
{
    self.sliderView.hidden = !showSliderView;
}

- (void)setSliderColor:(UIColor *)sliderColor
{
    _sliderColor = sliderColor;
    self.sliderView.backgroundColor = _sliderColor;
}

- (void)setSelectedItem:(MDSlideBarItem *)selectedItem
{
    _selectedItem.selected = NO;
    _selectedItem = selectedItem;
}

- (void)setItemTextAlignment:(NSTextAlignment)itemTextAlignment
{
    _itemTextAlignment = itemTextAlignment;
}

- (void)setLeft:(CGFloat)left
{
    _left = left;
    [self setNeedsLayout];
}

- (void)setTop:(CGFloat)top
{
    _top = top;
    [self setNeedsLayout];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.left = self.left;
    self.scrollView.top = self.top;
}

#pragma - mark Private

- (void)initScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
}

- (void)initSliderView
{
    _sliderView = [[UIView alloc] init];
    _sliderColor = DEFAULT_SLIDER_COLOR;
    _sliderView.layer.masksToBounds = YES;
    _sliderView.layer.cornerRadius = 1;
    _sliderView.backgroundColor = _sliderColor;
    [_scrollView addSubview:_sliderView];
}

- (void)setupItems
{
    CGFloat itemX = 0;
    for (NSString *title in _itemsTitle) {
        MDSlideBarItem *item = [[MDSlideBarItem alloc] init];
        item.delegate = self;
        item.frame = CGRectMake(itemX, 0, _itemsWidth, CGRectGetHeight(_scrollView.frame));
        [item setItemTitle:title];
        if (_itemFontSize > 0) {
            [item setItemTitleColor:_itemColor];
            [item setItemTitleFont:_itemFontSize];
            [item setItemSelectedTitleColor:_itemSelectedColor];
            [item setItemSelectedTileFont:_itemSelectedFontSize];
            [item setItemTextAlignment:_itemTextAlignment];
        }
        [_items addObject:item];
        [_scrollView addSubview:item];
        itemX = CGRectGetMaxX(item.frame);
    }
    _scrollView.contentSize = CGSizeMake(itemX, -30);
}

- (void)scrollToVisibleItem:(MDSlideBarItem *)item
{
    NSInteger selectedItemIndex = [self.items indexOfObject:_selectedItem];
    NSInteger visibleItemIndex = [self.items indexOfObject:item];
    
    if (selectedItemIndex == visibleItemIndex) {
        return;
    }
    CGPoint offset = _scrollView.contentOffset;
    
    if (CGRectGetMinX(item.frame) > offset.x && CGRectGetMaxX(item.frame) < (offset.x + CGRectGetWidth(_scrollView.frame))) {
        return;
    }
    
    // Update the scrollView's contentOffset according to different situation
    if (selectedItemIndex < visibleItemIndex) {
        // The item to be visible is on the right of the selected item and the selected item is out of screeen by the left, also the opposite case, set the offset respectively
        if (CGRectGetMaxX(_selectedItem.frame) < offset.x) {
            offset.x = CGRectGetMinX(item.frame);
        } else {
            offset.x = CGRectGetMaxX(item.frame) - CGRectGetWidth(_scrollView.frame);
        }
    } else {
        // The item to be visible is on the left of the selected item and the selected item is out of screeen by the right, also the opposite case, set the offset respectively
        if (CGRectGetMinX(_selectedItem.frame) > (offset.x + CGRectGetWidth(_scrollView.frame))) {
            offset.x = CGRectGetMaxX(item.frame) - CGRectGetWidth(_scrollView.frame);
        } else {
            offset.x = CGRectGetMinX(item.frame);
        }
    }
    _scrollView.contentOffset = offset;
}

- (void)addAnimationWithSelectedItem:(MDSlideBarItem *)item isYes:(BOOL)isYes
{
    // Caculate the distance of translation
    CGFloat dx = CGRectGetMidX(item.frame) - CGRectGetMidX(_selectedItem.frame);
    CGFloat positionX;//初始位移
    if (isYes) {
        positionX = dx;
    } else {
        positionX = 0;
    }
    // Add the animation about translation
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.x";
    positionAnimation.fromValue = @(_sliderView.layer.position.x+positionX);
    positionAnimation.toValue = @(_sliderView.layer.position.x + dx);
    
    // Add the animation about size
    CABasicAnimation *boundsAnimation = [CABasicAnimation animation];
    boundsAnimation.keyPath = @"bounds.size.width";
    boundsAnimation.fromValue = @(CGRectGetWidth(_sliderView.layer.bounds));
    boundsAnimation.toValue = @(CGRectGetWidth(_sliderView.layer.bounds));
    // Combine all the animations to a group
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[positionAnimation, boundsAnimation];
    animationGroup.duration = 0.2;
    [_sliderView.layer addAnimation:animationGroup forKey:@"basic"];
    
    // Keep the state after animating
    _sliderView.layer.position = CGPointMake(_sliderView.layer.position.x + dx, _sliderView.layer.position.y);
    CGRect rect = _sliderView.layer.bounds;
    CGFloat itemW = [MDSlideBarItem widthForTitle:item.title];
    rect.size.width = itemW;
    _sliderView.layer.bounds = rect;
}

#pragma mark - Public

- (void)slideBarItemSelectedCallback:(MDSlideBarItemSelectedCallback)callback
{
    _callback = callback;
}

- (void)selectSlideBarItemAtIndex:(NSUInteger)index
{
    if (index >= self.items.count) {
        return;
    }
    MDSlideBarItem *item = [self.items objectAtIndex:index];
    if (item == _selectedItem) {
        return;
    }
    
    item.selected = YES;
    [self scrollToVisibleItem:item];
    [self addAnimationWithSelectedItem:item isYes:YES];
    self.selectedItem = item;
}

- (void)setDefaultSlideBarItemIndex:(NSUInteger)index
{
    if (index >= self.items.count) {
        return;
    }
    MDSlideBarItem *item = [self.items objectAtIndex:index];
    if (item == _selectedItem) {
        return;
    }
    item.selected = YES;
    [self scrollToVisibleItem:item];
    [self addAnimationWithSelectedItem:item isYes:YES];
    self.selectedItem = item;
    if (_callback) {
        _callback([self.items indexOfObject:item]);
    }
}

#pragma mark - MDSlideBarViewItemDelegate

- (void)slideBarItemSelected:(MDSlideBarItem *)item
{
    if (item == _selectedItem) {
        return;
    }
    
    [self addAnimationWithSelectedItem:item isYes:NO];
    self.selectedItem = item;
    _callback([self.items indexOfObject:item]);
}

@end
