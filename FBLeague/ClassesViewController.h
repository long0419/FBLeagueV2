//
//  ClassesViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/7/24.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CoachChooseTableViewCell.h"
#import "JulebuViewController.h"

@interface ClassesViewController : BaseViewController<UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView *soTableView;

@end
