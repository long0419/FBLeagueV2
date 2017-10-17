//
//  QiuYuanDataDetailViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/10/17.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "JHRadarChart.h"
#import "QiuYuanVo.h"
#import "UserDataVo.h"
#import "CommonFunc.h"
#import "CoachVo.h"
#import "ExplainView.h"

@interface QiuYuanDataDetailViewController : BaseViewController<UIAlertViewDelegate,UITableViewDelegate , UITableViewDataSource>

@property (nonatomic, strong) NSString *qPhone ;


@end
