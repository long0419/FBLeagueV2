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

@interface LianSaiViewController : BaseViewController <ZYBannerViewDataSource, ZYBannerViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) ZYBannerView *banner;
@property (nonatomic, strong) NSArray *dataArray;

@end
