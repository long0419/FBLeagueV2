//
//  BeginTouView.m
//  kinvest
//
//  Created by long-laptop on 16/4/18.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "BeginTouView.h"

@implementation BeginTouView

-(UIView *) getBeginTouView : (NSString *) title  andWithTintTitle :(NSString *)tintStr andWithEndTint :(NSString *)endTint andPoint : (CGPoint) point{
    self.backgroundColor = [UIColor whiteColor];
    self.origin = point;
    self.size = CGSizeMake(kScreen_Width, 45) ;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self addSubview:line];
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:15 andContent:title];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18 , (45 - titleSize.height)/2, titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f"];
    titleLabel.text = title;
    [self addSubview:titleLabel];
    
    
    CGSize endSize = [NSString getStringContentSizeWithFontSize:14 andContent:endTint];
    UILabel *endLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreen_Width - endSize.width - 18 , (45-endSize.height)/2, endSize.width, endSize.height)];
    endLabel.font = [UIFont systemFontOfSize:14];
    endLabel.textColor = [UIColor colorWithHexString:@"0ec481"];
    endLabel.text = endTint ;
    endLabel.tag = 11 ;
    [self addSubview:endLabel];
    
    UITextField *txtField = [[UITextField alloc] initWithFrame:CGRectMake(titleLabel.right + 5  , (45 - 40)/2+1, kScreen_Width - (titleLabel.right + 8) - (kScreen_Width  - endLabel.left) , 40)];
    txtField.placeholder = tintStr ;
    txtField.tintColor = [UIColor colorWithHexString:@"cccccc"];
    txtField.userInteractionEnabled = YES ;
    txtField.font = SystemFontOfSize(14);
    txtField.tag = 31 ;
    txtField.tintColor = [UIColor colorWithHexString:@"0ec481"];

    txtField.textColor = [UIColor colorWithHexString:@"0ec481"];
    txtField.textAlignment = NSTextAlignmentRight ;
    [self addSubview: txtField];
    
    return self ;
}


-(UIView *) getBeginTouPic :(NSString *)title andWithPic :(NSString *) pic andWithEndImage :(NSString *)imageName andWithImageSize :(CGSize) size andPoint :(CGPoint) point{
    self.backgroundColor = [UIColor whiteColor];
    self.origin = point;
    self.size = CGSizeMake(kScreen_Width, 144/2) ;
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:title];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 , (144/2 - titleSize.height)/2, titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:32/2];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.text = title;
    [self addSubview:titleLabel];
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.size = size ;
    imageView.origin = CGPointMake(kScreen_Width - 12 - size.width, (self.height - size.height)/2 );
    imageView.tag = 11 ;
    [imageView setImage:image];
    [self addSubview:imageView];
    
    UIImageView *header = [[UIImageView alloc] init];
    header.image = [UIImage imageNamed:@"defaulthead"];
    header.frame = CGRectMake(kScreen_Width - 12 - size.width - 11 - 94/2 , (self.height - 94/2)/2, 94/2, 94/2);
    header.layer.masksToBounds = YES; //没这句话它圆不起来
    header.layer.cornerRadius = 94/4; //设置图片圆角的尺度
    header.tag = 12 ;
    [self addSubview:header];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction:)];
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:singleTap];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(12 , 144/2 - .5 , kScreen_Width - 24, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    
    return self ;
}

