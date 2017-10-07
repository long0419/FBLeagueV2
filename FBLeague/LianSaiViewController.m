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

@interface LianSaiViewController (){
    NSString *title ;
    YYCache *cache ;
    UserDataVo *uvo ;
    NSString *adurls ;
    NSString *leagueId ;
    UIButton *backViewBtn ;
    UIButton *explainViewBtn ;
    NSUInteger index_ ;
}

@end

@implementation LianSaiViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sairesult:) name:@"saiResult" object:nil];
    
    index_ = 0 ;
    
    [self getNeedData] ;

    //获取红点数据
    [self getRedPotData];
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


-(void)getNeedData{
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:liansaidetail parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            self.title = object[@"league"][@"name"];
            adurls = object[@"league"][@"adurls"] ;
            _dataArray = [adurls componentsSeparatedByString:@","];
            leagueId = object[@"league"][@"id"] ;
            
            [self setupBanner];
            
            [self setRightBottom];

        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)setRightBottom {
    backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 17, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"addcircle"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(goAction)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.rightBarButtonItem = backItem ;
    
    explainViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    explainViewBtn.frame = CGRectMake(0, 0, 17, 17);
    [explainViewBtn setImage:[UIImage imageNamed:@"explain"] forState:UIControlStateNormal];
    [explainViewBtn addTarget:self action: @selector(explain)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:explainViewBtn];
    self.navigationItem.leftBarButtonItem = backItem2 ;
}

-(void)explain{
    
}

-(void)goAction{
    self.hidesBottomBarWhenPushed = YES ;
    if (index_ == 0) {
        AddSaiViewController *add = [AddSaiViewController new] ;
        add.leagueId = leagueId ;
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

@end
