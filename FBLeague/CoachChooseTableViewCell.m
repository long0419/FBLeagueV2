//
//  CoachChooseTableViewCell.m
//  FBLeague
//
//  Created by long-laptop on 2016/12/5.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "CoachChooseTableViewCell.h"

@implementation CoachChooseTableViewCell

-(void) setPhoneApplyCellByImageName :(NSString *) imageName andWithName :(NSString *) name andWithPhoneNum : (NSString *) num  andWithindex :(NSInteger) indexPath andWithRole :(NSString *)role andPosition : (NSString *) position {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 70 + 20)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bg];
    
    //返回结果中的status:["1"表示申请状态,"2"表示通过状态]
    NSString *type = @"申请列表" ;
    if (![position isEqualToString:@"1"]) {
        type = @"已通过" ;
    }else{
        UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(apply:)];
        UIView *focus = [[UIView alloc] initWithFrame:CGRectMake(kScreen_Width - 20 - 134/2, 20 + (70 - 58/2)/2, 134/2, 58/2)] ;
        [[focus layer]setCornerRadius:5];
        focus.tag = indexPath ;
        focus.accessibilityHint = [NSString stringWithFormat:@"%ld" , (long)indexPath] ;
        focus.accessibilityHint = role ;
        UILabel *focusLabel = nil ;
        focus.backgroundColor = [UIColor whiteColor];
        focus.layer.borderWidth = 1;
        focus.layer.borderColor = [UIColor colorWithHexString:@"2eb66a"].CGColor ;
            
        CGSize focusSize = [NSString getStringContentSizeWithFontSize:14 andContent:@"审核通过"];
        focusLabel = [[UILabel alloc] initWithFrame:CGRectMake((focus.width - focusSize.width)/2 , (focus.height - focusSize.height)/2, focusSize.width, focusSize.height)];
        focusLabel.font = [UIFont systemFontOfSize:14];
        focusLabel.textColor = [UIColor colorWithHexString:@"2eb66a"];
        focusLabel.text = @"审核通过" ;
        focusLabel.tag = 12 ;
        focusLabel.accessibilityHint = num ;
        focus.userInteractionEnabled = YES;
        [focus addGestureRecognizer:singleTap4];
        [focus addSubview:focusLabel];
        [self.contentView addSubview:focus];
    }
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width , 20)];
    header.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [bg addSubview:header];
    
    CGSize typeSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:[NSString stringWithFormat:@"%@" , type]];
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 , (20 - typeSize.height)/2 , typeSize.width, typeSize.height)];
    typeLabel.font = [UIFont systemFontOfSize:12];
    typeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    typeLabel.text = [NSString stringWithFormat:@"%@" , type] ;
    [header addSubview:typeLabel];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.size = CGSizeMake(72/2, 72/2) ;
    imageView.origin = CGPointMake(12 , (bg.height - 72/2)/2);
    imageView.layer.cornerRadius = 72 / 4 ;
    imageView.layer.masksToBounds = YES;
    UIImage *image = nil ;
    if ([imageName isEqual:[NSNull null]] || [imageName isEqualToString:@""]) {
        imageName = @"defaulthead" ;
        image = [UIImage imageNamed:imageName];
        [imageView setImage:image];
    }else{
//        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]];
//        image = [UIImage imageWithData:data];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];

    }
    [bg addSubview:imageView];
    
    CGSize nameSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:[NSString stringWithFormat:@"%@" , name]];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 32/2 , imageView.top , nameSize.width, nameSize.height)];
    nameLabel.font = [UIFont systemFontOfSize:32/2];
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    nameLabel.text = [NSString stringWithFormat:@"%@" , name] ;
    [bg addSubview:nameLabel];
    
    NSString *roleName = @"教练员";
    if(![role isEqualToString:@"1"]){
        roleName = @"队员" ;
    }
    CGSize phoneSize = [NSString getStringContentSizeWithFontSize:11 andContent:roleName];
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 32/2 , nameLabel.bottom + 6, phoneSize.width, phoneSize.height)];
    phoneLabel.font = [UIFont systemFontOfSize:11];
    phoneLabel.textColor = [UIColor colorWithHexString:@"999999"];
    phoneLabel.text = roleName ;
    [bg addSubview:phoneLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake( 32 /2 , bg.bottom , kScreen_Width - 32 , .5)] ;
    line.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [bg addSubview:line];
}

-(void)apply:(UITapGestureRecognizer *)sender{
    sender.self.view.backgroundColor = [UIColor colorWithHexString:@"2eb66a"];
    UILabel *label = [sender.self.view viewWithTag:12];
    label.text = @"同意审核" ;
    label.textColor = [UIColor colorWithHexString:@"ffffff"];

    [self.delegate sendapply:sender.self.view.accessibilityHint andWith:label.accessibilityHint];

}

