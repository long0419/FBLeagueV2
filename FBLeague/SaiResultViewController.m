//
//  SaiResultViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/4.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "SaiResultViewController.h"
#import "PPNumberButton.h"

@interface SaiResultViewController (){
    UIImageView *bg ;
    QMUILabel *label16 ;
    QMUILabel *label17 ;
    NSString *visitingClubPicUrl ;
    NSString *homeClubPicUrl ;
    DSLLoginTextField *fen1 ;
    DSLLoginTextField *fen2 ;
    NSString *matchstatus ;
    PPNumberButton *slider ;
    NSString *ravalue ;
}

@end

@implementation SaiResultViewController

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getNeedData];
}

-(void)getNeedData {
    
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_vo.sid , @"id" ,uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:getJoininDetail parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            _vo = [SaiChengVo new] ;
            visitingClubPicUrl = object[@"visitingClubPicUrl"] ;
            homeClubPicUrl = object[@"homeClubPicUrl"] ;

            _vo.visitingsubmit = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"visitingsubmit"]] ;
            _vo.matchstatus = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"matchstatus"]] ;
            _vo.matchid = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"schedule"][@"matchid"]] ;
            _vo.visitingclub = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"visitingclub"]] ;
            _vo.homeclubname = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"homeclubname"]] ;
            _vo.visitingeva = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"visitingeva"]] ;
            _vo.homesubmit = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"homesubmit"]] ;
            _vo.field = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"field"]] ;
            _vo.hasplayed = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"hasplayed"]] ;
            _vo.visitingclubname = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"visitingclubname"]] ;
            _vo.challengeid = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"challengeid"]] ;
            _vo.leagueid = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"leagueid"]] ;
            _vo.sid = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"id"]] ;
            _vo.challengeid = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"challengeid"]] ;
            _vo.visitinggoalcount = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"visitinggoalcount"]] ;
            _vo.matchname = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"matchname"]] ;
            _vo.homegoalcount = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"homegoalcount"]] ;
            _vo.homeclub = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"homeclub"]] ;
            _vo.remarks = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"remarks"]] ;
            _vo.matchtime = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"matchtime"]] ;
            _vo.roundnum = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"roundnum"]] ;
            _vo.homeeva = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"homeeva"]] ;
            _vo.launchclub = [NSString stringWithFormat:@"%@" , object[@"schedule"][@"launchclub"]] ;
            
            matchstatus = _vo.matchstatus ;
            
            [self status1] ;
            
            if ([_vo.hasplayed isEqualToString:@"y"]) {
                if (![_vo.homesubmit isEqualToString:@"<null>"] && ![_vo.visitingsubmit isEqualToString:@"<null>"] ) {
                    [self status3 : _vo] ; //status3 用于只显示提交赛过
                }
            }else{
                if ([_vo.matchstatus isEqualToString:@"11"]) {
                    if (![_vo.homesubmit isEqualToString:@"<null>"] && ![_vo.visitingsubmit isEqualToString:@"<null>"] ) {
                        [self status3 : _vo] ; //status3 用于只显示提交赛过
                    }
                }else{
                    if (![_vo.homesubmit isEqualToString:@"<null>"] && ![_vo.visitingsubmit isEqualToString:@"<null>"] ) {
                        [self status3 : _vo] ; //status3 用于只显示提交赛过
                    }else{
                        [self status2 : _vo] ;
                    }
                }
            }
            
        }
    } failure:^(NSError *error) {
        
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"323c45"];
    
    [self forbiddenGesture];
    
    ravalue = @"0" ;
    
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
    
    label17 = [[QMUILabel alloc] init];
    label17.text = @"VS";
    label17.font = UIFontMake(12);
    label17.textColor = UIColorWhite ;
    [label17 sizeToFit];
    [bg addSubview:label17];
    label17.origin = CGPointMake((kScreen_Width - label17.size.width)/2, 10 + 20 + 44 + 50);
    
}

-(void)status1{
    UIImageView *image = [[UIImageView alloc] initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:visitingClubPicUrl]]]];
    image.frame = CGRectMake(45, label16.bottom + 25, 50, 50);
    image.layer.cornerRadius = 4 ;
    image.layer.masksToBounds = true ;

    [bg addSubview:image];
    
    UIImageView *image2 = [[UIImageView alloc] initWithImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:homeClubPicUrl]]]];
    image2.frame = CGRectMake(kScreen_Width - 50 - 45 , label16.bottom + 25, 50, 50);
    image2.layer.cornerRadius = 4 ;
    image2.layer.masksToBounds = true ;
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

