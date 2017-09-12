//
//  JulebuViewController.h
//  league
//
//  Created by long-laptop on 2016/11/7.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CoachChooseTableViewCell.h"
#import "CreateClubViewController.h"
#import "DongtaiViewController.h"
#import "MemberViewController.h"
//#import "SaiChengViewController.h"
#import "ClubVo.h"

@interface JulebuViewController : QMUICommonViewController <UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , strong) UITableView *soTableView;

-(void) gotojiaoLianDetail : (NSString *)phone ;

-(void) gotoQiuDetail : (NSString *)phone ;


@end
