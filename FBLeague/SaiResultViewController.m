//
//  SaiResultViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/4.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "SaiResultViewController.h"
#import "StepSlider.h"

@interface SaiResultViewController ()

@end

@implementation SaiResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"323c45"];
    
    UIImageView *bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"liansai-bg"]];
    bg.frame = CGRectMake(0, 0, kScreen_Width, 220) ;
    [self.view addSubview:bg];
    
    [self setBackBottmAndTitle];
    
    StepSlider *slider = [[StepSlider alloc] initWithFrame:CGRectMake((kScreen_Width - 300)/2 , bg.bottom + 20 , 300.f, 44.f)];
    slider.labels = @[@"1", @"2", @"3", @"4"
                      , @"5", @"6", @"7", @"8", @"9", @"10"];
    [slider setMaxCount:10];
    [slider setIndex:1];
    [self.view addSubview:slider];
    
}

-(void)setBackBottmAndTitle{
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 17, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(back)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
