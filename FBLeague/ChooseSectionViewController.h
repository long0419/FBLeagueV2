//
//  ChooseCityViewController.h
//  FBLeague
//
//  Created by long-laptop on 2016/11/24.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CityVo.h"
@interface ChooseSectionViewController : BaseViewController<UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) NSString *code ;
@property (nonatomic , strong) NSString *provincename ;
@property (nonatomic , strong) NSString *isfrom ;

@property  (nonatomic , strong) UITableView *goodTableView;

@end
