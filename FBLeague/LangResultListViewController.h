//
//  LangResultListViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/11/18.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LangResultListViewController : BaseViewController<UITableViewDelegate , UITableViewDataSource>

@property  (nonatomic , strong) UITableView *goodTableView;

@end
