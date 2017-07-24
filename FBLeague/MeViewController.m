//
//  MeViewController.m
//  league
//
//  Created by long-laptop on 2016/11/7.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController (){
    UserDataVo *uvo ;
    YYCache *cache ;

}

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我" ;
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"                        ];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 40 + 22 + 23 , kScreen_Width,  220/2)];
    header.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:header];
    
    UIImageView *head ;
    if (nil == uvo.headpicurl || [@"" isEqualToString:uvo.headpicurl]) {
        head = [[UIImageView alloc]
                initWithImage:[UIImage imageNamed:@"defaulthead"]];
    }else{
        head = [[UIImageView alloc] init];
        [head sd_setImageWithURL:[NSURL URLWithString:uvo.headpicurl] placeholderImage:nil];
    }
    head.frame = CGRectMake(30, (header.height - 70)/2 , 140/2, 140/2) ;
    head.layer.masksToBounds =YES;
    head.layer.cornerRadius = 10 ;
    [header addSubview:head];
    
    NSString *name = @"武汉体育学院足协代表队" ;
    CGSize nameSize = [NSString getStringContentSizeWithFontSize:34/2 andContent:name];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(head.right + 12 , head.top , nameSize.width, nameSize.height)];
    nameLabel.font = [UIFont systemFontOfSize:30/2];
    nameLabel.textColor = [UIColor colorWithHexString:@"000"];
    nameLabel.text = name ;
    [header addSubview:nameLabel];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:10];
    titleLabel.numberOfLines = 0;//多行显示，计算高度
    titleLabel.textColor = [UIColor colorWithHexString:@"000"];
    //    NSString *desc =  [CommonFunc textFromBase64String:vo.desc];
    NSString *desc = @"不错 不错" ;
    CGSize titleSize = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc];
    titleLabel.size = titleSize;
    titleLabel.text = desc ;
    titleLabel.x = nameLabel.left ;
    titleLabel.y = nameLabel.bottom + 5 ;
    [header addSubview:titleLabel];
    
    UILabel *titleLabel2 = [UILabel new];
    titleLabel2.font = [UIFont systemFontOfSize:10];
    titleLabel2.numberOfLines = 0;//多行显示，计算高度
    titleLabel2.textColor = [UIColor colorWithHexString:@"000"];
    //    NSString *desc =  [CommonFunc textFromBase64String:vo.desc];
    NSString *desc2 = @"口号：备战特步大学生足球联赛" ;
    CGSize titleSize2 = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc2];
    titleLabel2.size = titleSize2;
    titleLabel2.text = desc2 ;
    titleLabel2.x = nameLabel.left ;
    titleLabel2.y = titleLabel.bottom + 5 ;
    [header addSubview:titleLabel2];
    
    UILabel *titleLabel3 = [UILabel new];
    titleLabel3.font = [UIFont systemFontOfSize:10];
    titleLabel3.numberOfLines = 0;//多行显示，计算高度
    titleLabel3.textColor = [UIColor colorWithHexString:@"000"];
    //    NSString *desc =  [CommonFunc textFromBase64String:vo.desc];
    NSString *desc3 = @"关注：200     粉丝：200" ;
    CGSize titleSize3 = [NSString getMultiStringContentSizeWithFontSize:10 andContent:desc2];
    titleLabel3.size = titleSize3;
    titleLabel3.text = desc3 ;
    titleLabel3.x = nameLabel.left ;
    titleLabel3.y = titleLabel2.bottom + 5 ;
    [header addSubview:titleLabel3];

    UIImageView *next = [[UIImageView alloc]
                         initWithImage:[UIImage imageNamed:@"下一步"]];
    next.frame = CGRectMake(kScreen_Width - 30, (header.height - 20)/2 , 20/2, 40/2) ;
    [header addSubview:next];
    
    UIView *atme = [self getItemViewByPic:@"@" andWithName:@"@我的"];
    atme.origin = CGPointMake(0, header.bottom + 20);
    [self.view addSubview:atme];
}

-(UIView *)getItemViewByPic : (NSString *)pic andWithName : (NSString *)name {
    UIView *item = [[UIView alloc] init];
    item.size = CGSizeMake(kScreen_Width, 44);
    item.backgroundColor = [UIColor whiteColor];
    
    UIImageView *head = [[UIImageView alloc]
                initWithImage:[UIImage imageNamed:pic]];
    head.frame = CGRectMake(30, 26/2 , 40/2, 40/2) ;
    [item addSubview:head];
    
    QMUILabel *label1 = [[QMUILabel alloc] init];
    label1.text = name ;
    label1.font = UIFontMake(12);
    label1.textColor = UIColorBlack ;
    [label1 sizeToFit];
    [item addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(item);
        make.left.mas_equalTo(head.mas_right).with.offset(36/2);
    }];

    UIImageView *next = [[UIImageView alloc]
                         initWithImage:[UIImage imageNamed:@"下一步"]];
    next.frame = CGRectMake(kScreen_Width - 30, 26/2 , 20/2, 40/2) ;
    [item addSubview:next];

    return item ;
}

@end
