//
//  LianSaiViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/27.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "LianSaiViewController.h"
#import "DongtaiViewController.h"
#import "ClassesViewController.h"
#import "JiFenViewController.h"
#import "BaomingViewController.h"
#import "SaiListViewController.h"
#import "ReadDetailContentViewController.h"
#import "BeiSaiNumViewController.h"
#import "LianSaiView.h"
#import "LangResultListViewController.h"
#import "HuResultListViewController.h"

@interface LianSaiViewController (){
    NSString *title ;
    YYCache *cache ;
    UserDataVo *uvo ;
    NSString *adurls ;
    NSString *leagueId ;
    UIButton *backViewBtn ;
    UIButton *explainViewBtn ;
    NSUInteger index_ ;
    UIButton *sender ;
    NSString *clubId ;
    NSString *lid ;
}

@end

@implementation LianSaiViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sairesult:) name:@"saiResult" object:nil];
    
    [self getLeagueStatus : @"" andWithAreaName:@""];
    
    //获取红点数据
    [self getRedPotData];
}

-(void)status2 :(CupRoundVo *) vo andWithAreaCode :(NSString *)areacode{
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kScreen_Width, 60 + 130/2 + 82/2 + 78/2 + 60)];
    bg.backgroundColor = [UIColor colorWithHexString:@"323c45"];
    [self.view addSubview:bg];
    
    UIView *lunleft = [LianSaiView getLunContent:[NSString stringWithFormat:@"第%@轮" , vo.wolfRoundNum] andWithColor:@"0b63ac" andWithFontSize:15];
    lunleft.origin = CGPointMake(0, 20 + 44);
    [bg addSubview:lunleft];
    
    UIView *lunleft2 = [LianSaiView getLunContent:[NSString stringWithFormat:@"%@ ~ %@" , vo.wolfRoundBeginDate , vo.wolfRoundEndDate] andWithColor:@"2473b4" andWithFontSize:12];
    lunleft2.origin = CGPointMake(0, lunleft.bottom);
    [bg addSubview:lunleft2];
    
    UIView *lunright = [LianSaiView getLunContent:[NSString stringWithFormat:@"第%@轮" , vo.tigerRoundNum] andWithColor:@"c51a3e" andWithFontSize:15];
    lunright.origin = CGPointMake(lunleft.right , 20 + 44);
    [bg addSubview:lunright];
    
    UIView *lunright2 = [LianSaiView getLunContent:[NSString stringWithFormat:@"%@ ~ %@" , vo.tigerRoundBeginDate , vo.tigerRoundEndDate] andWithColor:@"cb3152" andWithFontSize:12];
    lunright2.origin = CGPointMake(lunleft2.right , lunleft.bottom);
    [bg addSubview:lunright2];


    UIImageView *vs = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VS-队徽用"]];
    vs.frame = CGRectMake((kScreen_Width - 122/2)/2 , 68/2 + lunright2.bottom , 122/2 , 160/2);
    [bg addSubview:vs];

    UIView *langdui = [LianSaiView getDuiView:@"1" andWithNum:@"1025" andWithPoint:CGPointMake(20, 60 + 78/2 + 20 + 44)];
    [bg addSubview:langdui];

    UIView *hudui = [LianSaiView getDuiView:@"2" andWithNum:@"925" andWithPoint:CGPointMake(kScreen_Width - 20 - 236/2, 60 + 78/2 + 20 + 44)];
    [bg addSubview:hudui];

    LangResultListViewController *langlist = [LangResultListViewController new];
    langlist.leagueId = lid ;
    langlist.clubId = clubId ;
    langlist.camp = @"2" ;
    langlist.areaCode = areacode ;
    langlist.roundNum = vo.wolfRoundNum ;
    
    HuResultListViewController *hu =[HuResultListViewController new];
    hu.leagueId = lid ;
    hu.clubId = clubId ;
    hu.camp = @"1" ;
    hu.areaCode = areacode ;
    hu.roundNum = vo.tigerRoundNum ;

    NSArray *viewControllers = @[@{@"狼队":langlist},
                                 @{@"虎队":hu}];
    YCSlideView * view = [[YCSlideView alloc] initWithFrame:CGRectMake(0, bg.bottom , kScreen_Width, kScreen_Height - bg.height - 40 - 49 - 20 - 60) WithViewControllers:viewControllers] ;
    [self.view addSubview:view];
    
}

