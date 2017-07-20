//
//  FocusViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/7/8.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVPullToRefresh.h"
#import "BaseViewController.h"
#import "CoachChooseTableViewCell.h"
#import "BaseTableViewController.h"
#import "JiaoLianViewController.h"

@interface FocusViewController : BaseViewController<UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource , focusAction>

@property  (nonatomic , strong) UITableView *coachTableView;

@property(nonatomic,strong)NSMutableArray *indexArray;

@property(nonatomic,strong)id<goToJiaoLianDetail> delegate;


@end
