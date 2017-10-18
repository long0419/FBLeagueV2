//
//  BaseViewController.m
//  CarManager
//
//  Created by JinXin on 15/12/9.
//  Copyright © 2015年 droidgle. All rights reserved.
//

#import "BaseViewController.h"
#import "GTMBase64.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
        
    [self refreshStatusBar];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置界面背景颜色 和 titile 的属性
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"ffffff"],NSForegroundColorAttributeName ,[UIFont systemFontOfSize:18] ,NSFontAttributeName ,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    self.view.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarItemClicked{
    NSLog(@"\ntabBarItemClicked : %@", NSStringFromClass([self class]));
}

-(void)setBackBottmAndTitle{
    
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 17, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(back)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
}

-(void)setBackBottmAndTitle2{
    
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 17, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(back)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
}


- (void)setBackTitle : (NSString *) title  andWithSize : (CGFloat) size andWithColor :(NSString *) color {
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:size andContent:title];
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, titleSize.width, titleSize.height) ;
    [backViewBtn setTitle:title forState:UIControlStateNormal];
    [backViewBtn setTitleColor:[UIColor colorWithHexString:color]forState:UIControlStateNormal];
    backViewBtn.titleLabel.font = [UIFont systemFontOfSize: size];
    [backViewBtn addTarget:self action: @selector(back)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
    
}

-(void) back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) forbiddenGesture {
    self.fd_interactivePopDisabled = YES ;
}

- (void) goGesture {
    self.fd_interactivePopDisabled = NO ;
}

#pragma mark- UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

- (void) showTabBottom {
    self.tabBarController.tabBar.hidden=NO;
}

- (void) hideTabBottom {
    self.tabBarController.tabBar.hidden=YES;
}


@end
