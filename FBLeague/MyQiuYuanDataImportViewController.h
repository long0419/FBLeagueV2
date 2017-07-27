//
//  MyQiuYuanDataImportViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/1/3.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BeginTouView.h"
#import "MeView.h"
#import "UserDataVo.h"
#import "ACActionSheet.h"

@interface MyQiuYuanDataImportViewController : BaseViewController<UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource , MeData>

@property (nonatomic , strong) UITableView *tableView ;
@property (nonatomic , strong) NSString *total ;
@property (nonatomic , strong) NSString *role ;

//@property (nonatomic , strong) NSString *dribbling ;
//@property (nonatomic , strong) NSString *speed ;
//@property (nonatomic , strong) NSString *strength ;
//@property (nonatomic , strong) NSString *counterattack ;
//@property (nonatomic , strong) NSString *defend ;
//@property (nonatomic , strong) NSString *pass ;
@property (nonatomic , strong) UserDataVo *vo ;

@end