-(void)status2 : (SaiChengVo *) vo{
    NSString *status = @"" ;
    if ([vo.matchstatus isEqualToString:@"33"]) {

        status = @"迎战" ;
        
    }else if([vo.matchstatus isEqualToString:@"22"]){
        status = @"取消比赛" ;
        
    }
    
    QMUILabel *name2 = [[QMUILabel alloc] init];
    name2.text = [NSString stringWithFormat:@"比赛状态：%@" , status];
    name2.font = UIFontMake(12);
    name2.textColor = UIColorWhite ;
    [name2 sizeToFit];
    [bg addSubview:name2];
    name2.origin = CGPointMake(30 , bg.bottom + 44);
    
    QMUILabel *name3 = [[QMUILabel alloc] init];
    name3.text = [NSString stringWithFormat:@"比赛时间：%@" ,vo.matchtime];
    name3.font = UIFontMake(12);
    name3.textColor = UIColorWhite ;
    [name3 sizeToFit];
    [bg addSubview:name3];
    name3.origin = CGPointMake(30 , name2.bottom + 13);

    QMUILabel *name4 = [[QMUILabel alloc] init];
    name4.text = [NSString stringWithFormat:@"比赛地点：%@" , vo.field];
    name4.font = UIFontMake(12);
    name4.textColor = UIColorWhite ;
    [name4 sizeToFit];
    [bg addSubview:name4];
    name4.origin = CGPointMake(30 , name3.bottom + 13);

    NSString *title = @"" ;
    if ([_vo.matchstatus isEqualToString:@"33"]) { //应战
        if ([_vo.launchclub isEqualToString:_vo.homeclub]) {
            title = @"去迎战" ;
        }
    }else if([_vo.matchstatus isEqualToString:@"22"]){ //取消比赛
        if ([_vo.launchclub isEqualToString:_vo.homeclub]) {
            title = @"取消比赛" ;
        }
    }

    QMUIButton *button = [[QMUIButton alloc] init];
    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(37/2);
    button.frame = CGRectMake(30 , name4.bottom + 226/2, kScreen_Width - 60 , 40) ;
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithHexString:@"5a70d6"] ;
    button.highlightedBackgroundColor = [UIColor colorWithHexString:@"5a70d6"];    button.layer.cornerRadius = 4;
    [button setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:button];

    if ([_vo.matchstatus isEqualToString:@"33"]) { //应战
        if ([_vo.launchclub isEqualToString:_vo.homeclub]) {
            [button addTarget:self action:@selector(yingzhan) forControlEvents:UIControlEventTouchUpInside];

        }
    }else if([_vo.matchstatus isEqualToString:@"22"]){ //取消比赛
        if ([_vo.launchclub isEqualToString:_vo.homeclub]) {
            [button addTarget:self action:@selector(cancelZhan) forControlEvents:UIControlEventTouchUpInside];

        }
    }

    
}


-(void)status3 :(SaiChengVo *) vo{
    QMUILabel *name2 = [[QMUILabel alloc] init];
    name2.text = @"";
    name2.font = UIFontMake(12);
    name2.textColor = UIColorWhite ;
    [name2 sizeToFit];
    [bg addSubview:name2];
    name2.origin = CGPointMake(30 , bg.bottom + 5);
    
    fen1=[[DSLLoginTextField alloc]init];
    fen1.frame = CGRectMake(50 , name2.bottom + 30 , 40, 40) ;
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
    fen2.frame = CGRectMake(kScreen_Width - 40 - 50 , name2.bottom + 30 , 40, 40) ;
    fen2.textColor = [UIColor blackColor] ;
    fen2.backgroundColor = [UIColor whiteColor];
    fen2.font=[UIFont systemFontOfSize:14];
    fen2.maxTextLength= 2 ;
    fen2.delegate = self ;
    fen2.tag = 11 ;
    fen2.keyboardType = UIKeyboardTypeNumberPad;
    fen2.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:fen2];

    QMUILabel *name2x = [[QMUILabel alloc] init];
    name2x.text = @"比分";
    name2x.font = UIFontMake(12);
    name2x.textColor = UIColorWhite ;
    [name2x sizeToFit];
    [bg addSubview:name2x];
    name2x.origin = CGPointMake((kScreen_Width - name2x.width)/2 , bg.bottom + 10);

    QMUILabel *name3 = [[QMUILabel alloc] init];
    name3.text = @"请对你的赛球方的综合素质评分:";
    name3.font = UIFontMake(12);
    name3.textColor = UIColorWhite ;
    [name3 sizeToFit];
    [bg addSubview:name3];
    name3.origin = CGPointMake((kScreen_Width - name3.size.width)/2 , fen2.bottom + 20);
    
    slider = [PPNumberButton numberButtonWithFrame:CGRectMake((kScreen_Width - 280)/2 , name3.bottom + 40 , 280.f, 44.f)];
    //设置边框颜色
    slider.borderColor = [UIColor grayColor];
    slider.increaseTitle = @"＋";
    slider.decreaseTitle = @"－";
    slider.maxValue = 10 ;
    slider.minValue = 1 ;
    slider.rawValue = 1 ;
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

}

#pragma mark - 提交赛过
-(void) submitSaiResult{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: _vo.sid ,@"scheduleId" , _vo.leagueid , @"leagueId" , uvo.club , @"clubId" , [NSString stringWithFormat:@"%@:%@" , fen1 , fen2] , @"result" , ravalue , @"eva" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:submitResult parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"发布成功";
            [self.HUD hide:YES afterDelay:3];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 应战
-(void)yingzhan{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: _vo.sid , @"scheduleId" , _matchId , @"matchId" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:respondMatch parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"发布成功";
            [self.HUD hide:YES afterDelay:3];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 取消比赛
-(void)cancelZhan{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: _vo.sid , @"scheduleId" , uvo.club , @"requestClubId" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:cancelMatch parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"发布成功";
            [self.HUD hide:YES afterDelay:3];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)loginAction{
    if ([_vo.hasplayed isEqualToString:@"y"]) { //提交赛过
        if ([_vo.matchstatus isEqualToString:@"1"]) {
            [self submitSaiResult];
        }
    }else{
        if ([_vo.matchstatus isEqualToString:@"33"]) { //应战
            [self yingzhan];
        }else if([_vo.matchstatus isEqualToString:@"22"]){ //取消比赛
            [self cancelZhan];
        }
    }
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder] ;
    return true;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [fen1 resignFirstResponder];
    [fen2 resignFirstResponder];
}

@end
