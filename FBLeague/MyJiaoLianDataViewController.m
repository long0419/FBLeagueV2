//
//  MyJiaoLianDataViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/3/12.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "MyJiaoLianDataViewController.h"
#import "JHRadarChart.h"
#import "MeView.h"

@interface MyJiaoLianDataViewController (){
    JHRadarChart *radarChart ;
    UILabel *zongheLabel ;
    UIView *bg ;
    UITableView *table ;
    UIView *cellView ;
    UILabel *currentData ;

    NSString *skill ;
    NSString *control ;
    NSString *counterattack ;
    NSString *stronghand ;
    NSString *compete ;
    NSString *stimulate ;
    NSString *limitSkill ;
    NSString *count ;


}

@end

@implementation MyJiaoLianDataViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self showTabBottom];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    

    [self getUserInfo];

}
-(void)keyboardWillShow : (NSNotification *) notification{
    
    
    CGRect frame = self.view.frame;
    
    frame.origin.y = - kScreen_Height/3 ;
    
    self.view.frame = frame;
    
}

-(void)keyboardWillHide : (NSNotification *) notification{
    //恢复到默认y为0的状态，有时候要考虑导航栏要+64
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    self.view.frame = frame;
}

-(void)getUserInfo{
//    UserDataVo *cvo = [NSKeyedUnarchiver unarchiveObjectWithData: UserDefaultGet(@"userData")];

    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
//    APIClient *client = [APIClient sharedJsonClient];
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: cvo.phone ,  @"phone" , _vo.phone ,@"coachPhone", nil];
//    [client requestJsonDataWithPath:getCoachDetail withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
//        if([data[@"code"] isEqualToString:@"0000"]){
//            
//            skill = [NSString stringWithFormat:@"%@" , data[@"coach"][@"skill"]]  ;
//            control =  [NSString stringWithFormat:@"%@" , data[@"coach"][@"control"]] ;
//            counterattack = [NSString stringWithFormat:@"%@" , data[@"coach"][@"counterattack"]];
//            stronghand = [NSString stringWithFormat:@"%@" , data[@"coach"][@"strongHand"] ];
//            compete = [NSString stringWithFormat:@"%@" , data[@"coach"][@"compete"] ];
//            stimulate = [NSString stringWithFormat:@"%@" , data[@"coach"][@"stimulate"] ];
//            limitSkill = [NSString stringWithFormat:@"%@" , data[@"coach"][@"limitSkill"] ];
//            count = [NSString stringWithFormat:@"%@" , data[@"coach"][@"count"] ];
//            
//            _total = limitSkill ;
//            
//            table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , kScreen_Width, kScreen_Height)];
//            table.separatorStyle = NO;
//            table.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
//            table.delegate = self ;
//            table.dataSource = self;
//            [self.view addSubview:table];
//            
//            
//            [self radarContent];
//            [self dataImport];
//            
//        }else {
//            self.HUD.mode = MBProgressHUDModeText;
//            self.HUD.removeFromSuperViewOnHide = YES;
//            self.HUD.labelText = @"系统错误";
//            [self.HUD hide:YES afterDelay:3];
//        }
//    }];
//    [self closeProgressView];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"球员数据录入" ;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f6f7"];
    
    [self setBackBottmAndTitle];
    
    [self setRightBottom];
    

}

- (void)setRightBottom {
    CGSize size = [NSString getStringContentSizeWithFontSize:15 andContent:@"提交"] ;
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    sender.frame = CGRectMake(0, 0, size.width , size.height);
    [sender setTitle:@"提交" forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize: 15];
    [sender setTitleColor:[UIColor colorWithHexString:@"ffffff"]forState:UIControlStateNormal];
    [sender addTarget:self action: @selector(send)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:sender];
    self.navigationItem.rightBarButtonItem = backItem ;
}

