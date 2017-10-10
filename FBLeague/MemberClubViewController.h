//
//  MemberClubViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/10/9.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SVPullToRefresh.h"
#import "CoachVo.h"
#import "MGSwipeTableCell.h"

@interface MemberClubViewController : BaseViewController <UIAlertViewDelegate, UITableViewDelegate , UITableViewDataSource , MGSwipeTableCellDelegate>

@property (nonatomic , strong) UITableView *soTableView;

@end
