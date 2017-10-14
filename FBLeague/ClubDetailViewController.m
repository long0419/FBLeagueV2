//
//  ClubDetailViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/26.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "ClubDetailViewController.h"

@interface ClubDetailViewController (){
    UserDataVo *uvo ;
    YYCache *cache ;
}


@end

@implementation ClubDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    [self setBackBottmAndTitle];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"parentTopBackgroupd"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    
    self.title = [CommonFunc textFromBase64String:_clubVo.name] ;
    
    [self setJulebuView];
    
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)setJulebuView{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 40 + 22 , kScreen_Width,  160)];
    header.backgroundColor = [UIColor colorWithHexString:@"252525"];
    [self.view addSubview:header];
    
    UIImageView *head ;
    if (nil == _clubVo.logourl || [@"<null>" isEqualToString:_clubVo.logourl]) {
        head = [[UIImageView alloc]
                initWithImage:[UIImage imageNamed:@"head"]];
    }else{
        head = [[UIImageView alloc] init];
        [head sd_setImageWithURL:[NSURL URLWithString:_clubVo.logourl] placeholderImage:nil];
    }
    head.frame = CGRectMake((kScreen_Width - 120/2)/2, 5 , 120/2, 120/2) ;
    head.layer.masksToBounds =YES;
    head.layer.cornerRadius = 120/4 ;
    [header addSubview:head];
    
    NSString *name = [NSString stringWithFormat:@"%@ %@" , _clubVo.name , _clubVo.areaname] ;
    CGSize nameSize = [NSString getStringContentSizeWithFontSize:34/2 andContent:name];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreen_Width - nameSize.width)/2 , head.bottom + 5 , nameSize.width, nameSize.height)];
    nameLabel.font = [UIFont systemFontOfSize:30/2];
    nameLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    nameLabel.text = name ;
    [header addSubview:nameLabel];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:10];
    titleLabel.numberOfLines = 0;//多行显示，计算高度
    titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    NSString *desc = _clubVo.desc ;
    CGSize titleSize = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc];
    titleLabel.size = titleSize;
    titleLabel.text = desc ;
    titleLabel.x = (kScreen_Width - titleSize.width)/2 ;
    titleLabel.y = nameLabel.bottom + 5 ;
    [header addSubview:titleLabel];
    
    UILabel *titleLabel2 = [UILabel new];
    titleLabel2.font = [UIFont systemFontOfSize:10];
    titleLabel2.numberOfLines = 0;//多行显示，计算高度
    titleLabel2.textColor = [UIColor colorWithHexString:@"ffffff"];
    NSString *desc2 = [NSString stringWithFormat:@"%@" ,@"咖盟未认证" ];
    if (![_clubVo.certification isEqualToString:@"<null>"]) {
        desc2 = [NSString stringWithFormat:@"咖盟认证号：%@" , _clubVo.certification];
    }
    CGSize titleSize2 = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc2];
    titleLabel2.size = titleSize2;
    titleLabel2.text = desc2 ;
    titleLabel2.x = (kScreen_Width - titleSize2.width)/2 ;
    titleLabel2.y = titleLabel.bottom + 5 ;
    [header addSubview:titleLabel2];
    
    UILabel *titleLabel3 = [UILabel new];
    titleLabel3.font = [UIFont systemFontOfSize:10];
    titleLabel3.numberOfLines = 0;//多行显示，计算高度
    titleLabel3.textColor = [UIColor colorWithHexString:@"ffffff"];
    NSString *desc3 = [NSString stringWithFormat:@"粉丝：%@" , _clubVo.fansCount] ;
    CGSize titleSize3 = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc3];
    titleLabel3.size = titleSize3;
    titleLabel3.text = desc3 ;
    titleLabel3.x = (kScreen_Width - titleSize3.width)/2 ;
    titleLabel3.y = titleLabel2.bottom + 5 ;
    [header addSubview:titleLabel3];
    
    MemeberDataViewController *dongtai = [MemeberDataViewController new] ;
    
    DongtaiViewController *focus = [DongtaiViewController new];
    focus.type = @"3" ;
    focus.phone = _clubVo.areacode ;
    
    ClassesViewController *jiaolian = [ClassesViewController new] ;
    
    NSArray *viewControllers = @[
                                 @{@"他的动态":focus},
                                 @{@"他的数据":jiaolian}];
    
    YCSlideView * view = [[YCSlideView alloc] initWithFrame:CGRectMake(0, header.bottom, kScreen_Width, kScreen_Height - 20 - 44) WithViewControllers:viewControllers] ;
    [self.view addSubview:view];
    
}

@end