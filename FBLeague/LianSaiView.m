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
    NSString *colorname = @"000000" ;
    
    if ([type isEqualToString:@"33"]) {
        colorname = @"f8845c" ;
    }else if([type isEqualToString:@"22"]){
        colorname = @"5b73d4" ;
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 96/2)];
    lineView.backgroundColor = [UIColor colorWithHexString:colorname] ;
    [self addSubview:lineView];
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:11 andContent:content];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width - 12 - titleSize.width ,12, titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:11];
    titleLabel.textColor = [UIColor colorWithHexString:@"ffffff"];
    titleLabel.text = content;
    [self addSubview:titleLabel];
    
    return lineView ;
}

@end
