//
//  UILabel+Common.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-8.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "UILabel+Common.h"

@implementation UILabel (Common)
- (void)setLongString:(NSString *)str withFitWidth:(CGFloat)width{
    [self setLongString:str withFitWidth:width maxHeight:CGFLOAT_MAX];
}

- (void) setLongString:(NSString *)str withFitWidth:(CGFloat)width maxHeight:(CGFloat)maxHeight{
    self.numberOfLines = 0;
    CGSize resultSize = [str getSizeWithFont:self.font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX)];
    CGFloat resultHeight = resultSize.height;
    if (maxHeight > 0 && resultHeight > maxHeight) {
        resultHeight = maxHeight;
    }
    CGRect frame = self.frame;
    frame.size.height = resultHeight;
    [self setFrame:frame];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.attributedText = attrStr;
}

- (void) setLongString:(NSString *)str withVariableWidth:(CGFloat)maxWidth{
    self.numberOfLines = 0;
    self.text = str;
    CGSize resultSize = [str getSizeWithFont:self.font constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    CGRect frame = self.frame;
    frame.size.height = resultSize.height;
    frame.size.width = resultSize.width;
    [self setFrame:frame];
}

- (void) setLongHtmlString:(NSString *)str withVariableWidth:(CGFloat)maxWidth{
    self.numberOfLines = 0;
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.attributedText = attrStr;
    CGSize resultSize = [self.text getSizeWithFont:self.font constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX)];
    CGRect frame = self.frame;
    int occurance = 0;
    float height=0;
//    occurance=(int)[[str componentsSeparatedByString:@"<p>"] count];
//    if(occurance>1){
//        height =occurance*10;
//    }
    occurance=(int)[[str componentsSeparatedByString:@"</p>"] count];
    if(occurance>1){
        height =occurance*10;
    }
//    occurance = (int)[[str componentsSeparatedByString:@"<br/>"] count];
//    if(occurance>1){
//        height +=occurance*10;
//    }
//    occurance = (int)[[str componentsSeparatedByString:@"<br"] count];
//    if(occurance>1){
//        height +=occurance*10;
//    }
    occurance = (int)[[str componentsSeparatedByString:@"<h2>"] count];
    if(occurance>1){
        height +=occurance*20;
    }
    occurance = (int)[[str componentsSeparatedByString:@"<h3>"] count];
    if(occurance>1){
        height +=occurance*20;
    }
//    occurance = (int)[[str componentsSeparatedByString:@"</span"] count];
//    if(occurance>1){
//        height +=occurance*10;
//    }
    frame.size.height = resultSize.height+height;
    frame.size.width = resultSize.width;
    [self setFrame:frame];
}

@end