-(void) resetRadarView :(NSArray *) values{
    [radarChart removeFromSuperview];
    
    radarChart = [[JHRadarChart alloc] initWithFrame:CGRectMake(0,
                                                                zongheLabel.bottom + 25/2 , kScreen_Width , 300)];
    radarChart.backgroundColor = [UIColor whiteColor];
    radarChart.valueDescArray = @[
                                  [NSString stringWithFormat:@"个人技术"],
                                  [NSString stringWithFormat:@"传控"],
                                  [NSString stringWithFormat:@"铁腕"],
                                  [NSString stringWithFormat:@"防守反击"] ,
                                  [NSString stringWithFormat:@"对抗"],
                                  [NSString stringWithFormat:@"激励"]];
    radarChart.layerCount = 5;
    radarChart.tag = 11 ;
    radarChart.valueDataArray = values ;
    radarChart.layerFillColor = [UIColor colorWithHexString:@"ffffff" andAlpha:.5];
    radarChart.valueDrawFillColorArray = @[[UIColor colorWithHexString:@"4cc07f" andAlpha:.5]];
    [radarChart showAnimation];
    [bg addSubview:radarChart];
}

-(void)send{

    NSUInteger num = [skill integerValue] + [control integerValue] + [counterattack integerValue]
    + [stronghand integerValue] + [compete integerValue] + [stimulate integerValue];
    
    if (num > [limitSkill integerValue]) {
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = [NSString stringWithFormat:@"能力值设置有误，请重新调整后再提交"];
        [self.HUD hide:YES afterDelay:3];
        return ;
    }

    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    APIClient *client = [APIClient sharedJsonClient];
//    
//   
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"1" , @"type"  , _vo.phone ,  @"phone" ,
//                            skill , @"skill" , control ,@"control",
//                            counterattack , @"counterattack" ,
//                            stronghand ,@"stronghand" ,
//                            compete ,@"compete" ,
//                            stimulate ,@"stimulate", nil];
//    [client requestJsonDataWithPath:setSkill withParams:params withMethodType:Post andBlock:^(id data, NSError *error) {
//        if([data[@"code"] isEqualToString:@"0000"]){
//            self.HUD.mode = MBProgressHUDModeText;
//            self.HUD.removeFromSuperViewOnHide = YES;
//            self.HUD.labelText = @"设置成功";
//            [self.HUD hide:YES afterDelay:5];
//            [self.navigationController popViewControllerAnimated:YES];
//        }else {
//            self.HUD.mode = MBProgressHUDModeText;
//            self.HUD.removeFromSuperViewOnHide = YES;
//            self.HUD.labelText = @"系统错误";
//            [self.HUD hide:YES afterDelay:5];
//        }
//    }];
//    [self closeProgressView];
    
}


-(void)radarContent{
    cellView = [UIView new];
    [self.view addSubview:cellView];
    
    bg = [[UIView alloc] initWithFrame:
          CGRectMake(0, 7, kScreen_Width, 548/2)];
    bg.backgroundColor = [UIColor whiteColor];
    [cellView addSubview:bg];
    
    CGSize zonghe = [NSString getStringContentSizeWithFontSize:32/2
                                                    andContent:@"综合能力值："];
    zongheLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                            (kScreen_Width - zonghe.width)/2  , 18 ,
                                                            zonghe.width, zonghe.height)];
    zongheLabel.font = [UIFont systemFontOfSize:32/2];
    zongheLabel.textColor = [UIColor colorWithHexString:@"818a91"];
    zongheLabel.text = @"综合能力值：" ;
    [bg addSubview:zongheLabel];
    
    radarChart = [[JHRadarChart alloc] initWithFrame:CGRectMake(0,
                                                                zongheLabel.bottom + 25/2 , kScreen_Width , 300)];
    radarChart.backgroundColor = [UIColor whiteColor];
    
    //传球、力量、速度、对抗、防守、盘带
    
    radarChart.valueDescArray = @[
                                  [NSString stringWithFormat:@"个人技术"],
                                  [NSString stringWithFormat:@"传控"],
                                  [NSString stringWithFormat:@"铁腕"],
                                  [NSString stringWithFormat:@"防守反击"] ,
                                  [NSString stringWithFormat:@"对抗"],
                                  [NSString stringWithFormat:@"激励"]];
    
    radarChart.layerCount = 5;
    radarChart.tag = 11 ;
    
    if ([skill isEqualToString:@"0"] &&[control isEqualToString:@"0"] &&[counterattack isEqualToString:@"0"]
        &&[stronghand isEqualToString:@"0"] && [compete isEqualToString:@"0"] && [stimulate isEqualToString:@"0"]) {
        skill = @"60" ;
        control = @"60" ;
        counterattack = @"60" ;
        stronghand = @"60" ;
        compete = @"60" ;
        stimulate = @"60" ;
    }
    radarChart.valueDataArray = @[@[skill, control , stronghand , counterattack ,
                                     compete, stimulate]];
    radarChart.layerFillColor = [UIColor colorWithHexString:@"ffffff" andAlpha:.5];
    radarChart.valueDrawFillColorArray = @[[UIColor colorWithHexString:@"4cc07f" andAlpha:.5]];
    [radarChart showAnimation];
    [bg addSubview:radarChart];
}

