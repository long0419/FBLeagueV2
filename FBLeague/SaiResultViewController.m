//
//  SaiResultViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/4.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "SaiResultViewController.h"
#import "StepSlider.h"

@interface SaiResultViewController (){
    UIImageView *bg ;
    QMUILabel *label16 ;
}

@end

@implementation SaiResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"323c45"];
    
    [self forbiddenGesture];
    
    bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"liansai-bg"]];
    bg.frame = CGRectMake(0, 0, kScreen_Width, 220) ;
    [self.view addSubview:bg];
    
    [self setBackBottmAndTitle];
    
    label16 = [[QMUILabel alloc] init];
    label16.text = _vo.matchname;
    label16.font = UIFontMake(12);
    label16.textColor = UIColorWhite ;
    [label16 sizeToFit];
    [bg addSubview:label16];
    label16.origin = CGPointMake((kScreen_Width - label16.size.width)/2, 10 + 20 + 44);
    
    [self status1] ;
    
//    [self status2] ;

    [self status3] ;

//    [self status4] ;

    
    
}

-(void)status1{
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weibo-拷贝"]];
    image.frame = CGRectMake(45, label16.bottom + 25, 50, 50);
    [bg addSubview:image];
    
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weixin-拷贝"]];
    image2.frame = CGRectMake(kScreen_Width - 50 - 45 , label16.bottom + 25, 50, 50);
    [bg addSubview:image2];
    
    QMUILabel *name = [[QMUILabel alloc] init];
    name.text = _vo.homeclubname ;
    name.font = UIFontMake(12);
    name.textColor = UIColorWhite ;
    [name sizeToFit];
    [bg addSubview:name];
    name.origin = CGPointMake(30 , image.bottom + 21);
    
    QMUILabel *name2 = [[QMUILabel alloc] init];
    name2.text = _vo.visitingclubname ;
    name2.font = UIFontMake(12);
    name2.textColor = UIColorWhite ;
    [name2 sizeToFit];
    [bg addSubview:name2];
    name2.origin = CGPointMake(kScreen_Width - name.width - 30 , image.bottom + 21);
    
    
    
}

-(void)status2{
    QMUILabel *name2 = [[QMUILabel alloc] init];
    name2.text = @"比赛状态：";
    name2.font = UIFontMake(12);
    name2.textColor = UIColorWhite ;
    [name2 sizeToFit];
    [bg addSubview:name2];
    name2.origin = CGPointMake(30 , bg.bottom + 44);
    
    QMUILabel *name3 = [[QMUILabel alloc] init];
    name3.text = @"比赛时间：";
    name3.font = UIFontMake(12);
    name3.textColor = UIColorWhite ;
    [name3 sizeToFit];
    [bg addSubview:name3];
    name3.origin = CGPointMake(30 , name2.bottom + 13);

    QMUILabel *name4 = [[QMUILabel alloc] init];
    name4.text = @"比赛地点：";
    name4.font = UIFontMake(12);
    name4.textColor = UIColorWhite ;
    [name4 sizeToFit];
    [bg addSubview:name4];
    name4.origin = CGPointMake(30 , name3.bottom + 13);

    QMUIButton *button = [[QMUIButton alloc] init];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(37/2);
    button.frame = CGRectMake(30 , name4.bottom + 226/2, kScreen_Width - 60 , 40) ;
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithHexString:@"5a70d6"] ;
    button.highlightedBackgroundColor = [UIColor colorWithHexString:@"5a70d6"];    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"取消比赛" forState:UIControlStateNormal];
    [self.view addSubview:button];
  
    
}

-(void)status3{
    QMUILabel *name2 = [[QMUILabel alloc] init];
    name2.text = @"比分";
    name2.font = UIFontMake(12);
    name2.textColor = UIColorWhite ;
    [name2 sizeToFit];
    [bg addSubview:name2];
    name2.origin = CGPointMake(30 , bg.bottom + 5);
    
    DSLLoginTextField *fen1=[[DSLLoginTextField alloc]init];
    fen1.frame = CGRectMake(50 , name2.bottom + 30 , 40, 40) ;
    fen1.clearButtonMode=UITextFieldViewModeWhileEditing;
    fen1.textColor = [UIColor blackColor] ;
    fen1.backgroundColor = [UIColor whiteColor] ;
    fen1.font=[UIFont systemFontOfSize:14];
    fen1.placeholderColor = [UIColor blackColor] ;
    fen1.maxTextLength= 2 ;
    fen1.delegate = self ;
    fen1.tag = 10 ;
    fen1.textAlignment = NSTextAlignmentLeft ;
    [self.view addSubview:fen1];
    
    DSLLoginTextField *fen2=[[DSLLoginTextField alloc]init];
    fen2.frame = CGRectMake(kScreen_Width - 40 - 50 , name2.bottom + 30 , 40, 40) ;
    fen2.clearButtonMode=UITextFieldViewModeWhileEditing;
    fen2.textColor = [UIColor blackColor] ;
    fen2.backgroundColor = [UIColor whiteColor];
    fen2.font=[UIFont systemFontOfSize:14];
    fen2.placeholderColor = [UIColor blackColor] ;
    fen2.maxTextLength= 2 ;
    fen2.delegate = self ;
    fen2.tag = 11 ;
    fen2.textAlignment = NSTextAlignmentLeft ;
    [self.view addSubview:fen2];

    QMUILabel *name2x = [[QMUILabel alloc] init];
    name2x.text = @"比分";
    name2x.font = UIFontMake(12);
    name2x.textColor = UIColorWhite ;
    [name2x sizeToFit];
    [bg addSubview:name2x];
    name2x.origin = CGPointMake(30 , bg.bottom + 5);

    QMUILabel *name3 = [[QMUILabel alloc] init];
    name3.text = @"请对你的赛球方的综合素质评分:";
    name3.font = UIFontMake(12);
    name3.textColor = UIColorWhite ;
    [name3 sizeToFit];
    [bg addSubview:name3];
    name3.origin = CGPointMake((kScreen_Width - name3.size.width)/2 , bg.bottom + 5);

    
    StepSlider *slider = [[StepSlider alloc] initWithFrame:CGRectMake((kScreen_Width - 300)/2 , fen2.bottom + 40 , 300.f, 44.f)];
    slider.labels = @[@"1", @"2", @"3", @"4"
                      , @"5", @"6", @"7", @"8", @"9", @"10"];
    [slider setMaxCount:10];
    [slider setIndex:1];
    [self.view addSubview:slider];
    
    
    QMUIButton *button = [[QMUIButton alloc] init];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(37/2);
    button.frame = CGRectMake(30 , slider.bottom + 226/2, kScreen_Width - 60 , 40) ;
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithHexString:@"5a70d6"] ;
    button.highlightedBackgroundColor = [UIColor colorWithHexString:@"5a70d6"];    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交赛果" forState:UIControlStateNormal];
    [self.view addSubview:button];

}

-(void)status4{
    
    

}

-(void)loginAction{
    
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

-(void)textFieldDidBeginEditing:(UITextField*)textField

{
    [textField resignFirstResponder];
    if(textField.tag == 10){
        
    }
}


@end
