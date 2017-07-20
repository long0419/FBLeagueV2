//
//  JiaoLianViewController.h
//  FBLeague
//
//  Created by long-laptop on 2016/12/10.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVPullToRefresh.h"
#import "BaseViewController.h"
#import "CoachChooseTableViewCell.h"
#import "BaseTableViewController.h"

@protocol goToJiaoLianDetail <NSObject>

-(void) gotoDetail : (NSString *)phone ;

@end


@interface JiaoLianViewController : BaseViewController<UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource , focusAction>


@property  (nonatomic , strong) UITableView *coachTableView;

@property(nonatomic,strong)NSMutableArray *indexArray;

@property(nonatomic,strong)id<goToJiaoLianDetail> delegate;

@end
