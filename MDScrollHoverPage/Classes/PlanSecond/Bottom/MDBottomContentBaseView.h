//
//  MDBottomContentBaseView.h
//
//  Created by Leon0206 on 2020/2/20.
//

#import <UIKit/UIKit.h>

@interface MDBottomContentBaseView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) NSDictionary *info;

- (void)renderUIWithInfo:(NSDictionary *)info;

@end
