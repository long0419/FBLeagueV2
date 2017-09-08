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
    
    [self getNeedData] ;
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
            // 配置banner
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
        [self.navigationController pushViewController:add animated:YES];
    }else if(index_ == 1){
        AddSaiTimeViewController *time = [AddSaiTimeViewController new];
        [self.navigationController pushViewController:time animated:YES];
    }
    self.hidesBottomBarWhenPushed = NO ;
}


- (void)setupBanner
{
    // 初始化
    self.banner = [[ZYBannerView alloc] init];
    self.banner.dataSource = self;
    self.banner.delegate = self;
    [self.view addSubview:self.banner];

    // 设置frame
    self.banner.frame = CGRectMake(0,
                                   64.0,
                                   kScreen_Width,
                                   100);
    self.banner.shouldLoop = YES;
    self.banner.autoScroll = NO;
    
    BaomingViewController *dongtai = [BaomingViewController new] ;
    dongtai.leagueId = leagueId ;
    
    SaiListViewController *focus = [SaiListViewController new];
    focus.leagueId = leagueId ;

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