-(void)status :(NSString *)tigerCount andWith :(NSString *)bonus andWithWolfCount :(NSString *)wolfCount{
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"首页底背景"]];
    bg.frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height);
    [self.view addSubview:bg];

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    UIImageView *lang = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"首页狼队徽"]];
    lang.frame = CGRectMake(84/2 , 94/2 + 20 + 44 , 208/2, 208/2);
    lang.userInteractionEnabled = YES;
    lang.accessibilityHint = @"2" ;
    [lang addGestureRecognizer:singleTap];
    [self.view addSubview:lang];
    
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    UIImageView *hu = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"首页虎队徽"]];
    hu.frame = CGRectMake(kScreen_Width - 84/2 - 208/2 , 94/2 + 20 + 44, 208/2 , 208/2);
    hu.userInteractionEnabled = YES;
    hu.accessibilityHint = @"1" ;
    [hu addGestureRecognizer:singleTap2];
    [self.view addSubview:hu];
    
    UIImageView *vs = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VS-队徽用"]];
    vs.frame = CGRectMake((kScreen_Width - 122/2)/2 , 94/2 + 20 + 44 + 15, 122/2 , 160/2);
    [self.view addSubview:vs];
    
    UIView *langdui = [LianSaiView getDuiView:@"1" andWithNum:tigerCount andWithPoint:CGPointMake(35, lang.bottom + 20)];
    [self.view addSubview:langdui];
    
    UIView *hudui = [LianSaiView getDuiView:@"2" andWithNum:wolfCount andWithPoint:CGPointMake(kScreen_Width - 35 - 236/2, lang.bottom + 20)];
    [self.view addSubview:hudui];
    
    UIImageView *jiangjin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"奖金池底背景"]];
    jiangjin.frame = CGRectMake((kScreen_Width - 200)/2, 120/2 + hudui.bottom , 200 , 178/2);
    [self.view addSubview:jiangjin];
    
    CGSize titleSize11 = [NSString getStringContentSizeWithFontSize:36/2 andContent:@"奖金池"];
    UILabel *titleLabel11 = [[UILabel alloc] initWithFrame:CGRectMake((jiangjin.width - titleSize11.width)/2 , 10 , titleSize11.width, titleSize11.height)];
    titleLabel11.font = [UIFont systemFontOfSize:36/2];
    titleLabel11.textColor = [UIColor colorWithHexString:@"ffffff"];
    titleLabel11.text = @"奖金池";
    [jiangjin addSubview:titleLabel11];
    
    CGSize titleSize12 = [NSString getStringContentSizeWithFontSize:36/2 andContent:[NSString stringWithFormat:@"%@元" , bonus]];
    UILabel *titleLabel12 = [[UILabel alloc] initWithFrame:CGRectMake((jiangjin.width - titleSize12.width)/2 , 25 + titleLabel11.bottom , titleSize12.width, titleSize12.height)];
    titleLabel12.font = [UIFont systemFontOfSize:36/2];
    titleLabel12.textColor = [UIColor colorWithHexString:@"ffffff"];
    titleLabel12.text = [NSString stringWithFormat:@"%@元" , bonus] ;
    [jiangjin addSubview:titleLabel12];
    
    UIImageView *btn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"竞赛章程按钮"]];
    btn.frame = CGRectMake((kScreen_Width - 200)/2, jiangjin.bottom + 108/2, 200, 185/4) ;
    [self.view addSubview:btn];
    btn.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [btn addGestureRecognizer:tap];
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:36/2 andContent:@"竞赛章程"];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((btn.width - titleSize.width)/2 , (btn.height - titleSize.height)/2 - 3 , titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:36/2];
    titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    titleLabel.text = @"竞赛章程";
    [btn addSubview:titleLabel];
}

