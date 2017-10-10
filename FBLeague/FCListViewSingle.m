//
//  FCListViewSingle.m
//  kinvest
//
//  Created by long-laptop on 16/5/21.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "FCListViewSingle.h"
#import "FCListVo.h"
#import "PicButton.h"
#import "CommonFunc.h"
#import "UserDataVo.h"
#import "MWLocalDataTool.h"
#import "CommentVo.h"

@implementation FCListViewSingle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

-(void)initSubView{
   
}

-(void)setStatus:(FCListVo *) vo andWithRawHeight : (CGFloat) height andWithSection : (NSString *) section andIsMine : (BOOL) ismy{
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, height)];
    bg.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self.contentView addSubview:bg];
    
    _categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, height)] ;
    _categoryView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [bg addSubview : _categoryView];

    //头像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 34/2 , 72/2 , 72/2)];
    if (nil == vo.headpicurl || [@"" isEqualToString:vo.headpicurl]|| [vo.headpicurl isEqualToString:@"<null>"]) {
        [imageView setImage:[UIImage imageNamed:@"defaulthead"]];
    }else{
        [imageView sd_setImageWithURL:[NSURL URLWithString:vo.headpicurl] placeholderImage:nil];
    }
    imageView.layer.cornerRadius= 72/2/2;// 将图层的边框设置为圆角
    imageView.layer.masksToBounds=YES;
    [_categoryView addSubview:imageView];
    
    NSString *name =  [CommonFunc textFromBase64String:vo.name];
    //姓名
    CGSize nameSize = [NSString getStringContentSizeWithFontSize:14 andContent:name];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 12 , 34/2 + (72/2 - nameSize.height)/2 , nameSize.width, nameSize.height)];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor colorWithHexString:@"507daf"];
    nameLabel.text = name ;
    [_categoryView addSubview: nameLabel];
    
    //朋友圈内容
    CGFloat imageY = imageView.bottom + 12 ;
    if (nil != vo.contents && vo.contents.length > 0) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:15];
        
        NSString *titleContent = [CommonFunc textFromBase64String:vo.contents];
        titleLabel.text = [self processText:titleContent  andWith:100];
        titleLabel.numberOfLines = 0;//多行显示，计算高度
        titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        CGSize titleSize = [NSString getMultiStringContentSizeWithFontSize:34/2 andContent:[self processText:titleContent  andWith:100]];
        titleLabel.size = titleSize;
        titleLabel.x = 15 ;
        titleLabel.y = imageView.bottom + 12 ;
        titleLabel.width = kScreen_Width - 24 ;
        [_categoryView addSubview:titleLabel];
        imageY = titleLabel.bottom + 38/2 ;
    }
    
    CGFloat lineY = imageY ;
    if (nil != vo.picurl && ![vo.picurl isEqualToString:@"<null>"]) {
        NSArray *photos = [vo.picurl componentsSeparatedByString:@","];
        NSMutableArray *dataPhotos = [[NSMutableArray alloc] initWithArray:photos];
        //去掉有空的字符串
        for (int i= 0 ; i<dataPhotos.count; i++) {
            NSString *url = [dataPhotos objectAtIndex:i];
            if ([url isEqualToString:@""]) {
                [dataPhotos removeObjectAtIndex:i];
            }
        }
        
        UIImageView *imageView = nil ;
        for (int i= 0 ; i<dataPhotos.count; i++) {
            NSString *url = [dataPhotos objectAtIndex:i];
            if ([url length] > 0) {
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12 + SYRealValue((212/2 + 18/2))*i , imageY , SYRealValue(212/2), SYRealValue(212/2))] ;
                imageView.backgroundColor = [UIColor clearColor];
                imageView.accessibilityHint = [NSString stringWithFormat:@"%d" , i] ;
                imageView.accessibilityIdentifier = section ;
                [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewPic:)];
                [imageView addGestureRecognizer:singleTap];
                UIView *singleTapView = [singleTap view];
                singleTapView.tag = [section integerValue];
                [imageView setUserInteractionEnabled:YES];
                [_categoryView addSubview:imageView];
            }
        }
        
        lineY = imageY + 212/2 + 38/2 ;
    }
    
    CGSize timeSize = [NSString getStringContentSizeWithFontSize:11 andContent:[NSString displayTimeByInterval:vo.pubtime]];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(12 , lineY , timeSize.width, timeSize.height)];
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.textColor = [UIColor colorWithHexString:@"888888"];
    timeLabel.text = [NSString displayTimeByInterval:vo.pubtime] ;
    [_categoryView addSubview: timeLabel];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteAction:)];
    CGSize deleteSize = [NSString getStringContentSizeWithFontSize:11 andContent:[NSString displayTimeByInterval:@"删除"]];
    UILabel *deleteLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeLabel.right + 8 , lineY , deleteSize.width, deleteSize.height)];
    deleteLabel.font = [UIFont systemFontOfSize:11];
    deleteLabel.textColor = [UIColor colorWithHexString:@"507daf"];
    deleteLabel.text = @"删除" ;
    deleteLabel.userInteractionEnabled = YES ;
    deleteLabel.accessibilityHint = vo.fid ;
    [deleteLabel addGestureRecognizer:singleTap];
    if (ismy) {
        [_categoryView addSubview: deleteLabel];
    }
    
    UIImageView *comments = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"评论"]];
    comments.frame = CGRectMake(kScreen_Width - 30 - 32/2 ,  lineY , 32/2, 30/2) ;
    CGSize commentCountSize = [NSString getStringContentSizeWithFontSize:12 andContent:vo.commentscount];
    UILabel *cocount = [[UILabel alloc] initWithFrame:CGRectMake(comments.right + 4 , lineY - 1 , commentCountSize.width, commentCountSize.height)];
    cocount.font = [UIFont systemFontOfSize:12];
    cocount.textColor = [UIColor colorWithHexString:@"888888"];
    cocount.text = vo.commentscount ;
    [_categoryView addSubview:cocount];
    [_categoryView addSubview:comments] ;
    
    UIImageView *praise = nil ;
    if ([vo.likescount intValue] > 0) {
        praise = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"点赞点击"]];
    }else{
        praise = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"点赞小"]];
    }
    praise.frame = CGRectMake(comments.left - 25 - 32/2 ,  lineY , 32/2, 30/2) ;
    CGSize pCountSize = [NSString getStringContentSizeWithFontSize:12 andContent:vo.likescount];
    UILabel *pcount = [[UILabel alloc] initWithFrame:CGRectMake(praise.right + 4 , lineY - 1 , pCountSize.width, pCountSize.height)];
    pcount.font = [UIFont systemFontOfSize:12];
    pcount.textColor = [UIColor colorWithHexString:@"888888"];
    pcount.text = vo.likescount ;
    [_categoryView addSubview:pcount] ;
    [_categoryView addSubview:praise] ;
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(12 , timeLabel.bottom + 32/2, kScreen_Width - 24 , .5)] ;
    line2.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    [_categoryView addSubview:line2];
    
}

