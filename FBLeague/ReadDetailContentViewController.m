//
//  ReadDetailContentViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/2/16.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "ReadDetailContentViewController.h"

@interface ReadDetailContentViewController (){
    NSString *title ;
    NSString *content ;
}

@end

@implementation ReadDetailContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"" ;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f6f7"];
    
    [self setBackBottmAndTitle];

    
    self.uview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 44 - 20)];
    [self.view addSubview:self.uview];
    
    NSString *urlx = getDepositProtocol ;
    if ([_type isEqualToString:@"2"]) {
        urlx = getCoachProtocol ;
    }
    
    NSURL *url = [NSURL URLWithString:urlx];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.uview.scalesPageToFit = YES;
    [self.uview loadRequest:request];
    
    
    
}


@end