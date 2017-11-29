//
//  LianSaiView.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/6.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "LianSaiView.h"
#import "TYMProgressBarView.h"

@implementation LianSaiView

-(UIView *)BaomingView :(NSString *)title andWithName :(NSString *)name andWithLineData:(NSString *)now withTotal :(NSString *)total {
    UIView *view  = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, kScreen_Width, 70) ;
    [self addSubview:view];
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:11 andContent:title];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 ,12, titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:11];
    titleLabel.textColor = [UIColor colorWithHexString:@"000000"];
    titleLabel.text = title;
    [self addSubview:titleLabel];
    
    CGSize titleSize2 = [NSString getStringContentSizeWithFontSize:11 andContent:[NSString stringWithFormat:@"%@ %@/%@" , name , now ,total]];
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width - 12 - titleSize2.width ,12, titleSize2.width, titleSize2.height)];
    titleLabel2.font = [UIFont systemFontOfSize:11];
    titleLabel2.textColor = [UIColor colorWithHexString:@"000000"];
    titleLabel2.text = [NSString stringWithFormat:@"%@ %@/%@" , name , now ,total] ;
    [self addSubview:titleLabel2];

    TYMProgressBarView *progressBarView = [[TYMProgressBarView alloc] initWithFrame:CGRectMake(12 , titleLabel2.bottom + 12 , kScreen_Width - 24 , 10)];
    progressBarView.barBorderWidth = 1.0;
    progressBarView.barBorderColor = [UIColor colorWithHexString:@"ef8645"];
    progressBarView.progress = [now floatValue]/[total floatValue];
    progressBarView.barFillColor = [UIColor colorWithHexString:@"f8845c"] ;
    [self addSubview:progressBarView];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 70, kScreen_Width, .5)];
    line.backgroundColor = [UIColor blackColor];
    [self addSubview:line];
    
    return view ;
}


-(UIView *)getSaiLineView :(NSString *) content andWithType :(NSString *)type{
    NSString *colorname = @"ffffff" ;
    
    if ([type isEqualToString:@"33"]) {
        colorname = @"f8845c" ;
    }else if([type isEqualToString:@"22"]){
        colorname = @"5b73d4" ;
    }else if([type isEqualToString:@"1"]){
        colorname = @"179387" ;
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 80/2)];
    lineView.backgroundColor = [UIColor colorWithHexString:colorname] ;
    [self addSubview:lineView];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kScreen_Width, .5)];
    line1.backgroundColor = [UIColor blackColor];
    [lineView addSubview:line1];

    CGSize titleSize = [NSString getStringContentSizeWithFontSize:11 andContent:content];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width - 12 - titleSize.width , (80/2 - titleSize.height)/2, titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:11];
    titleLabel.textColor = [UIColor colorWithHexString:@"000000"];
    titleLabel.text = content;
    [lineView addSubview:titleLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 80/2, kScreen_Width, .5)];
    line.backgroundColor = [UIColor blackColor];
    [lineView addSubview:line];
    
    return lineView ;
}

+ (UIView *)getLunContent :(NSString *)content andWithColor:(NSString *) color  andWithFontSize :(int) size {
    UIView *contentView = [[UIView alloc] init];
    contentView.size = CGSizeMake(kScreen_Width/2, 30) ;
    contentView.backgroundColor = [UIColor colorWithHexString:color];
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:size andContent:content];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreen_Width/2 - titleSize.width)/2 , 7 , titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:size];
    titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    titleLabel.text = content;
    [contentView addSubview:titleLabel];

    return contentView ;
}

+ (UIView *)getDuiView :(NSString *) type andWithNum :(NSString *) num andWithPoint : (CGPoint) point {
    UIView *duiView = [[UIView alloc] init];
    duiView.origin = point ;
    duiView.size = CGSizeMake(236/2, 130/2);
    duiView.layer.cornerRadius = 5 ;
    duiView.layer.masksToBounds = YES;
    duiView.layer.borderWidth = 2 ;
    duiView.layer.borderColor =[[UIColor whiteColor] CGColor];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0 , 130/4, duiView.width , 2)];
    line.backgroundColor = [UIColor whiteColor];
    [duiView addSubview:line];
    
    NSString *image = @"首页用狼队底背景" ;
    NSString *duiText = @"狼队";
    NSString *numText = [NSString stringWithFormat:@"%@队" , num] ;
    if ([type isEqualToString:@"2"]) {
        image = @"首页用虎队底背景" ;
        duiText = @"虎队";
    }
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    bg.frame = CGRectMake(0, 0, duiView.width, duiView.height);
    [duiView addSubview:bg];
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:duiText];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((duiView.width - titleSize.width)/2 , 7 , titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:32/2];
    titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    titleLabel.text = duiText;
    [bg addSubview:titleLabel];
    
    CGSize numSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:numText];
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake((duiView.width - numSize.width)/2 , 7 + line.bottom , numSize.width, numSize.height)];
    numLabel.font = [UIFont systemFontOfSize:32/2];
    numLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    numLabel.text = numText;
    [bg addSubview:numLabel];

    
    return duiView;
}


