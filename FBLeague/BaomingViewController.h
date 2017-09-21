//
//  BaomingViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/9/6.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaomingViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong) NSString *leagueId ;
@property  (nonatomic , strong) UITableView *goodTableView;

@end
