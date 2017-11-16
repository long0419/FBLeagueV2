//
//  LianSaiViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/7/27.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ZYBannerView.h"
#import "SaiResultViewController.h"
#import "YCSlideView.h"
#import "AddSaiViewController.h"
#import "AddSaiTimeViewController.h"
#import "YBPopupMenu.h"
#import "LianSaiView.h"

@interface LianSaiViewController : BaseViewController <YBPopupMenuDelegate , ZYBannerViewDataSource, ZYBannerViewDelegate, UITextFieldDelegate,UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate, ScrollIndex>


@property (nonatomic, strong) ZYBannerView *banner;
@property (nonatomic, strong) NSArray *dataArray;
@property  (nonatomic , strong) UITableView *goodTableView;
@property (nonatomic, strong) NSString *type ; //用于区分1.联赛 、 2.杯赛

@end