-(void)dataImport{
    
    UIView *databg = [[UIView alloc] initWithFrame:CGRectMake(0, radarChart.bottom , kScreen_Width, 30)];
    databg.backgroundColor = [UIColor colorWithHexString:@""];
    //    [cellView addSubview:databg];
    
    CGSize shuju = [NSString
                    getStringContentSizeWithFontSize:13
                    andContent:@"数据录入："];
    UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                   12  , radarChart.bottom + 15 , shuju.width, shuju.height)];
    dataLabel.font = [UIFont systemFontOfSize:13];
    dataLabel.textColor = [UIColor colorWithHexString:@"999999"];
    dataLabel.text = @"数据录入：" ;
    [cellView addSubview:dataLabel];

    
    
    NSUInteger num = [skill integerValue] + [control integerValue] + [counterattack integerValue]
    + [stronghand integerValue] + [compete integerValue] + [stimulate integerValue];
    
    NSInteger leftnum = [limitSkill integerValue] - num;
    CGSize left = [NSString
                   getStringContentSizeWithFontSize:13
                   andContent:[NSString stringWithFormat:@"剩余点数：%ld" , (long)leftnum]];
    currentData = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width - left.width - 20 - 5 , radarChart.bottom + 15 , left.width + 10, left.height)] ;
    currentData.font = [UIFont systemFontOfSize:13];
    currentData.textColor = [UIColor colorWithHexString:@"999999"];
    currentData.text = [NSString stringWithFormat:@"剩余点数：%ld" , (long)leftnum] ;
    [cellView addSubview:currentData];

    
    MeView *meView = [[MeView alloc] init];
    meView.delegate = self ;
    UIView *skillView = [meView getImportData:@"个人技术" andWithRatioNum:skill andWithMax :_total] ;
    skillView.origin = CGPointMake(0, dataLabel.bottom + 7) ;
    [cellView addSubview:skillView];
    
    MeView *meView2 = [[MeView alloc] init];
    meView2.delegate = self ;
    UIView *counter = [meView2 getImportData:@"防守反击" andWithRatioNum:counterattack andWithMax :_total] ;
    counter.origin = CGPointMake(0, skillView.bottom) ;
    [cellView addSubview:counter];
    
    MeView *meView3 = [[MeView alloc] init];
    meView3.delegate = self ;
    UIView *personal = [meView3 getImportData:@"铁        腕" andWithRatioNum:stronghand andWithMax :_total] ;
    personal.origin = CGPointMake(0, counter.bottom ) ;
    [cellView addSubview:personal];
    
    MeView *meView4 = [[MeView alloc] init];
    meView4.delegate = self ;
    UIView *duikang= [meView4 getImportData:@"对        抗" andWithRatioNum:compete andWithMax :_total] ;
    duikang.origin = CGPointMake(0, personal.bottom) ;
    [cellView addSubview:duikang];
    
    MeView *meView5 = [[MeView alloc] init];
    meView5.delegate = self ;
    UIView *chuankong = [meView5 getImportData:@"传        控" andWithRatioNum:control andWithMax :_total] ;
    chuankong.origin = CGPointMake(0, duikang.bottom ) ;
    [cellView addSubview:chuankong];
    
    MeView *meView6 = [[MeView alloc] init];
    meView6.delegate = self ;
    UIView *jili = [meView6 getImportData:@"激        励" andWithRatioNum:stimulate andWithMax :_total] ;
    jili.origin = CGPointMake(0, chuankong.bottom ) ;
    [cellView addSubview:jili];

    
    CGSize jiaose = [NSString
                     getStringContentSizeWithFontSize:13
                     andContent:@"选择角色："];
    UILabel *jiaoseLabel = [[UILabel alloc] initWithFrame:
                            CGRectMake(12  , jili.bottom + 15, jiaose.width, jiaose.height)];
    jiaoseLabel.font = [UIFont systemFontOfSize:13];
    jiaoseLabel.textColor = [UIColor colorWithHexString:@"999999"];
    jiaoseLabel.text = @"选择位置：" ;
    //    [cellView addSubview:jiaoseLabel];
    
    BeginTouView *beginView2 = [[BeginTouView alloc] init];
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc]
                                          initWithTarget:
                                          self action:@selector(sendrole)];
    UIView *use = nil ;
    use = [beginView2 getBeginTouView:@"位        置" andWithTintTitle:@"" andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, jiaoseLabel.bottom + 7) andWithTag:2];
    [use setUserInteractionEnabled:YES];
    [use addGestureRecognizer:singleTap2];
    //    [cellView addSubview:use];
    
    cellView.frame = CGRectMake(0, 0, kScreen_Width, use.bottom - 0) ;
}

