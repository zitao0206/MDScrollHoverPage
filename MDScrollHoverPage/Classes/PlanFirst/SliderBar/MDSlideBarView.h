//
//  MDSlideBarView.h
//
//  Created by Leon0206 on 2020/2/20.
//


#import <UIKit/UIKit.h>

typedef void(^MDSlideBarItemSelectedCallback)(NSUInteger idx);

@interface MDSlideBarView : UIView

@property (nonatomic, assign) NSInteger itemFontSize;
@property (nonatomic, strong) NSArray *itemsTitle;
@property (nonatomic, strong) UIColor *itemColor;
@property (nonatomic, assign) NSInteger itemsWidth;

@property (nonatomic, assign) NSInteger itemSelectedFontSize;
@property (nonatomic, strong) UIColor *itemSelectedColor;

@property (nonatomic, assign) NSTextAlignment itemTextAlignment;

@property (nonatomic, assign) BOOL showSliderView;
@property (nonatomic, strong) UIColor *sliderColor;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;

// Add the callback deal when a slide bar item be selected
- (void)slideBarItemSelectedCallback:(MDSlideBarItemSelectedCallback)callback;
// Set default slide bar item at index to be selected
- (void)setDefaultSlideBarItemIndex:(NSUInteger)index;
// Set the slide bar item at index to be selected
- (void)selectSlideBarItemAtIndex:(NSUInteger)index;

@end
