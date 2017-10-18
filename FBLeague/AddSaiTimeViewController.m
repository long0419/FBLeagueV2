//
//  AddSaiTimeViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/8.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "AddSaiTimeViewController.h"
#import "HcdDateTimePickerView.h"
#import "LianSaiData.h"

@interface AddSaiTimeViewController (){
    DSLLoginTextField *psw ;
    DSLLoginTextField *area ;
    NSString *time ;
    QMUITextView *textView;
}


@end

@implementation AddSaiTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布比赛时间";
    
    [self setBackBottmAndTitle2];
    
    QMUILabel *label3 = [[QMUILabel alloc] init];
    label3.origin = CGPointMake(30, 20 + 44 + 20) ;
    label3.text = @"比赛时间";
    label3.font = UIFontMake(12);
    label3.textColor = UIColorBlack ;
    [label3 sizeToFit];
    [self.view addSubview:label3];

    psw=[[DSLLoginTextField alloc]init];
    psw.frame = CGRectMake(30 , label3.bottom + 20 , kScreen_Width - 60 , 40) ;
    psw.clearButtonMode=UITextFieldViewModeWhileEditing;
    psw.textColor = [UIColor blackColor] ;
    psw.font=[UIFont systemFontOfSize:14];
    psw.placeholder=@"选择时间";
    psw.placeholderColor = [UIColor blackColor] ;
    psw.maxTextLength= 11;
    psw.delegate = self ;
    psw.tag = 10 ;
    psw.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:psw];

    
    QMUILabel *label = [[QMUILabel alloc] init];
    label.origin = CGPointMake(30 , psw.bottom + 20) ;
    label.text = @"比赛地点";
    label.font = UIFontMake(12);
    label.textColor = UIColorBlack ;
    [label sizeToFit];
    [self.view addSubview:label];
 
    
    textView = [[QMUITextView alloc] init];
    textView.frame = CGRectMake(30 , label.bottom + 10 , kScreen_Width - 60 , 100);
    textView.delegate = self;
    textView.autoResizable = YES;
    textView.textContainerInset = UIEdgeInsetsMake(10, 7, 10, 7);
    textView.returnKeyType = UIReturnKeySend;
    textView.enablesReturnKeyAutomatically = YES;
    textView.typingAttributes = @{NSFontAttributeName: UIFontMake(15),
                                       NSForegroundColorAttributeName: UIColorGray1,
                                       NSParagraphStyleAttributeName: [NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:20]};
    textView.maximumTextLength = 100;
    textView.tintColor = [UIColor blackColor];
    textView.layer.borderWidth = .6  ;
    textView.layer.borderColor = [UIColor blackColor].CGColor;
    textView.layer.cornerRadius = 4;
    [self.view addSubview:textView];

    
    QMUIButton *button = [[QMUIButton alloc] init];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(37/2);
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    button.highlightedBackgroundColor = [UIColor colorWithHexString:@"5a70d6"];    button.layer.cornerRadius = 4;
    [button addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交发布" forState:UIControlStateNormal];
    button.frame = CGRectMake(30 , textView.bottom + 20 , kScreen_Width - 60 , 40);
    [self.view addSubview:button];

}

-(void)submit{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.club ,@"clubId" , _leagueId , @"leagueId" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:listJoinin parameters:params success:^(id data) {
        if([data[@"code"] isEqualToString:@"0000"]){
            if ([data[@"page"] isEqual:[NSNull null]]) {
                return ;
            }
            NSDictionary *dic = data[@"match"];
            LianSaiData *model = nil ;
            if (![dic isEqual:[NSNull null]]) {
                //                for (NSDictionary *dic in list) {
                model = [LianSaiData new];
                model.lid = [NSString stringWithFormat:@"%@" , dic[@"id"]] ;
                model.provincename = [NSString stringWithFormat:@"%@" , dic[@"provincename"]] ;
                model.areacode = [NSString stringWithFormat:@"%@" , dic[@"areacode"]] ;
                model.matchname = [NSString stringWithFormat:@"%@" , dic[@"matchname"]] ;
                model.leagueid = [NSString stringWithFormat:@"%@" , dic[@"leagueid"]] ;
                model.isfull = [NSString stringWithFormat:@"%@" , dic[@"isfull"]] ;
                model.cityname = [NSString stringWithFormat:@"%@" , dic[@"cityname"]] ;
                model.grouptype = [NSString stringWithFormat:@"%@" , dic[@"grouptype"]] ;
                model.provincecode = [NSString stringWithFormat:@"%@" , dic[@"provincecode"]] ;
                model.grouptype = [NSString stringWithFormat:@"%@" , dic[@"grouptype"]] ;
                model.citycode = [NSString stringWithFormat:@"%@" , dic[@"citycode"]] ;
                model.enabled = [NSString stringWithFormat:@"%@" , dic[@"enabled"]] ;
                model.format = [NSString stringWithFormat:@"%@" , dic[@"format"]] ;
                model.joininCount = [NSString stringWithFormat:@"%@" , dic[@"joininCount"]] ;
                model.areaname = [NSString stringWithFormat:@"%@" , dic[@"areaname"]] ;
                model.matchnumber = [NSString stringWithFormat:@"%@" , dic[@"matchnumber"]] ;
                model.number = [NSString stringWithFormat:@"%@" , dic[@"number"]] ;
                model.bonus = [NSString stringWithFormat:@"%@" , dic[@"bonus"]] ;

                NSDictionary *tmp = [NSDictionary dictionaryWithObjectsAndKeys: textView.text ,  @"matchPlace" ,psw.text , @"matchTime" , uvo.club , @"clubId" , model.lid , @"matchId" ,  model.leagueid , @"leagueId" , uvo.phone ,  @"token", nil];

                [PPNetworkHelper POST:requestMatch parameters:tmp success:^(id object) {
                    if([object[@"code"] isEqualToString:@"0000"]){
                     
                        [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                        
                        [self.navigationController popViewControllerAnimated:YES];

                    }
                } failure:^(NSError *error) {
                    
                }];

                
        }
    }
} failure:^(NSError *error) {
    
}];
    

}

-(void)textFieldDidBeginEditing:(UITextField*)textField

{
    [textField resignFirstResponder];
    
    if(textField.tag == 10){
        HcdDateTimePickerView *dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
        dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
            NSLog(@"%@", datetimeStr);
            textField.text = datetimeStr ;
            time = datetimeStr ;
        };
        [self.view addSubview:dateTimePickerView];
        [dateTimePickerView showHcdDateTimePicker];
    }
}

@end
