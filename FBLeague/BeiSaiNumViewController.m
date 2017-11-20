//
//  BeiSaiNumViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/11/16.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "BeiSaiNumViewController.h"
#import "DSLLoginTextField.h"
#import "PPNumberButton.h"
#import "LangResultListViewController.h"
#import "HuResultListViewController.h"

@interface BeiSaiNumViewController (){
    DSLLoginTextField *fen1 ;
    DSLLoginTextField *fen2 ;
    PPNumberButton *slider ;
}

@end

@implementation BeiSaiNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"虎啸狼吼贺岁杯" ;
    self.view.backgroundColor = [UIColor colorWithHexString:@"323c45"];
    
    [self setBackBottmAndTitle];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"底背景"]];
    image.frame = CGRectMake(0, 20 + 44 , kScreen_Width, 220);
    [self.view addSubview:image];
    
    UIImageView *lang = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"狼队徽-统计分数页面"]];
    lang.frame = CGRectMake(84/2 , 118/2 + 20 + 44 , 158/2, 158/2);
    [self.view addSubview:lang];
    
    UIImageView *hu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"虎队徽-统计分数页面"]];
    hu.frame = CGRectMake(kScreen_Width - 84/2 - 158/2 , 118/2 + 20 + 44, 158/2 , 158/2);
    [self.view addSubview:hu];
    
    UIImageView *vs = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VS-队徽用"]];
    vs.frame = CGRectMake((kScreen_Width - 122/2)/2 , 94/2 + 20 + 44 + 15, 122/2 , 160/2);
    [self.view addSubview:vs];
    
    
    fen1=[[DSLLoginTextField alloc]init];
    fen1.frame = CGRectMake(50 , image.bottom + 50 , 40, 40) ;
    fen1.textColor = [UIColor blackColor] ;
    fen1.backgroundColor = [UIColor whiteColor] ;
    fen1.font=[UIFont systemFontOfSize:14];
    fen1.maxTextLength= 2 ;
    fen1.delegate = self ;
    fen1.keyboardType = UIKeyboardTypeNumberPad;
    fen1.tag = 10 ;
    fen1.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:fen1];
    
    
    fen2=[[DSLLoginTextField alloc]init];
    fen2.frame = CGRectMake(kScreen_Width - 40 - 50 , image.bottom + 50 , 40, 40) ;
    fen2.textColor = [UIColor blackColor] ;
    fen2.backgroundColor = [UIColor whiteColor];
    fen2.font=[UIFont systemFontOfSize:14];
    fen2.maxTextLength= 2 ;
    fen2.delegate = self ;
    fen2.tag = 11 ;
    fen2.keyboardType = UIKeyboardTypeNumberPad;
    fen2.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:fen2];
    
    UIImageView *bifen = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VS-比分用"]];
    bifen.frame = CGRectMake((kScreen_Width - 72/2) , fen1.top, 72/2, 96/2);
    [self.view addSubview:bifen];
    
    QMUILabel *name3 = [[QMUILabel alloc] init];
    name3.text = @"请对你的赛球方的综合素质评分:";
    name3.font = UIFontMake(12);
    name3.textColor = UIColorWhite ;
    [name3 sizeToFit];
    [self.view addSubview:name3];
    name3.origin = CGPointMake((kScreen_Width - name3.size.width)/2 , fen2.bottom + 20);
    
    slider = [PPNumberButton numberButtonWithFrame:CGRectMake((kScreen_Width - 280)/2 , name3.bottom + 40 , 280.f, 44.f)];
    //设置边框颜色
    slider.borderColor = [UIColor grayColor];
    slider.increaseTitle = @"＋";
    slider.decreaseTitle = @"－";
    slider.maxValue = 10 ;
    slider.minValue = 1 ;
    slider.rawValue = 5 ;
    slider.resultBlock = ^(NSString *num){

    };
    [self.view addSubview:slider];
    
    QMUIButton *button = [[QMUIButton alloc] init];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(37/2);
    button.frame = CGRectMake(30 , slider.bottom + 100 , kScreen_Width - 60 , 40) ;
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithHexString:@"5a70d6"] ;
    button.highlightedBackgroundColor = [UIColor colorWithHexString:@"5a70d6"];    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(submitSaiResult) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交赛果" forState:UIControlStateNormal];
    [self.view addSubview:button];

    
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

@end