-(BOOL)judgePrase :(NSArray *)phones {
    UserDataVo *user = [[MWLocalDataTool shareInstance] readNSUserDefaultsWithKey:@"userData"];
    for (NSString *phone in phones) {
        if ([phone isEqualToString:user.phone]) {
            return YES ;
        }
    }
    return NO ;
}

-(void)setDetailStatus:(FCListVo *) vo andWithRawHeight : (CGFloat) height {
    
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, height+ 3)];
    bg.backgroundColor = [UIColor colorWithHexString:@"f2f7f7"];
    [self.contentView addSubview:bg];
    
    _categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreen_Width, height)] ;
    _categoryView.backgroundColor = [UIColor whiteColor];
    [bg addSubview : _categoryView];
    
    //头像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15 , 72/2 , 72/2)];
    if (nil == vo.headpicurl || [@"" isEqualToString:vo.headpicurl]) {
        [imageView setImage:[UIImage imageNamed:@"defaulthead"]];
    }else{
        [imageView sd_setImageWithURL:[NSURL URLWithString:vo.headpicurl] placeholderImage:nil];
    }
    [_categoryView addSubview:imageView];
    
    //姓名
    CGSize nameSize = [NSString getStringContentSizeWithFontSize:14 andContent:vo.name];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 12 , 15 , nameSize.width, nameSize.height)];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor colorWithHexString:@"5a6d97"];
    nameLabel.text = vo.name ;
    [_categoryView addSubview: nameLabel];
    
    CGSize timeSize = [NSString getStringContentSizeWithFontSize:11 andContent:[NSString displayTimeByInterval:vo.pubtime]];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 12 , nameLabel.bottom + 5 , timeSize.width, timeSize.height)];
    timeLabel.font = [UIFont systemFontOfSize:11];
    timeLabel.textColor = [UIColor colorWithHexString:@"9c9c9c"];
    timeLabel.text = [NSString displayTimeByInterval:vo.pubtime] ;
    [_categoryView addSubview: timeLabel];
    
    //朋友圈内容
    CGFloat imageY = imageView.bottom + 12 ;
    if (nil != vo.contents && vo.contents.length > 0) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:15];
        
        NSString *titleContent = [CommonFunc textFromBase64String:vo.contents];
        titleLabel.text = [self processText:titleContent andWith:100];
        titleLabel.numberOfLines = 0;//多行显示，计算高度
        titleLabel.textColor = [UIColor colorWithHexString:@"3f3f3f"];
        CGSize titleSize = [NSString getMultiStringContentSizeWithFontSize:15 andContent:[self processText:titleContent andWith:100]];
        titleLabel.size = titleSize ;
        titleLabel.x = 15 ;
        titleLabel.y = imageView.bottom + 12 ;
        titleLabel.width = kScreen_Width - 24 ;
        [_categoryView addSubview:titleLabel];
        imageY = titleLabel.bottom + 12 ;
    }
    
    
    if (nil != vo.picurl && ![vo.picurl isEqualToString:@"<null>"]) {
        NSArray *photos = [vo.picurl componentsSeparatedByString:@","];
        UIImageView *imageView = nil ;
        for (int i= 0 ; i<photos.count; i++) {
            NSString *url = [photos objectAtIndex:i];
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15 + (214/2 + 9/2)*i, imageY , 214/2, 214/2)] ;
            imageView.backgroundColor = [UIColor clearColor];
            imageView.accessibilityHint = [NSString stringWithFormat:@"%d" , i] ;
            imageView.accessibilityIdentifier = vo.accessoryInfo ;
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewPic:)];
            [imageView addGestureRecognizer:singleTap];
            [imageView setUserInteractionEnabled:YES];
            [_categoryView addSubview:imageView];
        }
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, imageY + 214/2 + 15, kScreen_Width, .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"ebebeb"] ;
    [_categoryView addSubview:line];
    
}


