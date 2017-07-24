//
//  MemeberDataViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/24.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "MemeberDataViewController.h"
#import "TYMProgressBarView.h"

@interface MemeberDataViewController ()

@end

@implementation MemeberDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    QMUILabel *label1 = [[QMUILabel alloc] init];
    label1.text = @"个人技术";
    label1.font = UIFontMake(12);
    label1.textColor = UIColorBlack ;
    [label1 sizeToFit];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo((18 + 10)/2);
    }];

    
    TYMProgressBarView *progressBarView = [[TYMProgressBarView alloc] initWithFrame:CGRectMake(20, label1.bottom + 20 , kScreen_Width - 40, 10)];
    progressBarView.barBorderWidth = 1.0;
    progressBarView.barBorderColor = [UIColor colorWithHexString:@"ef8645"];
    progressBarView.progress = .8f;
    progressBarView.barFillColor = [UIColor colorWithHexString:@"ef8645"] ;
    [self.view addSubview:progressBarView];
}


@end
