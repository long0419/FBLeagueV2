
//
//  MeView.m
//  FBLeague
//
//  Created by long-laptop on 2017/1/2.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "MeView.h"

@implementation MeView


-(UIView *) getMePic :(NSString *)title andWithTintPic : (NSString *)tintPic andWithEndImage :(NSString *)imageName andWithImageSize :(CGSize) size andPoint :(CGPoint) point andIsline :(BOOL) isline{
    
    self.backgroundColor = [UIColor whiteColor];
    self.origin = point;
    self.size = CGSizeMake(kScreen_Width, 110/2) ;
    
    UIImageView *tiPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tintPic]];
    tiPic.frame = CGRectMake(12, (110/2 - 21)/2, 21, 21);
    [self addSubview:tiPic];
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:title];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(tiPic.right + 12 , (110/2   - titleSize.height)/2, titleSize.width, titleSize.height)];
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
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 110/2 - .5 , kScreen_Width, .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    if (isline) {
        [self addSubview:line];
    }
    
    return self ;
}

-(UIView *) getImportData :(NSString *)title
          andWithRatioNum :(NSString *) rawnum
          andWithMax :(NSString *)total {
    self.backgroundColor = [UIColor whiteColor];
    self.size = CGSizeMake(kScreen_Width, 98/2);
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:title];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 , (110/2   - titleSize.height)/2, titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:32/2];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.text = title;
    [self addSubview:titleLabel];

    PPNumberButton *numberButton =
            [PPNumberButton numberButtonWithFrame:
            CGRectMake(kScreen_Width - 20 - 100 ,
            (self.height - 30)/2, 100, 30)];
    numberButton.shakeAnimation = NO;
    numberButton.increaseImage = [UIImage imageNamed:@"increase_taobao"];
    numberButton.decreaseImage = [UIImage imageNamed:@"decrease_taobao"];
    numberButton.maxValue = [total integerValue] ;
    numberButton.minValue = 1 ;
    numberButton.rawValue = [rawnum integerValue] ;
    numberButton.resultBlock = ^(NSString *num){
        [self.delegate meData : title andWithValue : num  andWithRawValue : rawnum];
    };
    numberButton.tag = 11 ;
    [self addSubview:numberButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(12, self.bottom - .5 , kScreen_Width - 24 , .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [self addSubview:line];
    return self ;
}


-(UIView *) getKeShi : (NSString *)title andWithContent :(NSString *)content
          andWithType:(NSString *) type ;
{
    self.backgroundColor = [UIColor whiteColor];
    self.size = CGSizeMake(kScreen_Width, 98/2);
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:title];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 , (110/2   - titleSize.height)/2, titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:32/2];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.text = title;
    [self addSubview:titleLabel];
    
    CGFloat x = titleLabel.right + 110/2 ;
    if ([title isEqualToString:@"训练地点"]) {
        x = titleLabel.right + 50/2 ;
    }else if([title isEqualToString:@"赞助商名称"]){
        x = titleLabel.right + 36/2 ;
    }
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(x ,  (110/2   - titleSize.height)/2,  kScreen_Width - titleLabel.right -80  , titleSize.height)];
    textField.placeholder = content ; //默认显示的字
    textField.tag = 11 ;
    textField.delegate = self ;
    textField.textColor = [UIColor colorWithHexString:@"333333"];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.returnKeyType = UIReturnKeyDone;
    [self addSubview:textField];
    
    if ([type isEqualToString:@"1"]) {
        CGSize moneySize = [NSString getStringContentSizeWithFontSize:32/2 andContent:@"¥"];
        UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right + 110/2 , (110/2 - moneySize.height)/2, moneySize.width, moneySize.height)];
        titleLabel2.font = [UIFont systemFontOfSize:32/2];
        titleLabel2.textColor = [UIColor colorWithHexString:@"333333"];
        titleLabel2.text = @"¥";
        [self addSubview:titleLabel2];
        
        textField.keyboardType = UIKeyboardTypePhonePad ;
        textField.origin = CGPointMake(titleLabel2.right + 8 ,  (110/2   - titleSize.height)/2) ;
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(12, self.bottom - .5 , kScreen_Width - 24 , .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [self addSubview:line];
    return self ;

}

-(UIView *) getzhan :(NSString *)title andWithContentTextField :(NSString *)content {
    self.backgroundColor = [UIColor whiteColor];
    self.size = CGSizeMake(kScreen_Width, 182/2);
    
    CGSize titleSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:title];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 , 20 , titleSize.width, titleSize.height)];
    titleLabel.font = [UIFont systemFontOfSize:32/2];
    titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    titleLabel.text = title;
    [self addSubview:titleLabel];
    
    UITextView *textField = [[UITextView alloc] initWithFrame:CGRectMake(titleLabel.right + 68/2 ,  10 ,  kScreen_Width - titleLabel.right - 68/2 - 12  , 182/2 - 40)];
//    textField.placeholder = content ;
    textField.tag = 11 ;
    textField.delegate = self ;
//    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop ;
//    textField.backgroundColor = [UIColor blueColor];
    [textField setTintColor:[UIColor colorWithHexString:@"4cc07f"]];
    textField.textColor = [UIColor colorWithHexString:@"333333"];
    textField.font = [UIFont systemFontOfSize:32/2];
    textField.contentInset = UIEdgeInsetsMake(0, 0, 10.0f, 10.0f);
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.returnKeyType = UIReturnKeyDone;
    [self addSubview:textField];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(12, self.bottom - .5 , kScreen_Width - 24 , .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [self addSubview:line];

    
    return self ;
}

- (void) textViewDidBeginEditing:(UITextView *)textView {
    // Example: to select the second and third characters when editing starts...
    NSRange insertionPoint = NSMakeRange(1, 2);
    textView.selectedRange = insertionPoint;
}


//- (void)textViewDidChangeSelection:(UITextView *)textView
//
//{
//    
//    NSRange range;
//    
//    range.location = 0;
//    
//    range.length = 0;
//    
//    textView.selectedRange = range;
//    
//}
@end