-(void)setDetailCommentStatus:(CommentVo *) vo andWithRawHeight : (CGFloat) height {
    
    _categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, height)] ;
    _categoryView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self.contentView addSubview : _categoryView];
    
    //头像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 34/2 , 64/2 , 64/2)];
    if (nil == vo.headpicurl || [@"" isEqualToString:vo.headpicurl]) {
        [imageView setImage:[UIImage imageNamed:@"defaulthead"]];
    }else{
        [imageView sd_setImageWithURL:[NSURL URLWithString:vo.headpicurl] placeholderImage:nil];
    }
    imageView.layer.cornerRadius= 72/2/2;// 将图层的边框设置为圆角
    imageView.layer.masksToBounds=YES;
    [_categoryView addSubview:imageView];
    
    //姓名
    NSString *nameContent = [CommonFunc textFromBase64String:vo.name];
    CGSize nameSize = [NSString getStringContentSizeWithFontSize:13 andContent:nameContent];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 12 , 13 , nameSize.width, nameSize.height)];
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    nameLabel.text = nameContent ;
    [_categoryView addSubview: nameLabel];
    
    CGSize timeSize = [NSString getStringContentSizeWithFontSize:11 andContent:[NSString displayTimeByInterval:vo.commenttime]];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 12 , nameLabel.bottom + 6 , timeSize.width, timeSize.height)];
    timeLabel.font = [UIFont systemFontOfSize:10];
    timeLabel.textColor = [UIColor colorWithHexString:@"888888"];
    timeLabel.text = [NSString displayTimeByInterval:vo.commenttime] ;
    [_categoryView addSubview: timeLabel];

    //评论内容
    CGFloat imageY = imageView.bottom + 12 ;
    if (nil != vo.contents) {
        UILabel *titleLabel = [UILabel new];
        titleLabel.font = [UIFont systemFontOfSize:15];
        
        NSString *titleContent = [CommonFunc textFromBase64String:vo.contents];
        titleLabel.text = [self processText:titleContent  andWith:100];
        titleLabel.numberOfLines = 0;//多行显示，计算高度
        titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
        CGSize titleSize = [NSString getMultiStringContentSizeWithFontSize:15 andContent:[self processText:titleContent  andWith:100]];
        titleLabel.size = titleSize;
        titleLabel.x = timeLabel.left ;
        titleLabel.y = imageView.bottom + 10 ;
        titleLabel.width = kScreen_Width - 24 ;
        [_categoryView addSubview:titleLabel];
        imageY = titleLabel.bottom + 12 ;
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(nameLabel.left ,  _categoryView.bottom - .5 , kScreen_Width - nameLabel .left - 14, .5)];
    line.backgroundColor = [UIColor colorWithHexString:@"dddddd"] ;
    [_categoryView addSubview:line];
    
}