+ (UIView *)getDetailView :(NSString *) type andWithNum :(NSString *) num andWithClubName :(NSString *) clubName andWithPoint : (CGPoint) point {
    
    UIView *duiView = [[UIView alloc] init];
    duiView.origin = point ;
    duiView.size = CGSizeMake(230/2, 88/2);
    duiView.layer.cornerRadius = 5 ;
    duiView.layer.masksToBounds = YES;
    duiView.layer.borderWidth = 2 ;
    duiView.layer.borderColor =[[UIColor whiteColor] CGColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0 , 23 , duiView.width , 2)];
    line.backgroundColor = [UIColor whiteColor];
    [duiView addSubview:line];
    
    NSString *image = @"分数页面狼队用-上" ;
    NSString *duiText = clubName;
    NSString *numText = num ;
    if ([type isEqualToString:@"2"]) {
        image = @"分数页面虎队用-上" ;
    }
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    bg.frame = CGRectMake(0, 0, duiView.width, 23);
    [duiView addSubview:bg];
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:14 andContent:duiText];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((duiView.width - titleSize.width)/2 , 3 , titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    titleLabel.text = duiText;
    [bg addSubview:titleLabel];
    
    CGSize numSize = [NSString getStringContentSizeWithFontSize:13 andContent:numText];
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake((duiView.width - numSize.width)/2 , 1 + line.bottom , numSize.width, numSize.height)];
    numLabel.font = [UIFont systemFontOfSize:13];
    numLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    numLabel.text = numText;
    [bg addSubview:numLabel];
    
    
    return duiView;

}

-(UIView *)getHeSuiCell :(NSString *) fromSai andToSai :(NSString *)toSai andWithResult :(NSString *)result andWithSaiVo :(SaiChengVo *)vo andWithUser :(UserDataVo *) uvo {
    UIView *duiView = [[UIView alloc] init];
    duiView.frame = CGRectMake(0, 0, kScreen_Width, 45);
    duiView.backgroundColor = [UIColor whiteColor];
    
    CGSize VSSize = [NSString getStringContentSizeWithFontSize:15 andContent:result];
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake((duiView.width - VSSize.width)/2 , (45 - VSSize.height)/2  , VSSize.width, VSSize.height)];
    numLabel.font = [UIFont systemFontOfSize:15];
    numLabel.textColor = [UIColor colorWithHexString:@"242424"];
    numLabel.text = result;
    [duiView addSubview:numLabel];
    
    
    CGSize FromSize = [NSString getStringContentSizeWithFontSize:15 andContent:fromSai];
    UILabel *FromLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 , (45 - FromSize.height)/2 , FromSize.width, FromSize.height)];
    FromLabel.font = [UIFont systemFontOfSize:15];
    FromLabel.textColor = [UIColor colorWithHexString:@"242424"];
    FromLabel.text = fromSai;
    [duiView addSubview:FromLabel];

    CGSize ToSize = [NSString getStringContentSizeWithFontSize:15 andContent:toSai];
    UILabel *TOLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width - ToSize.width - 20 , (45 - ToSize.height)/2 , ToSize.width, ToSize.height)];
    TOLabel.font = [UIFont systemFontOfSize:15];
    TOLabel.textColor = [UIColor colorWithHexString:@"242424"];
    TOLabel.text = toSai;
    [duiView addSubview:TOLabel];

    
    if ([uvo.club isEqualToString:vo.homeclub]
        || [uvo.club isEqualToString:vo.visitingclub]
        ) {
        UIView *shu = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 3, 44)];
        shu.backgroundColor = [UIColor colorWithHexString:@"5b73d3"] ;
        duiView.backgroundColor = [UIColor colorWithHexString:@"eef0fb"];
        [duiView addSubview:shu];

        if([vo.camp isEqualToString:@"1"]){
            shu.backgroundColor = [UIColor colorWithHexString:@"e03358"] ;
            duiView.backgroundColor = [UIColor colorWithHexString:@"f9e8eb"];
        }
    }
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45 - 0.5 , kScreen_Width, .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
    [duiView addSubview:line];
    
    return duiView ;
}



@end
