//
//  PicButton.m
//  kinvest
//
//  Created by long-laptop on 16/4/12.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "PicButton.h"
#import "UIView+Addition.h"

@implementation PicButton

-(void) getPicButtonWithText : (NSString *) imageName andWithTint : (NSString *) text andWithTintColor : (NSString *) tintColor andCGRectImage : (CGRect) imageRect andWithTintSpace : (CGFloat) space{
    
    //创建button
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect];
    [imageView setImage:image];
    
    // 创建label
    CGSize textSize = [NSString getStringContentSizeWithFontSize:14 andContent:text];
    UILabel *label = [[UILabel alloc] init];
    label.size = textSize ;
    label.origin = CGPointMake(imageView.right + space , imageView.top + 3) ;
    [label setText:text];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithHexString:tintColor];
    // 添加到button中
    [self addSubview:label];
    [self addSubview:imageView];
}

-(void) getPicButtonWithText2 : (NSString *) imageName andWithTint : (NSString *) text andWithTintColor : (NSString *) tintColor andCGRectImage : (CGRect) imageRect andWithTintSpace : (CGFloat) space{
    
    //创建button
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect];
    imageView.tag = 1 ;
    imageView.accessibilityHint = imageName ;
    [imageView setImage:image];
    
    // 创建label
    CGSize textSize = [NSString getStringContentSizeWithFontSize:14 andContent:text];
    UILabel *label = [[UILabel alloc] init];
    label.size = textSize ;
    label.origin = CGPointMake(imageView.right + space , imageView.top - 2) ;
    [label setText:text];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithHexString:tintColor];
    // 添加到button中
    [self addSubview:label];
    [self addSubview:imageView];
}

-(void) btnWithTopPic :(NSString *) imageName andWithText :(NSString *) text andWithTextSize :(CGFloat) size andWithImageViewFrame :(CGRect) frame1  andSpaceWithTwo :(CGFloat) space andWithTintColor :(NSString *) tintColor{
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame1];
    imageView.tag = 1 ;
    imageView.accessibilityHint = imageName ;
    [imageView setImage:image];
    
    // 创建label
    CGSize textSize = [NSString getStringContentSizeWithFontSize: size andContent:text];
    UILabel *label = [[UILabel alloc] init];
    label.size = textSize ;
    label.origin = CGPointMake(imageView.left + 10 , imageView.bottom + space) ;
    [label setText:text];
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = [UIColor colorWithHexString:tintColor];
    // 添加到button中
    [self addSubview:label];
    [self addSubview:imageView];
    
}

@end
