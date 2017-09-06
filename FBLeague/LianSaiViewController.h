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

@interface LianSaiViewController : BaseViewController <ZYBannerViewDataSource, ZYBannerViewDelegate, UITextFieldDelegate,UITableViewDelegate , UITableViewDataSource , UIScrollViewDelegate, ScrollIndex>


@property (nonatomic, strong) ZYBannerView *banner;
@property (nonatomic, strong) NSArray *dataArray;
@property  (nonatomic , strong) UITableView *goodTableView;

@end