-(void)tap :(UIImageView *) view{
    self.hidesBottomBarWhenPushed = YES ;
    AddSaiViewController *add = [AddSaiViewController new] ;
    add.leagueId = leagueId ;
    add.cupType = @"2" ;
    add.camp = view.accessibilityHint ;
    [self.navigationController pushViewController:add animated:YES];
    self.hidesBottomBarWhenPushed = NO ;
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    self.hidesBottomBarWhenPushed = YES ;
    BeiSaiNumViewController *beisai = [BeiSaiNumViewController new];
    [self.navigationController pushViewController:beisai animated:YES];
    self.hidesBottomBarWhenPushed = NO ;
    
}

-(void)getRedPotData{
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone , @"phone" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:getUnreadCount parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            
            NSString *likeCount = object[@"unreadCount"][@"likeCount"];
            NSString *followCount = object[@"unreadCount"][@"followCount"];
            NSString *atCount = object[@"unreadCount"][@"atCount"];
            
            NSInteger total = likeCount.integerValue + followCount.integerValue + atCount.integerValue ;
            
            NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld" , total] ,@"textOne",nil];

            if (total > 0) {

                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"showspot" object:nil userInfo:dict] ;
                
            }
        }
    } failure:^(NSError *error) {
        
    }];

}

-(void)sairesult :(NSNotification *)notification{
    SaiChengVo *vo = [notification object];
    
    self.hidesBottomBarWhenPushed=YES;
    SaiResultViewController *mem = [SaiResultViewController new] ;
    mem.vo = vo ;
    mem.matchId = vo.matchid ;
    [self.navigationController pushViewController:mem animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"saiResult" object:nil];
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

}

-(void)getLeagueStatus :(NSString *)areaCode andWithAreaName :(NSString *)areaName{
    
    if (![areaCode isEqualToString:@""] && ![areaName isEqualToString:@""]) {
        [SVProgressHUD show];
    }
    
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.phone, @"phone" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:leagueshow parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            _type = object[@"show"] ;
            if ([_type isEqualToString:@"1"]) {
                index_ = 0 ;
                [self getNeedData] ;
            }else{
                [PPNetworkHelper POST:leaguedefault parameters:params success:^(id object) {
                    if([object[@"code"] isEqualToString:@"0000"]){
                        NSString *hasJoinin = object[@"hasJoinin"];
                        self.title = object[@"leagueCup"][@"name"] ;
                        lid = object[@"leagueCup"][@"id"] ;
                        if ([hasJoinin isEqualToString:@"n"]) {
                            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: lid , @"leagueId" , uvo.phone, @"phone" , uvo.phone ,  @"token", nil];
                            [PPNetworkHelper POST:getJoininCount parameters:params success:^(id object) {
                                if([object[@"code"] isEqualToString:@"0000"]){
                                    NSString *tigerCount = object[@"tigerCount"];
                                    NSString *bonus = object[@"bonus"];
                                    NSString *wolfCount = object[@"wolfCount"] ;

                                    [self status :tigerCount andWith:bonus andWithWolfCount:wolfCount];
                                    
                                    [SVProgressHUD dismiss];

                                }
                            } failure:^(NSError *error) {
                                
                            }];
                            
                        }else{
                            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.phone ,  @"phone" , uvo.phone , @"token" , nil];
                            [PPNetworkHelper POST:getCBDetail parameters:params success:^(id data) {
                                if([data[@"code"] isEqualToString:@"0000"]){
                                    NSString *areacode = data[@"user"][@"areacode"] ;
                                    NSString *areaname = data[@"user"][@"areaname"] ;
                                    clubId = data[@"user"][@"club"];
                                    
                                    NSDictionary *tmp = nil ;
                                    if ([areaCode isEqualToString:@""] && [areaName isEqualToString:@""]) {
                                        tmp = [NSDictionary dictionaryWithObjectsAndKeys: lid , @"leagueId" ,areacode , @"areaCode" , uvo.phone ,  @"phone" , uvo.phone , @"token" , nil];
                                    }else{
                                        tmp = [NSDictionary dictionaryWithObjectsAndKeys: lid , @"leagueId" ,areaCode , @"areaCode" , uvo.phone ,  @"phone" , uvo.phone , @"token" , nil];
                                        areacode = areaCode ;
                                        areaname = areaName ;
                                    }
                                    
                                    [PPNetworkHelper POST:getAreaJoininCount parameters:tmp success:^(id data) {
                                        if([data[@"code"] isEqualToString:@"0000"]){
                                            CupRoundVo *vo = [CupRoundVo new] ;
                                            vo.wolfRoundEndDate = data[@"wolfRoundEndDate"];
                                            vo.tigerRoundEndDate = data[@"tigerRoundEndDate"];
                                            vo.tigerRoundNum = data[@"tigerRoundNum"];
                                            vo.wolfCount = data[@"wolfCount"];
                                            vo.wolfRoundBeginDate = data[@"wolfRoundBeginDate"];
                                            vo.wolfRoundNum = data[@"wolfRoundNum"];
                                            vo.tigerRoundBeginDate = data[@"tigerRoundBeginDate"];
                                            vo.tigerCount = data[@"tigerCount"];

                                            [self setLeftBottom : areaname];
                                            [self status2 : vo andWithAreaCode:areacode] ;
                                            
                                        }else {
                                            [SVProgressHUD showErrorWithStatus: @"系统错误"];
                                            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                                        }
                                        
                                        [SVProgressHUD dismiss];

                                    } failure:^(NSError *error) {
                                    }];
                                }else {
                                    [SVProgressHUD showErrorWithStatus: @"系统错误"];
                                    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                                }
                            } failure:^(NSError *error) {
                            }];
                            
                        }
                    }
                } failure:^(NSError *error) {
                    
                }];
                
            }

        }
    } failure:^(NSError *error) {
        
    }];

}

