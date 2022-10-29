//
//  MDRightTableViewController.h
//
//  Created by Leon0206 on 2020/2/20.
//


#import <UIKit/UIKit.h>

@interface MDRightTableViewController : UITableViewController

@property (nonatomic, assign) BOOL vcCanScroll;

- (void)handleDataWith:(id)data;

@end
