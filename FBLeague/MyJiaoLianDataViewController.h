//
//  MyJiaoLianDataViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/3/12.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BeginTouView.h"
#import "MeView.h"
#import "UserDataVo.h"
#import "ACActionSheet.h"

@interface MyJiaoLianDataViewController : BaseViewController<UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource , MeData>

@property (nonatomic , strong) UITableView *tableView ;
@property (nonatomic , strong) NSString *total ;
@property (nonatomic , strong) NSString *role ;

@property (nonatomic , strong) UserDataVo *vo ;


@end
