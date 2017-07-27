//
//  MyDataImportViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/1/2.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BeginTouView.h"
#import "MeView.h"
#import "UserDataVo.h"
#import "WPAutoSpringTextViewController.h"

@interface MyDataImportViewController : BaseViewController<UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource , MeData>

@property (nonatomic , strong) UITableView *tableView ;
@property (nonatomic , strong) NSString *total ;
@property (nonatomic , strong) NSString *role ;
@property (nonatomic , strong) NSString *count ;

@property (nonatomic , strong) NSString *skill ;
@property (nonatomic , strong) NSString *control ;
@property (nonatomic , strong) NSString *counterattack ;
@property (nonatomic , strong) NSString *stronghand ;
@property (nonatomic , strong) NSString *compete ;
@property (nonatomic , strong) NSString *stimulate ;
@property (nonatomic , strong) NSString *limitSkill ;


@property (nonatomic , strong) NSString *phone ;
@property (nonatomic , strong) NSString *coachPhone ;

@end