-(void)getNeedData{
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    [SVProgressHUD show];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone ,@"phone" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:liansaidetail parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            self.title = object[@"league"][@"name"];
            adurls = object[@"league"][@"adurls"] ;
            _dataArray = [adurls componentsSeparatedByString:@","];
            leagueId = object[@"league"][@"id"] ;
            NSString *hasJoinin = object[@"hasJoinin"];

            [self setupBanner];
            
            [self setRightBottom : hasJoinin andWithType:@"1"];
            
            explainViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            explainViewBtn.frame = CGRectMake(0, 0, 17, 17);
            [explainViewBtn setImage:[UIImage imageNamed:@"explain"] forState:UIControlStateNormal];
            [explainViewBtn addTarget:self action: @selector(explain)
                     forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:explainViewBtn];
            self.navigationItem.leftBarButtonItem = backItem2 ;

        }
        [SVProgressHUD dismiss];

    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)setLeftBottom :(NSString *)areaname{
    CGSize size = [NSString getStringContentSizeWithFontSize:15 andContent:[NSString stringWithFormat:@"> %@" , areaname]] ;
    sender = [UIButton buttonWithType:UIButtonTypeCustom];
    sender.frame = CGRectMake(0, 0, size.width + 20 , size.height);
    [sender setTitle:[NSString stringWithFormat:@"> %@" , areaname] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize: 15];
    [sender setTitleColor:[UIColor colorWithHexString:@"ffffff"]forState:UIControlStateNormal];
    [sender addTarget:self action: @selector(chooseArea)
         forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:sender];
    self.navigationItem.leftBarButtonItem = backItem ;

}


- (void)setRightBottom :(NSString *) hasJoinin andWithType : (NSString *) type{
    backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 17, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"addcircle"] forState:UIControlStateNormal];
    backViewBtn.accessibilityHint = type ;
    [backViewBtn addTarget:self action: @selector(goAction:)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.rightBarButtonItem = backItem ;
    
    if ([hasJoinin isEqualToString:@"y"] && index_ == 0) {
        self.navigationItem.rightBarButtonItem.customView.hidden = YES ;
    }
    
}

-(void)chooseArea{
    XPAddressPicker *picker = [[XPAddressPicker alloc] init];
    picker.delegate = self;
    [picker setSelectionAddressForId:@"420000"];
    [picker show];

}

-(void)explain{
    self.hidesBottomBarWhenPushed = YES ;
    ReadDetailContentViewController *read = [ReadDetailContentViewController new];
    read.type = @"1" ;
    [self.navigationController pushViewController:read animated:YES];
    self.hidesBottomBarWhenPushed = NO ;
}

