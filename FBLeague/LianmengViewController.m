//
//  LianmengViewController.m
//  league
//
//  Created by long-laptop on 2016/11/7.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "LianmengViewController.h"
#import "YCSlideView.h"
#import "FocusViewController.h"
#import "JiaoLianViewController.h"
#import "DongtaiViewController.h"

@interface LianmengViewController ()

@end

@implementation LianmengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动态" ;
    [self setBackBottmAndTitle];
    [self setRightBottom];
    
    JiaoLianViewController *jiaolian = [JiaoLianViewController new] ;
//    jiaolian.delegate = self ;
    
    DongtaiViewController *dongtai = [DongtaiViewController new] ;
//    dongtai.delegate = self ;
    
    FocusViewController *focus = [FocusViewController new];
    
    NSArray *viewControllers = @[@{@"全部动态":dongtai}, @{@"已关注":focus}, @{@"教练员列表":jiaolian}];
    
    YCSlideView * view = [[YCSlideView alloc] initWithFrame:CGRectMake(0, 20 + 44, kScreen_Width, kScreen_Height - 20 - 44) WithViewControllers:viewControllers] ;
    [self.view addSubview:view];
    
}

-(void)setBackBottmAndTitle{
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 22, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"相机2"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(back)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
}

- (void)setRightBottom {
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 17, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(goAction)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.rightBarButtonItem = backItem ;
}

-(void) getScrollIndex :(NSInteger) index {
    
}


-(void)handleSingleTap{
    
}

@end