-(void)setSponsor : (SponsorVo *) vo {
   //头像
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 32/2 , 72/2 , 72/2)];
    if (nil == vo.logourl || [vo.logourl isEqual:[NSNull null]] ||[vo.logourl isEqualToString:@"<null>"]) {
        [imageView setImage:[UIImage imageNamed:@"defaulthead"]];
    }else{
        [imageView sd_setImageWithURL:[NSURL URLWithString:vo.logourl] placeholderImage:nil];
    }
    imageView.layer.cornerRadius= 72/2/2;// 将图层的边框设置为圆角
    imageView.layer.masksToBounds=YES;
    [self.contentView addSubview:imageView];
    
    CGSize nameSize = [NSString getStringContentSizeWithFontSize:14 andContent:vo.name];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 12 , 32/2 , nameSize.width, nameSize.height)];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor colorWithHexString:@"507daf"];
    nameLabel.text = vo.name ;
    [self.contentView addSubview: nameLabel];

  
    CGSize yewuSize = [NSString getStringContentSizeWithFontSize:11 andContent:@"业  务："];
    UILabel *yewuLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.left , nameLabel.bottom + 9 , yewuSize.width, yewuSize.height)];
    yewuLabel.font = [UIFont systemFontOfSize:11];
    yewuLabel.textColor = [UIColor colorWithHexString:@"333333"];
    yewuLabel.text = @"业  务：" ;
    [self.contentView addSubview: yewuLabel];
    
    UILabel *titleLabel2 = nil ;
    if (nil != vo.business) {
        titleLabel2 = [UILabel new];
        titleLabel2.font = [UIFont systemFontOfSize:11];
        
        NSString *titleContent = vo.business ;
        titleLabel2.text = [self processText:titleContent andWith:20];
        titleLabel2.numberOfLines = 0;//多行显示，计算高度
        titleLabel2.textColor = [UIColor colorWithHexString:@"888888"];
        CGSize titleSize = [NSString getMultiStringContentSizeWithFontSize:11 andContent:[self processText:titleContent andWith:20]];
        titleLabel2.size = titleSize;
        titleLabel2.x = yewuLabel.right ;
        titleLabel2.y = yewuLabel.top ;
        titleLabel2.width = kScreen_Width - yewuLabel.left - 12 ;
        [self.contentView addSubview:titleLabel2];
    }

    CGSize addressSize = [NSString getStringContentSizeWithFontSize:11 andContent:@"地  址："];
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 12 , titleLabel2.bottom + 9 , addressSize.width, addressSize.height)];
    addressLabel.font = [UIFont systemFontOfSize:11];
    addressLabel.textColor = [UIColor colorWithHexString:@"333333"];
    addressLabel.text = @"地  址：" ;
    [self.contentView addSubview: addressLabel];
    
    CGSize addSize = [NSString getStringContentSizeWithFontSize:11 andContent:vo.location];
    UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(addressLabel.right , titleLabel2.bottom + 9 , addSize.width, addSize.height)];
    addLabel.font = [UIFont systemFontOfSize:11];
    addLabel.textColor = [UIColor colorWithHexString:@"888888"];
    addLabel.text =vo.location ;
    [self.contentView addSubview: addLabel];

    
    CGSize contactSize = [NSString getStringContentSizeWithFontSize:11 andContent:@"联系方式："];
    UILabel *contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + 12 , addLabel.bottom + 9 , addLabel.bottom + 9 , contactSize.height)];
    contactLabel.font = [UIFont systemFontOfSize:11];
    contactLabel.textColor = [UIColor colorWithHexString:@"333333"];
    contactLabel.text = @"联系方式：" ;
    [self.contentView addSubview: contactLabel];
    
    CGSize cotaSize = [NSString getStringContentSizeWithFontSize:11 andContent:vo.contact];
    UILabel *conLabel = [[UILabel alloc] initWithFrame:CGRectMake(contactLabel.left + contactSize.width , addLabel.bottom + 9 , cotaSize.width, cotaSize.height)];
    conLabel.font = [UIFont systemFontOfSize:11];
    conLabel.textColor = [UIColor colorWithHexString:@"888888"];
    conLabel.text = vo.contact ;
    [self.contentView addSubview: conLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(12 , conLabel.bottom + 32/2 , kScreen_Width - 24 , 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"dddddd"] ;
    [self.contentView addSubview:line];
    
}