-(void) setPhoneContactCellByImageName :(NSString *) imageName andWithName :(NSString *) name andWithPhoneNum : (NSString *) num  andWithindex :(NSInteger) indexPath andWithRole :(NSString *)role andPosition : (NSString *) position {

    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 70 + 20)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bg];
    
    if ([position isEqual:[NSNull null]]) {
        position = @"1" ;
    }
    
    NSString *type = @"教练" ;
    if (![role isEqualToString:@"1"]) {
        if ([position isEqualToString:@"1"]) {
            type = @"前锋" ;
        }else if([position isEqualToString:@"2"]){
            type = @"中场";
        }else if([position isEqualToString:@"3"]){
            type = @"后卫" ;
        }else if([position isEqualToString:@"4"]){
            type = @"守门" ;
        }
    }
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width , 20)];
    header.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [bg addSubview:header];
    
    CGSize typeSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:[NSString stringWithFormat:@"%@" , type]];
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 , (20 - typeSize.height)/2 , typeSize.width, typeSize.height)];
    typeLabel.font = [UIFont systemFontOfSize:12];
    typeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    typeLabel.text = [NSString stringWithFormat:@"%@" , type] ;
//    [header addSubview:typeLabel];

    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.size = CGSizeMake(72/2, 72/2) ;
    imageView.origin = CGPointMake(12 , (bg.height - 72/2)/2);
    imageView.layer.cornerRadius = 72 / 4 ;
    imageView.layer.masksToBounds = YES;
    UIImage *image = nil ;
    if ([imageName isEqual:[NSNull null]] || [imageName isEqualToString:@""] || [imageName isEqualToString:@"<null>"]) {
        imageName = @"defaulthead" ;
        image = [UIImage imageNamed:imageName];
        [imageView setImage:image];
    }else{
//        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]];
//        image = [UIImage imageWithData:data];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];
    }
    [bg addSubview:imageView];

    
    CGSize nameSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:[NSString stringWithFormat:@"%@" , name]];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 32/2 , imageView.top , nameSize.width, nameSize.height)];
    nameLabel.font = [UIFont systemFontOfSize:32/2];
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    nameLabel.text = [NSString stringWithFormat:@"%@" , name] ;
    [bg addSubview:nameLabel];
    
    NSString *roleName = @"教练员";
    if(![role isEqualToString:@"1"]){
        roleName = @"队员" ;
    }
    CGSize phoneSize = [NSString getStringContentSizeWithFontSize:11 andContent:roleName];
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 32/2 , nameLabel.bottom + 6, phoneSize.width, phoneSize.height)];
    phoneLabel.font = [UIFont systemFontOfSize:11];
    phoneLabel.textColor = [UIColor colorWithHexString:@"999999"];
    phoneLabel.text = roleName ;
    [bg addSubview:phoneLabel];
        
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake( 32 /2 , bg.bottom , kScreen_Width - 32 , .5)] ;
    line.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [bg addSubview:line];
}

