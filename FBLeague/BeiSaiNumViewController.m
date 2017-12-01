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
#import "LianSaiView.h"

@interface BeiSaiNumViewController (){
    DSLLoginTextField *fen1 ;
    DSLLoginTextField *fen2 ;
    PPNumberButton *slider ;
    NSString *ravalue ;
    YYCache *cache ;
    UserDataVo *uvo ;
}

@end

@implementation BeiSaiNumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
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
    
    
    UITapGestureRecognizer *call1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(call:)];
    UIView *detail1 = [LianSaiView getDetailView:@"1" andWithNum:_vo.homeclubphone andWithClubName: [CommonFunc textFromBase64String:_vo.homeclubname] andWithPoint:CGPointMake(30, lang.bottom + 10)];
    detail1.accessibilityHint = _vo.homeclubphone ;
    [detail1 addGestureRecognizer:call1];
    [self.view addSubview:detail1];
    
    UITapGestureRecognizer *call2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(call:)];
    UIView *detail2 = [LianSaiView getDetailView:@"2" andWithNum:_vo.visitingclubphone andWithClubName: [CommonFunc textFromBase64String:_vo.visitingclubname] andWithPoint:CGPointMake(kScreen_Width - 30 - 230/2 , lang.bottom + 10)];
    detail2.accessibilityHint = _vo.visitingclubphone ;
    [detail2 addGestureRecognizer:call2];
    [self.view addSubview:detail2];

    
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
    bifen.frame = CGRectMake((kScreen_Width - 72/2)/2 , fen1.top, 72/2, 96/2);
    [self.view addSubview:bifen];
    
    QMUILabel *name3 = [[QMUILabel alloc] init];
    name3.text = @"请对你的赛球方的综合素质评分:";
    name3.font = UIFontMake(12);
    name3.textColor = UIColorWhite ;
    [name3 sizeToFit];
    [self.view addSubview:name3];
    name3.origin = CGPointMake((kScreen_Width - name3.size.width)/2 , fen2.bottom + 20);
    
    ravalue = @"5" ;
    slider = [PPNumberButton numberButtonWithFrame:CGRectMake((kScreen_Width - 280)/2 , name3.bottom + 40 , 280.f, 44.f)];

    slider.borderColor = [UIColor grayColor];
    slider.increaseTitle = @"＋";
    slider.decreaseTitle = @"－";
    slider.maxValue = 10 ;
    slider.minValue = 1 ;
    slider.rawValue = 5 ;
    slider.resultBlock = ^(NSString *num){
        ravalue = num ;
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
    
    if ([_vo.hasplayed isEqualToString:@"y"]) {
        if([_vo.matchstatus isEqualToString:@"1"]){
            if (([_vo.homesubmit isEqualToString:@"<null>"] || [_vo.homesubmit isEqualToString:@""]) && [_vo.homeclub isEqualToString:uvo.club]) {
                button.hidden = NO ;
            }else if(([_vo.visitingsubmit isEqualToString:@"<null>"] || [_vo.visitingsubmit isEqualToString:@""])  && [_vo.visitingclub isEqualToString:uvo.club]){
                button.hidden = NO ;
            }else{
                if (![_vo.homesubmit isEqualToString:@"<null>"]
                    && ![_vo.homesubmit isEqualToString:@""]) {//当前主队提交了比分
                    if ([_vo.homeclub isEqualToString:uvo.club] ) {
                        NSArray *fen = [_vo.homesubmit componentsSeparatedByString:@":"] ;
                        fen1.text = [fen objectAtIndex:0] ;
                        fen2.text = [fen objectAtIndex:1] ;
                        slider.rawValue = [_vo.homeeva integerValue] ;
                        button.hidden = YES ;
                        fen1.userInteractionEnabled = NO ;
                        fen2.userInteractionEnabled = NO ;
                        slider.userInteractionEnabled = NO ;
                    }else{
                        NSArray *fen = [_vo.homesubmit componentsSeparatedByString:@":"] ;
                        fen1.text = [fen objectAtIndex:0] ;
                        fen2.text = [fen objectAtIndex:1] ;
                        slider.hidden = YES ;
                        button.hidden = NO ;
                        fen1.userInteractionEnabled = YES ;
                        fen2.userInteractionEnabled = YES ;
                    }
                }
                
                if (![_vo.visitingsubmit isEqualToString:@"<null>"] && ![_vo.visitingsubmit isEqualToString:@""]) {
                    if ([_vo.visitingclub isEqualToString:uvo.club] ) {
                        NSArray *fen = [_vo.visitingsubmit componentsSeparatedByString:@":"] ;
                        fen1.text = [fen objectAtIndex:0] ;
                        fen2.text = [fen objectAtIndex:1] ;
                        slider.rawValue = [_vo.visitingeva integerValue] ;
                        button.hidden = YES ;
                        fen1.userInteractionEnabled = NO ;
                        fen2.userInteractionEnabled = NO ;
                        slider.userInteractionEnabled = NO ;
                    }else{
                        NSArray *fen = [_vo.visitingsubmit componentsSeparatedByString:@":"] ;
                        fen1.text = [fen objectAtIndex:0] ;
                        fen2.text = [fen objectAtIndex:1] ;
                        slider.hidden = YES ;
                        button.hidden = NO ;
                        fen1.userInteractionEnabled = YES ;
                        fen2.userInteractionEnabled = YES ;
                    }
                }
            }
        }else if([_vo.matchstatus isEqualToString:@"0"]){
            button.hidden = NO ;
        }else{
            button.hidden = YES ;
        }
    }else{
        button.hidden = NO ;
    }
}

-(void)call:(UITapGestureRecognizer *)tap{
    UIView *views = (UIView*) tap.view;
    NSMutableString  * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",views.accessibilityHint];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

-(void)submitSaiResult{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    if ([fen1.text isEqualToString:@""] || [fen2.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"请填写比分"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        return ;
    }
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: _vo.sid ,@"scheduleId" , uvo.club , @"clubId" , [NSString stringWithFormat:@"%@:%@" , fen1.text , fen2.text] , @"result" , ravalue , @"eva" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:submitCupResult parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            [SVProgressHUD showSuccessWithStatus:@"赛果提交成功"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:object[@"msg"]];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        }
    } failure:^(NSError *error) {
        
    }];

    
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
