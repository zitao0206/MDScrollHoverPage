//
//  MDSlideBarItem.h
//
//  Created by Leon0206 on 2020/2/20.
//

#import <UIKit/UIKit.h>

@protocol MDSlideBarItemDelegate;

@interface MDSlideBarItem : UIView

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, weak) id<MDSlideBarItemDelegate> delegate;

- (void)setItemTitle:(NSString *)title;
- (void)setItemTitleFont:(CGFloat)fontSize;
- (void)setItemTitleColor:(UIColor *)color;
- (void)setItemSelectedTileFont:(CGFloat)fontSize;
- (void)setItemSelectedTitleColor:(UIColor *)color;
- (void)setItemTextAlignment:(NSTextAlignment)itemTextAlignment;

+ (CGFloat)widthForTitle:(NSString *)title;

@property (copy, nonatomic) NSString *title;

@end

@protocol MDSlideBarItemDelegate <NSObject>

- (void)slideBarItemSelected:(MDSlideBarItem *)item;

@end
