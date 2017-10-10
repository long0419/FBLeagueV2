//
//  ApplyListViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/3/10.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CoachChooseTableViewCell.h"

@interface ApplyListViewController : BaseViewController<UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource ,focusAction>

@property  (nonatomic , strong) UITableView *coachTableView;
@property(nonatomic,strong)NSMutableArray *indexArray;


@end
