//
//  ChooseAreaViewController.h
//  FBLeague
//
//  Created by long-laptop on 2016/11/23.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ProvinceVo.h"
#import "ChooseCityViewController.h"

@interface ChooseAreaViewController : BaseViewController<UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource>

@property  (nonatomic , strong) UITableView *goodTableView;

@property  (nonatomic , strong) NSString *isfrom; //0.从注册开始 1.从俱乐部开始

@end
