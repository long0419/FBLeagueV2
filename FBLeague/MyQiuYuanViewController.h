//
//  MyQiuYuanViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/1/3.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MyQiuYuanDataImportViewController.h"
//#import "ApplyListViewController.h"
#import "MyJiaoLianDataViewController.h"

@interface MyQiuYuanViewController : BaseViewController<UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource>

@property  (nonatomic , strong) UITableView *coachTableView;
@property(nonatomic,strong)NSMutableArray *indexArray;


@end
