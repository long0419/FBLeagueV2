//
//  SaiListViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/9/6.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SaiResultViewController.h"

@interface SaiListViewController : BaseViewController

@property  (nonatomic , strong) UITableView *goodTableView;
@property (nonatomic , strong) NSString *leagueId ;
@property (nonatomic , strong) NSString *from ;

@end
