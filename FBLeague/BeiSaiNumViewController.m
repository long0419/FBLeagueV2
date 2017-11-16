//
//  BeiSaiNumViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/11/16.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "BeiSaiNumViewController.h"

@interface BeiSaiNumViewController ()

@end

@implementation BeiSaiNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"323c45"];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"底背景"]];
    image.frame = CGRectMake(0, 20 + 44 , kScreen_Width, 220);
    [self.view addSubview:image];
    
    UIImageView *lang = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"狼队徽-统计分数页面"]];
    lang.frame = CGRectMake(84/2 , 118/2 + 20 + 44 , 158/2, 158/2);
    [self.view addSubview:lang];
    
    UIImageView *hu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"虎队徽-统计分数页面"]];
    hu.frame = CGRectMake(kScreen_Width - 84/2 - 208/2 , 118/2 + 20 + 44, 158/2 , 158/2);
    [self.view addSubview:hu];
    
    UIImageView *vs = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VS-比分用"]];
    vs.frame = CGRectMake((kScreen_Width - 122/2)/2 , 94/2 + 20 + 44 + 15, 122/2 , 160/2);
    [self.view addSubview:vs];
    
    

}

@end