-(void)sendrole{
    ACActionSheet *actionSheet = [[ACActionSheet alloc] initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"前锋",@"中锋",@"后卫"] actionSheetBlock:^(NSInteger buttonIndex) {
        NSLog(@"ACActionSheet block - %ld",buttonIndex);
    }];
    [actionSheet show];
}

#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Categorys = @"Categorys";
    
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Categorys];
    [cell addSubview:cellView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
    
}


#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 800 ;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)meData : (NSString *)title andWithValue : (NSString *)value andWithRawValue : (NSString *)rawnum{
    
    if ([title rangeOfString:@"个"].location != NSNotFound) {
        skill = value ;
    }
    if ([title rangeOfString:@"传"].location != NSNotFound) {
        control = value ;
    }
    if ([title rangeOfString:@"铁"].location != NSNotFound) {
        stronghand = value ;
    }
    if ([title rangeOfString:@"防"].location != NSNotFound) {
        counterattack = value ;
    }
    if ([title rangeOfString:@"对"].location != NSNotFound) {
        compete =value ;
    }
    if ([title rangeOfString:@"激"].location != NSNotFound) {
        stimulate = value ;
    }

    
    NSUInteger num = [skill integerValue] + [control integerValue] + [counterattack integerValue]
    + [stronghand integerValue] + [compete integerValue] + [stimulate integerValue];
    
    NSInteger leftnum = [limitSkill integerValue] - num;
    currentData.text = [NSString stringWithFormat:@"剩余点数：%ld" , (long)leftnum] ;
    
    
    if (num > [limitSkill integerValue]) {
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = [NSString stringWithFormat:@"当前设置已经超过总的能力值%@" ,limitSkill];
        [self.HUD hide:YES afterDelay:3];

        NSString *text = [NSString stringWithFormat:@"剩余点数：%ld" , leftnum] ;
        NSMutableAttributedString *str =
        [[NSMutableAttributedString alloc] initWithString : [NSString stringWithFormat:@"剩余点数：%ld" , leftnum]];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0 , text.length)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"999999"] range:NSMakeRange(0,5)];
        currentData.attributedText = str ;

    }
}


@end
