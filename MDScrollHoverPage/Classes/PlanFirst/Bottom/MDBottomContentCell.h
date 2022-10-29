//
//  MDBottomContentCell.h
//
//  Created by Leon0206 on 2020/4/20.
//


#import <UIKit/UIKit.h>


@protocol MDBottomContentCellDelegate <NSObject>

@optional
- (void)containerScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)containerScrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end

@interface MDBottomContentCell : UITableViewCell

@property (nonatomic, strong, readonly) UIScrollView *scrollView;

@property (nonatomic, assign) BOOL objectCanScroll;
@property (nonatomic, assign) BOOL isSelectIndex;

@property (nonatomic, weak) id <MDBottomContentCellDelegate> delegate;

- (void)handleDataWith:(id)data;

@end
