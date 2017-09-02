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

@interface LianSaiViewController ()

@end

@implementation LianSaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"咖盟联赛" ;
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    // 配置banner
    [self setupBanner];

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
    
    
    DongtaiViewController *dongtai = [DongtaiViewController new] ;
    dongtai.type = @"2" ;
    dongtai.height = self.view.frame.size.height - 20 - 44 - 98/2 - 36 - 66 ;
    
    ClassesViewController *focus = [ClassesViewController new];
    
    JiFenViewController *jifen = [JiFenViewController new] ;
    
    NSArray *viewControllers = @[@{@"报名":dongtai}, @{@"赛程":focus}, @{@"积分":jifen}];
    YCSlideView * view = [[YCSlideView alloc] initWithFrame:CGRectMake(0, self.banner.bottom, kScreen_Width, kScreen_Height - 20 - 44) WithViewControllers:viewControllers] ;
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
    imageView.image = [UIImage imageNamed:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}


#pragma mark Getter

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"ad_0.jpg", @"ad_1.jpg", @"ad_2.jpg"];
    }
    return _dataArray;
}

@end