- (CGFloat)getSponsorContentHeight :(SponsorVo *) vo{
    
    
    UILabel *titleLabel2 = nil ;
    CGSize titleSize  ;
    if (nil != vo.business) {
        NSString *titleContent = vo.business ;
        titleLabel2.text = [self processText:titleContent andWith:20];
        titleLabel2.numberOfLines = 0;//多行显示，计算高度
        titleLabel2.textColor = [UIColor colorWithHexString:@"888888"];
        titleSize = [NSString getMultiStringContentSizeWithFontSize:11 andContent:[self processText:titleContent andWith:20]];
    }
    

    CGSize addSize = [NSString getStringContentSizeWithFontSize:11 andContent:vo.location];

    
    CGSize contactSize = [NSString getStringContentSizeWithFontSize:11 andContent:@"联系方式："];

    
    CGSize cotaSize = [NSString getStringContentSizeWithFontSize:11 andContent:vo.contact];
    
    return 32/2 + 9
            + titleSize.height + 9
            + addSize.height + 9
            + contactSize.height + 9
            + cotaSize.height + 1 ;
    
}

+(CGFloat)getOneLineContentHeight :(FCListVo *) vo{
    CGFloat contentHeight = [NSString getMultiStringContentSizeWithFontSize:15 andContent:vo.contents].height ;
    
    if (nil != vo.picurl && ![vo.picurl isEqualToString:@"<null>"]) {
        return 34/2 + 72/2 + 12 + contentHeight + 12 + 212/2 + 15 + 68/2 + 18 ;
    }
    
    return 34/2 + 72/2 + 12 + contentHeight + 12 + 68/2 + 18 ;
    
}

+(CGFloat)getOneDetailContentHeight :(FCListVo *) vo{
    CGFloat contentHeight = [NSString getMultiStringContentSizeWithFontSize:15 andContent:vo.contents].height ;
    
    if (nil != vo.picurl && ![vo.picurl isEqualToString:@"<null>"]) {
        return 15 + 72/2 + 12 + contentHeight + 12 + 214/2 + 15 + 68/2 + 10  ;
    }
    
    return 15 + 72/2 + 12 + contentHeight + 12 + 68/2 + 10  ;
}

+(CGFloat)getOneDetailCommentHeight :(CommentVo *) vo{

    if ([vo.contents isEqual:[NSNull null]]) {
        vo.contents = @"5q2l5q2l" ;
    }
    
    CGFloat contentHeight = [NSString getMultiStringContentSizeWithFontSize:15 andContent:    [CommonFunc textFromBase64String:vo.contents]].height ;
    
    CGSize timeSize = [NSString getStringContentSizeWithFontSize:14 andContent:[NSString displayTimeByInterval:vo.commenttime]];
    
    CGSize nameHeight = [NSString getStringContentSizeWithFontSize:11 andContent:vo.name];
    
    return contentHeight + timeSize.height + nameHeight.height + 13 + 8 + 13 + 10  ;
    
}



-(void)viewAction : (UIButton *)btn {
    [self.delegate viewAction:btn];
}

-(void)commentAction : (UIButton *)btn {
    [self.delegate commentAction :btn];
}

-(void)rightAction : (PicButton *)btn {
    [self.delegate rightAction:btn];
}

-(void)viewPic : (id)sender{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSString *tag = [NSString stringWithFormat:@"%ld" , [singleTap view].tag];
    [self.delegate viewPic:sender andWithSection:tag];
}

-(NSString *) processText :(NSString *) content andWith :(NSInteger) size {
    NSInteger number = [content length];
    if (number > size) {
        return [NSString stringWithFormat:@"%@..." ,[content substringToIndex:95]];
    }
    return content ;
}

-(void)deleteAction : (id)sender {
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    NSString *tag = [NSString stringWithFormat:@"%@" , [singleTap view].accessibilityHint];
    [self.delegate deleteAction:tag];

}

@end
