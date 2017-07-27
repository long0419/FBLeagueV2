//
//  SearchClubViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/7/20.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SearchClubViewController : BaseViewController <UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView *soTableView;
@property (nonatomic , strong) NSMutableArray *soGoods ;

-(void) searchClubByContent :(NSArray *) contents ;

@end