-(void)goAction : (UIButton *) btn{
    self.hidesBottomBarWhenPushed = YES ;
    if (index_ == 0) {
        AddSaiViewController *add = [AddSaiViewController new] ;
        add.leagueId = leagueId ;
        add.cupType = btn.accessibilityHint ;
        [self.navigationController pushViewController:add animated:YES];
    }else if(index_ == 1){
        AddSaiTimeViewController *time = [AddSaiTimeViewController new];
        time.leagueId = leagueId ;
        [self.navigationController pushViewController:time animated:YES];
    }
    self.hidesBottomBarWhenPushed = NO ;
}


- (void)setupBanner
{
    self.banner = [[ZYBannerView alloc] init];
    self.banner.dataSource = self;
    self.banner.delegate = self;
    self.banner.frame = CGRectMake(0, 64.0, kScreen_Width, 100);
    self.banner.shouldLoop = YES;
    self.banner.autoScroll = NO;
    [self.view addSubview:self.banner];
    

    BaomingViewController *dongtai = [BaomingViewController new] ;
    dongtai.leagueId = leagueId ;
    
    SaiListViewController *focus = [SaiListViewController new];
    focus.leagueId = leagueId ;
    focus.from = @"0" ;
    
    JiFenViewController *jifen = [JiFenViewController new] ;
    jifen.leagueId = leagueId ;

    NSArray *viewControllers = @[@{@"报名":dongtai}, @{@"赛程":focus}, @{@"积分":jifen}];
    YCSlideView * view = [[YCSlideView alloc] initWithFrame:CGRectMake(0, self.banner.bottom, kScreen_Width, kScreen_Height - 20 - 44) WithViewControllers:viewControllers] ;
    view.delegate = self ;
    [self.view addSubview:view];

}

#pragma mark - ZYBannerViewDataSource

// 返回 Banner 需要显示 Item(View) 的个数
- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner
{
    return self.dataArray.count;
}

// 返回 Banner 在不同的 index 所要显示的 View (可以是完全自定义的v iew, 且无需设置 frame)
- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index
{
    // 取出数据
    NSString *imageName = self.dataArray[index];
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    NSURL *imageUrl = [NSURL URLWithString:imageName];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}


#pragma mark Getter

- (NSArray *)dataArray
{
    return _dataArray;
}

-(void) getScrollIndex :(NSInteger) index {
    if (index == 2) {
        backViewBtn.hidden = YES ;
    }else{
        backViewBtn.hidden = NO ;
        explainViewBtn.hidden = NO ;
        if (index == 0) {
            [backViewBtn setImage:[UIImage imageNamed:@"addcircle"] forState:UIControlStateNormal];
        }else{
            explainViewBtn.hidden = YES ;
            [backViewBtn setImage:[UIImage imageNamed:@"clock"] forState:UIControlStateNormal];
        }
    }
    index_ = index ;
}

- (void)addressPicker:(XPAddressPicker *)picker didFinishPickingAddress:(NSDictionary<NSString *,NSDictionary *> *)info {
    NSDictionary *province = info[XPAddressPickerProvinceKey];
    NSDictionary *city = info[XPAddressPickerCityKey];
    NSDictionary *county = info[XPAddressPickerCountyKey];
    
    NSString *provinceName = province[XPAddressPickerNameKey];
    NSString *cityName = city[XPAddressPickerNameKey];
    
    NSString *ID = city[XPAddressPickerIdKey];
    NSMutableString *string = [[NSMutableString alloc] initWithFormat:@"%@ %@", provinceName, cityName];
    if (nil != county) {
        NSString *countyName = county[XPAddressPickerNameKey];
        ID = county[XPAddressPickerIdKey];
        [string appendFormat:@"%@", countyName];
        [sender setTitle:[NSString stringWithFormat:@"> %@" ,countyName] forState:UIControlStateNormal];
        NSArray *views = [self.view subviews];
        for(UIView *view in views){
            [view removeFromSuperview];
        }
        [self getLeagueStatus : ID andWithAreaName:countyName];
    }
//    [string appendFormat:@" id:%@", ID];
    
}

@end