-(UIView *) getBeginTouPic :(NSString *)title andWithContent: (NSString *)content andWithEndImage :(NSString *)imageName andWithImageSize :(CGSize) size andPoint :(CGPoint) point{
    self.backgroundColor = [UIColor whiteColor];
    self.origin = point;
    self.size = CGSizeMake(kScreen_Width, 160/2) ;
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:title];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 , (160/2 - titleSize.height)/2, titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:32/2];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.text = title;
    [self addSubview:titleLabel];
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.size = size ;
    imageView.origin = CGPointMake(kScreen_Width - 12 - size.width, (self.height - size.height)/2 );
    imageView.tag = 11 ;
    [imageView setImage:image];
    [self addSubview:imageView];
    
    UITextView *oneTextView = [[UITextView alloc] init];
    oneTextView.frame = CGRectMake(titleLabel.right + 102/2 ,
                                   34/2 ,
                                   kScreen_Width - 120  ,
                                   self.height - 34);
    oneTextView.backgroundColor = [UIColor whiteColor]; // 设置背景色
    oneTextView.text = content; // 设置文字
    oneTextView.textAlignment = NSTextAlignmentLeft; // 设置字体对其方式
    oneTextView.font = [UIFont systemFontOfSize:15]; // 设置字体大小
    oneTextView.tag = 12 ;
    oneTextView.textColor = [UIColor colorWithHexString:@"888888"]; // 设置文字颜色
    [oneTextView setEditable:NO]; // 设置时候可以编辑
    oneTextView.scrollEnabled = YES; // 当文字宽度超过UITextView的宽度时，是否允许滑动
    [self addSubview:oneTextView]; // 添加到View上
    
//    UILabel *cotentLabel = [UILabel new];
//    cotentLabel.font = [UIFont systemFontOfSize:15];
//    cotentLabel.text = content ;
//    cotentLabel.tag = 12 ;
//    cotentLabel.numberOfLines = 0;//多行显示，计算高度
//    cotentLabel.textColor = [UIColor colorWithHexString:@"888888"];
//    CGSize contentSize = [NSString getMultiStringContentSizeWithFontSize:30/2 andContent:content];
//    cotentLabel.size = contentSize;
//    cotentLabel.x = 12 ;
//    cotentLabel.y = 34/2 ;
////    cotentLabel.width = kScreen_Width - imageView.right - 11 ;
//    [self addSubview:cotentLabel];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction:)];
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:singleTap];
     
    return self ;

}


-(UIView *) getBeginTouView : (NSString *) title  andWithTintTitle :(NSString *)tintStr andWithEndImage :(NSString *)imageName andWithImageSize :(CGSize) size  andPoint :(CGPoint) point  andWithTag :(NSInteger) tag{
    self.backgroundColor = [UIColor whiteColor];
    self.origin = point;
    self.size = CGSizeMake(kScreen_Width, 45) ;
    
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:15 andContent:title];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 , (45 - titleSize.height)/2, titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f"];
    titleLabel.text = title;
    [self addSubview:titleLabel];
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.size = size ;
    imageView.origin = CGPointMake(kScreen_Width - 12 - size.width, (self.height - size.height)/2 );
    imageView.tag = 11 ;
    [imageView setImage:image];
    [self addSubview:imageView];

    
    CGSize tintSize = [NSString getStringContentSizeWithFontSize:14 andContent:tintStr];
    UILabel *tintLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left - 6 - tintSize.width , (45 - titleSize.height)/2, tintSize.width, tintSize.height)];
    tintLabel.font = [UIFont systemFontOfSize:14];
    tintLabel.textColor = [UIColor colorWithHexString:@"888888"];
    tintLabel.text = tintStr;
    tintLabel.tag = 12 ;
    [self addSubview:tintLabel];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction:)];
    [self setUserInteractionEnabled:YES];
    self.tag = tag ;
    self.accessibilityHint = [NSString stringWithFormat:@"%ld" , (long)tag] ;
    [self addGestureRecognizer:singleTap];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(12 , 44.5, kScreen_Width - 24, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self addSubview:line];

    return self ;

}


-(UIView *) getBeginTouViewBg :(CGRect) frame {
    UIView *bg = [[UIView alloc] initWithFrame:frame];
    bg.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [bg addSubview:line];
    
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height , kScreen_Width , .5)];
    line2.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [bg addSubview:line2];

    
    return bg ;
}

-(void)singleTapAction : (UITapGestureRecognizer *) sender{
    NSString *tint = sender.view.accessibilityHint ;

    [self.delegate tapAction : sender andWithTag:tint];
}

@end
