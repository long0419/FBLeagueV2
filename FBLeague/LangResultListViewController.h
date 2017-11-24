//
//  LangResultListViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/11/18.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SaiChengVo.h"

@interface LangResultListViewController : BaseViewController<UITableViewDelegate , UITableViewDataSource>

@property  (nonatomic , strong) UITableView *goodTableView;
@property  (nonatomic , strong) NSString *leagueId;
@property  (nonatomic , strong) NSString *clubId;
@property  (nonatomic , strong) NSString *camp;
@property  (nonatomic , strong) NSString *areaCode;
@property  (nonatomic , strong) NSString *roundNum;
@property  (nonatomic , strong) SaiChengVo *vo;


@end