-(void) setPhoneContactCellByImageName :(NSString *) imageName andWithName :(NSString *) name andWithPhoneNum : (NSString *) num andWithChoose :(NSString *) use andWithindex :(NSInteger) indexPath{
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 70)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bg];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.size = CGSizeMake(72/2, 72/2) ;
    imageView.origin = CGPointMake(12 , (bg.height - 72/2)/2);
    imageView.layer.cornerRadius = 72 / 4 ;
    imageView.layer.masksToBounds = YES;
    UIImage *image = nil ;
    if ([imageName isEqual:[NSNull null]] || [imageName isEqualToString:@""]
        || [imageName isEqualToString:@"<null>"]) {
        imageName = @"defaulthead" ;
        image = [UIImage imageNamed:imageName];
        [imageView setImage:image];

    }else{
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];
    }
    [bg addSubview:imageView];
    
    CGSize nameSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:name];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 32/2 , imageView.top , nameSize.width, nameSize.height)];
    nameLabel.font = [UIFont systemFontOfSize:32/2];
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    nameLabel.text = name;
    [bg addSubview:nameLabel];
    
    
    CGSize phoneSize = [NSString getStringContentSizeWithFontSize:11 andContent:num];
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 32/2 , nameLabel.bottom + 6, phoneSize.width, phoneSize.height)];
    phoneLabel.font = [UIFont systemFontOfSize:11];
    phoneLabel.textColor = [UIColor colorWithHexString:@"999999"];
    phoneLabel.text = num ;
    [bg addSubview:phoneLabel];
    
    UITapGestureRecognizer *singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focus:)];
    UIView *focus = [[UIView alloc] initWithFrame:CGRectMake(bg.right - 20 - 134/2, (bg.height - 58/2)/2, 134/2, 58/2)] ;
    [[focus layer]setCornerRadius:58/4];
    focus.tag = indexPath ;
    focus.accessibilityHint = [NSString stringWithFormat:@"%ld" , (long)indexPath] ;
    UILabel *focusLabel = nil ;
    if ([use isEqualToString:@"no"]) {
        focus.backgroundColor = [UIColor whiteColor];
        focus.layer.borderWidth = 1;
        focus.layer.borderColor = [UIColor colorWithHexString:@"000000"].CGColor ;
        
        CGSize focusSize = [NSString getStringContentSizeWithFontSize:14 andContent:@"未关注"];
        focusLabel = [[UILabel alloc] initWithFrame:CGRectMake((focus.width - focusSize.width)/2 , (focus.height - focusSize.height)/2, focusSize.width, focusSize.height)];
        focusLabel.font = [UIFont systemFontOfSize:14];
        focusLabel.textColor = [UIColor colorWithHexString:@"000"];
        focusLabel.text = @"未关注" ;
        focusLabel.tag = 12 ;
        focus.userInteractionEnabled = YES;
        [focus addGestureRecognizer:singleTap4];
    }else{
        focus.backgroundColor = [UIColor colorWithHexString:@"000"];
        
        CGSize focusSize = [NSString getStringContentSizeWithFontSize:14 andContent:@"已关注"];
        focusLabel = [[UILabel alloc] initWithFrame:CGRectMake((focus.width - focusSize.width)/2 , (focus.height - focusSize.height)/2, focusSize.width, focusSize.height)];
        focusLabel.font = [UIFont systemFontOfSize:14];
        focusLabel.textColor = [UIColor whiteColor];
        focusLabel.text = @"已关注" ;
        focusLabel.tag = 12 ;

        focus.userInteractionEnabled = NO ;

    }
    [focus addSubview:focusLabel];
    [bg addSubview:focus];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake( 32 /2 , bg.bottom , kScreen_Width - 32 , .5)] ;
    line.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [bg addSubview:line];

}

-(void) setPhoneContactCellByImageName2 :(NSString *) imageName andWithName :(NSString *) name andWithPhoneNum : (NSString *) num andWithChoose :(NSString *) use andWithindex :(NSInteger) indexPath {
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 70)];
    bg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bg];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.size = CGSizeMake(72/2, 72/2) ;
    imageView.origin = CGPointMake(12 , (bg.height - 72/2)/2);
    imageView.layer.cornerRadius = 72 / 4 ;
    imageView.layer.masksToBounds = YES;
    UIImage *image = nil ;
    if ([imageName isEqual:[NSNull null]] || [imageName isEqualToString:@""]
        || [imageName isEqualToString:@"<null>"]) {
        imageName = @"defaulthead" ;
        image = [UIImage imageNamed:imageName];
        [imageView setImage:image];
        
    }else{
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];
    }
    [bg addSubview:imageView];
    
    CGSize nameSize = [NSString getStringContentSizeWithFontSize:32/2 andContent:name];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 32/2 , imageView.top , nameSize.width, nameSize.height)];
    nameLabel.font = [UIFont systemFontOfSize:32/2];
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    nameLabel.text = name;
    [bg addSubview:nameLabel];
    
    
    CGSize phoneSize = [NSString getStringContentSizeWithFontSize:11 andContent:num];
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 32/2 , nameLabel.bottom + 6, phoneSize.width, phoneSize.height)];
    phoneLabel.font = [UIFont systemFontOfSize:11];
    phoneLabel.textColor = [UIColor colorWithHexString:@"999999"];
    phoneLabel.text = num ;
    [bg addSubview:phoneLabel];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake( 32 /2 , bg.bottom , kScreen_Width - 32 , .5)] ;
    line.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [bg addSubview:line];
    
}



-(NSUInteger) unicodeLengthOfString: (NSString *) text {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength / 2;
    if(asciiLength % 2) {
        unicodeLength++;
    }
    return unicodeLength;
}

-(void)labelTap:(UITapGestureRecognizer *)recognizer{
    [self.delegate gofanlist : recognizer.view.accessibilityHint];
}

-(void)focus :(UITapGestureRecognizer *)recognizer {
    [self.delegate focusContact:recognizer.view];
}

 
@end
