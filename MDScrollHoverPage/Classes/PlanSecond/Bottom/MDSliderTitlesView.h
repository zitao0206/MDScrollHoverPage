//
//  MDSliderTitlesView.h
//
//  Created by Leon0206 on 2020/2/20.
//

#import <UIKit/UIKit.h>

@interface MDSliderTitlesView : UIView

- (instancetype)initWithTitleArray:(NSArray *)titleArray;

- (void)setItemSelected:(NSInteger)column;


//点击的第几个按钮
typedef void (^TitleViewClick)(NSInteger);

@property (nonatomic, strong) TitleViewClick titleClickBlock;

@end
