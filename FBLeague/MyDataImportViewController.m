//
//  MyDataImportViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/1/2.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "MyDataImportViewController.h"
#import "JHRadarChart.h"
#import "MeView.h"
#import "CoachVo.h"

@interface MyDataImportViewController (){
    JHRadarChart *radarChart ;
    UILabel *zongheLabel ;
    UIView *bg ;
    UITableView *table ;
    UIView *cellView ;
    UILabel *currentData ;
    UITextField *currentTF ;
    NSMutableArray *ktouList ;
}

@end

@implementation MyDataImportViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    [self getUserInfo];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self showTabBottom];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的数据" ;
    ktouList = [[NSMutableArray alloc] init];
    [self setBackBottmAndTitle];
    
    [self setRightBottom];

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

-(void)radarContent{
    cellView = [UIView new];
    [self.view addSubview:cellView];
    
    bg = [[UIView alloc] initWithFrame:
                        CGRectMake(0, 7, kScreen_Width, 548/2)];
    bg.backgroundColor = [UIColor whiteColor];
    [cellView addSubview:bg];
    
    CGSize zonghe = [NSString getStringContentSizeWithFontSize:32/2
                            andContent:[NSString stringWithFormat:@"综合能力值：%@" , _limitSkill]];
    zongheLabel = [[UILabel alloc] initWithFrame:CGRectMake(
               (kScreen_Width - zonghe.width)/2  , 18 ,
               zonghe.width, zonghe.height)];
    zongheLabel.font = [UIFont systemFontOfSize:32/2];
    zongheLabel.textColor = [UIColor colorWithHexString:@"818a91"];
    zongheLabel.text = [NSString stringWithFormat:@"综合能力值：%@" , _limitSkill] ;
    [bg addSubview:zongheLabel];
    
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
    
//    if ([_skill isEqualToString:@"0"] &&[_control isEqualToString:@"0"] &&[_counterattack isEqualToString:@"0"]
//        &&[_stronghand isEqualToString:@"0"] && [_compete isEqualToString:@"0"] && [_stimulate isEqualToString:@"0"]) {
//        _skill = @"60" ;
//        _control = @"60" ;
//        _counterattack = @"60" ;
//        _stronghand = @"60" ;
//        _compete = @"60" ;
//        _stimulate = @"60" ;
//    }
    
    radarChart.valueDataArray = @[@[_skill , _control , _stronghand , _counterattack , _compete, _stimulate]];

    radarChart.layerFillColor = [UIColor colorWithHexString:@"ffffff" andAlpha:.5];
    radarChart.valueDrawFillColorArray = @[[UIColor colorWithHexString:@"4cc07f" andAlpha:.5]];
    [radarChart showAnimation];
    [bg addSubview:radarChart];
}


-(void)getUserInfo{

    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: _phone ,  @"phone" , _phone , @"token" , nil];
    [PPNetworkHelper POST:getCBDetail parameters:params success:^(id data) {
        
        if([data[@"code"] isEqualToString:@"0000"]){
            
                        _skill = [NSString stringWithFormat:@"%@" , data[@"user"][@"skill"]]  ;
                        _control =  [NSString stringWithFormat:@"%@" , data[@"user"][@"control"]] ;
                        _counterattack = [NSString stringWithFormat:@"%@" , data[@"user"][@"counterattack"]];
                        _stronghand = [NSString stringWithFormat:@"%@" , data[@"user"][@"strongHand"] ];
                        _compete = [NSString stringWithFormat:@"%@" , data[@"user"][@"compete"] ];
                        _stimulate = [NSString stringWithFormat:@"%@" , data[@"user"][@"stimulate"] ];
                        _limitSkill = [NSString stringWithFormat:@"%@" , data[@"user"][@"limitSkill"] ];
                        _count = [NSString stringWithFormat:@"%@" , data[@"user"][@"count"] ];
            
                        _total = _limitSkill ;
            
                        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , kScreen_Width, kScreen_Height)];
                        table.separatorStyle = NO;
                        table.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
                        table.delegate = self ;
                        table.dataSource = self;
                        [self.view addSubview:table];
            
            
                        [self radarContent];
                        [self dataImport];
            
                    }else {
                        self.HUD.mode = MBProgressHUDModeText;
                        self.HUD.removeFromSuperViewOnHide = YES;
                        self.HUD.labelText = @"系统错误";
                        [self.HUD hide:YES afterDelay:3];
                    }
        
    } failure:^(NSError *error) {
        
    }];

    [self closeProgressView];
}


