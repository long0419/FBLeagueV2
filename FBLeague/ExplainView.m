//
//  ExplainView.m
//  kinvest
//
//  Created by long-laptop on 16/4/14.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "ExplainView.h"

@implementation ExplainView

-(UIView *) showTipByText : (NSString *) txt andWithRect : (CGRect) rect {
    
    UIView *tip = [[UIView alloc] initWithFrame:rect];
    
    UIImageView *dot = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dot"]];
    dot.backgroundColor = [UIColor clearColor];
    dot.frame = CGRectMake(18, (tip.height - 6)/2, 6, 6) ;
    [tip addSubview:dot];
    
    CGSize textNameSize = [NSString getStringContentSizeWithFontSize:12 andContent:txt] ;
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(dot.right + 6 , (tip.height - textNameSize.height)/2, textNameSize.width, textNameSize.height)] ;
    name.text = txt ;
    name.font = [UIFont systemFontOfSize:12] ;
    name.textColor = [UIColor colorWithHexString:@"9c9c9c"] ;
    [tip addSubview:name];
    
    return tip ;
}

-(void) setTipShowPhoto :(NSString *) name withSize :(CGSize) size {
    _tipShow = [[UIImageView alloc] init];
    _tipShow.image = [UIImage imageNamed:name];
    _tipShow.size = size ;
}


-(UIView *) uploadPicAndTip : (NSString *)txt andWithRect : (CGRect) rect{
    
    _tip = [[UIView alloc] initWithFrame:rect];
    _tip.backgroundColor = [UIColor whiteColor] ;

    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width , .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [_tip addSubview:line];
    
    CGSize textNameSize = [NSString getStringContentSizeWithFontSize:12 andContent:txt] ;
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(18 , (_tip.height - textNameSize.height)/2, textNameSize.width, textNameSize.height)] ;
    name.text = txt ;
    name.font = [UIFont systemFontOfSize:12] ;
    name.textColor = [UIColor colorWithHexString:@"9c9c9c"] ;
    name.userInteractionEnabled=YES;
    name.tag = 31 ;
    [_tip addSubview:name];
    
    _tipShow.origin = CGPointMake(kScreen_Width - 36, (_tip.height - 17)/2) ;
    _tipShow.backgroundColor = [UIColor clearColor];
    _tipShow.tag = 41 ;
    [_tip addSubview:_tipShow];

    
    return _tip ;
}

-(void) setTipBackGroundColor : (UIColor *) color {
    _tip.backgroundColor = color ;
}

+(UIView *)titleView :(NSString *)title {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 33)];
    titleView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:13 andContent:title] ;
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(12 , (33 - titleSize.height)/2, titleSize.width, titleSize.height)] ;
    name.text = title ;
    name.font = [UIFont systemFontOfSize:13] ;
    name.textColor = [UIColor colorWithHexString:@"999999"] ;
    [titleView addSubview:name];
    
    return titleView ;
    
}

+ (UIView *)textView :(NSString *)firstName {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 108/2)] ;
    view.backgroundColor = [UIColor whiteColor];
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:firstName] ;
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(12 , (108/2 - titleSize.height)/2, titleSize.width, titleSize.height)] ;
    name.text = firstName ;
    name.font = [UIFont systemFontOfSize:32/2] ;
    name.textColor = [UIColor colorWithHexString:@"333333"] ;
    [view addSubview:name];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(12, view.bottom, kScreen_Width - 24 , .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [view addSubview:line];
    
    return view ;
}

+(UIView *) goToView : (NSString *) title {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 108/2)] ;
    view.backgroundColor = [UIColor whiteColor];
    view.tag = 11 ;
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:title] ;
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(12 , (108/2 - titleSize.height)/2, titleSize.width, titleSize.height)] ;
    name.text = title ;
    name.font = [UIFont systemFontOfSize:32/2] ;
    name.textColor = [UIColor colorWithHexString:@"333333"] ;
    [view addSubview:name];
    
    UIImageView *extend = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"extend"]];
    extend.size = CGSizeMake(15/2, 14) ;
    extend.origin = CGPointMake(kScreen_Width - 18 , (view.height - 14)/2 );
    [view addSubview:extend];
    
    return view ;
    
}

+(UIView *) metricDetail : (NSString *) title
              andWithNum :(CGFloat) num
              andWithColor : (NSString *) color
              andRight : (BOOL) isright{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:10 andContent:title] ;
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20 , 0 , titleSize.width, titleSize.height)] ;
    name.text = title ;
    name.font = [UIFont systemFontOfSize:10] ;
    name.textColor = [UIColor colorWithHexString:@"818a91"] ;
    [view addSubview:name];
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(20, name.bottom + 5 , SYRealValue(296)/2 , 5)];
    bg.backgroundColor = [UIColor colorWithHexString:@"f2f0f0"];
    [view addSubview:bg];
    
    if(num <= 60){
        color = @"8bc34a" ;
    }else if (num < 80 && num >60){
        color = @"22b66e" ;
    }else{
        color = @"f44336" ;
    }
    
    
    UIView *forebg = [[UIView alloc] initWithFrame:CGRectMake(20, name.bottom + 5 , num , 5)];
    forebg.backgroundColor = [UIColor colorWithHexString:color];
    [view addSubview:forebg];
    
    [[bg layer]setCornerRadius:2.5];
    [[forebg layer]setCornerRadius:2.5];
    
    CGSize numSize = [NSString getStringContentSizeWithFontSize:10 andContent:[NSString removeFloatAllZero: [NSString  stringWithFormat:@"%f" , num]]] ;
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(bg.right - numSize.width , 0 , numSize.width, numSize.height)] ;
    numLabel.text = [NSString removeFloatAllZero: [NSString  stringWithFormat:@"%f" , num]];
    numLabel.font = [UIFont systemFontOfSize:10] ;
    numLabel.textColor = [UIColor colorWithHexString:@"818a91"] ;
    [view addSubview:numLabel];


    view.size = CGSizeMake(kScreen_Width/2 , titleSize.height + 5 + 5) ;
    if (isright) {
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shuxianliebiao"]];
        line.frame = CGRectMake(view.right - .5 , 0, .5, view.height + 15) ;
        [view addSubview:line];
    }
    
    return view ;
}

@end