-(void)send{
    
    NSUInteger num = [_skill integerValue] + [_control integerValue] + [_counterattack integerValue]
    + [_stronghand integerValue] + [_compete integerValue] + [_stimulate integerValue];
    
    if (num > [_limitSkill integerValue]) {
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = [NSString stringWithFormat:@"能力值设置有误，请重新调整后再提交"];
        [self.HUD hide:YES afterDelay:3];
        return ;
    }
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"1" , @"type"  , _phone ,  @"phone" ,
            _skill , @"skill" , _control ,@"control",
            _counterattack , @"counterattack" ,
            _stronghand ,@"stronghand" ,
            _compete ,@"compete" ,
            _stimulate ,@"stimulate", _phone ,@"token" ,nil];

    [PPNetworkHelper POST:setSkill parameters:params success:^(id data) {
                if([data[@"code"] isEqualToString:@"0000"]){
                    self.HUD.mode = MBProgressHUDModeText;
                    self.HUD.removeFromSuperViewOnHide = YES;
                    self.HUD.labelText = @"设置成功";
                    [self.HUD hide:YES afterDelay:3];
                    [self.navigationController popViewControllerAnimated:YES];
                }else {
                    self.HUD.mode = MBProgressHUDModeText;
                    self.HUD.removeFromSuperViewOnHide = YES;
                    self.HUD.labelText = @"系统错误";
                    [self.HUD hide:YES afterDelay:3];
                }

    }failure:^(NSError *error) {
        
    }];
    
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
    
    NSUInteger num = [_skill integerValue] + [_control integerValue] + [_counterattack integerValue]
    + [_stronghand integerValue] + [_compete integerValue] + [_stimulate integerValue];
    
    NSInteger leftnum = [_limitSkill integerValue] - num;
    CGSize left = [NSString
                    getStringContentSizeWithFontSize:13
                    andContent:[NSString stringWithFormat:@"剩余点数：%ld" , (long)leftnum]];
    currentData = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width - left.width - 20 - 5 , radarChart.bottom + 15 , left.width + 10 , left.height)] ;
    currentData.font = [UIFont systemFontOfSize:13];
    currentData.textColor = [UIColor colorWithHexString:@"999999"];
    currentData.text = [NSString stringWithFormat:@"剩余点数：%ld" , (long)leftnum] ;
    [cellView addSubview:currentData];

    
    MeView *meView = [[MeView alloc] init];
    meView.delegate = self ;
    UIView *skillView = [meView getImportData:@"个人技术" andWithRatioNum:_skill andWithMax :_total] ;
    skillView.origin = CGPointMake(0, dataLabel.bottom + 7) ;
    [cellView addSubview:skillView];
    
    MeView *meView2 = [[MeView alloc] init];
    meView2.delegate = self ;
    UIView *counter = [meView2 getImportData:@"防守反击" andWithRatioNum:_counterattack andWithMax :_total] ;
    counter.origin = CGPointMake(0, skillView.bottom) ;
    [cellView addSubview:counter];

    MeView *meView3 = [[MeView alloc] init];
    meView3.delegate = self ;
    UIView *personal = [meView3 getImportData:@"铁        腕" andWithRatioNum:_stronghand andWithMax :_total] ;
    personal.origin = CGPointMake(0, counter.bottom ) ;
    [cellView addSubview:personal];

    MeView *meView4 = [[MeView alloc] init];
    meView4.delegate = self ;
    UIView *duikang= [meView4 getImportData:@"对        抗" andWithRatioNum:_compete andWithMax :_total] ;
    duikang.origin = CGPointMake(0, personal.bottom) ;
    [cellView addSubview:duikang];

    MeView *meView5 = [[MeView alloc] init];
    meView5.delegate = self ;
    UIView *chuankong = [meView5 getImportData:@"传        控" andWithRatioNum:_control andWithMax :_total] ;
    chuankong.origin = CGPointMake(0, duikang.bottom ) ;
    [cellView addSubview:chuankong];

    MeView *meView6 = [[MeView alloc] init];
    meView6.delegate = self ;
    UIView *jili = [meView6 getImportData:@"激        励" andWithRatioNum:_stimulate andWithMax :_total] ;
    jili.origin = CGPointMake(0, chuankong.bottom ) ;
    [cellView addSubview:jili];
    
    CGSize jiaose = [NSString
                         getStringContentSizeWithFontSize:13
                         andContent:@"选择角色："];
    UILabel *jiaoseLabel = [[UILabel alloc] initWithFrame:
                                CGRectMake(12  , jili.bottom + 15, jiaose.width, jiaose.height)];
    jiaoseLabel.font = [UIFont systemFontOfSize:13];
    jiaoseLabel.textColor = [UIColor colorWithHexString:@"999999"];
    jiaoseLabel.text = @"选择角色：" ;
    [cellView addSubview:jiaoseLabel];
        
    BeginTouView *beginView2 = [[BeginTouView alloc] init];
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc]
                                              initWithTarget:
                                              self action:@selector(sendrole)];
    
    UIView *use = [beginView2 getBeginTouView:@"角        色" andWithTintTitle:@"教练" andWithEndImage:@"extend" andWithImageSize:CGSizeMake(15/2, 14) andPoint:CGPointMake(0, jiaoseLabel.bottom + 7) andWithTag:2];
    [use setUserInteractionEnabled:NO];
    [use addGestureRecognizer:singleTap2];
    [cellView addSubview:use];
    
    cellView.frame = CGRectMake(0, 0, kScreen_Width, use.bottom - 0) ;
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
    return 850 ;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)meData : (NSString *)title andWithValue : (NSString *)value andWithRawValue : (NSString *)rawnum{
   
    if ([title rangeOfString:@"个"].location != NSNotFound) {
        _skill = value ;
    }
    if ([title rangeOfString:@"防"].location != NSNotFound) {
        _counterattack = value ;
    }
    if ([title rangeOfString:@"铁"].location != NSNotFound) {
        _stronghand = value ;
    }
    if ([title rangeOfString:@"对"].location != NSNotFound) {
        _compete = value ;
    }
    if ([title rangeOfString:@"传"].location != NSNotFound) {
        _control =value ;
    }
    if ([title rangeOfString:@"激"].location != NSNotFound) {
        _stimulate = value ;
    }

    NSUInteger num = [_skill integerValue] + [_control integerValue] + [_counterattack integerValue]
    + [_stronghand integerValue] + [_compete integerValue] + [_stimulate integerValue];
    
    NSInteger leftnum = [_limitSkill integerValue] - num;
    currentData.text = [NSString stringWithFormat:@"剩余点数：%ld" , (long)leftnum] ;
    
    if (num > [_limitSkill integerValue]) {
        self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.removeFromSuperViewOnHide = YES;
        self.HUD.labelText = [NSString stringWithFormat:@"当前设置已经超过总的能力值%@" ,_limitSkill];
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
