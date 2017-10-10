//
//  FCListViewSingle.h
//  kinvest
//
//  Created by long-laptop on 16/5/21.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCListVo.h"
#import "CommentVo.h"
#import "SponsorVo.h"

@protocol ViewPicDelegate <NSObject>

-(void)viewPic :(id)view andWithSection : (NSString *)section ;
-(void)commentAction : (UIButton *)btn ;
-(void)rightAction : (UIButton *)btn ;
-(void)viewAction : (UIButton *)btn ;
-(void)deleteAction : (NSString *)tag ;

@end

@interface FCListViewSingle : UITableViewCell {
    NSString *pUrls ;
}

@property (nonatomic , strong) UIView *categoryView ;
@property (nonatomic , strong) id<ViewPicDelegate> delegate ;

+(CGFloat)getOneLineContentHeight :(FCListVo *) vo;

+(CGFloat)getOneDetailContentHeight :(FCListVo *) vo;

+(CGFloat)getOneDetailCommentHeight :(CommentVo *) vo;

-(CGFloat)getSponsorContentHeight :(SponsorVo *) vo;


-(void)setStatus:(FCListVo *) vo andWithRawHeight : (CGFloat) height andWithSection : (NSString *) section  andIsMine : (BOOL) ismy;

-(void)setDetailStatus:(FCListVo *) vo andWithRawHeight : (CGFloat) height ;

-(void)setDetailCommentStatus:(CommentVo *) vo andWithRawHeight : (CGFloat) height ;

-(void)setSponsor : (SponsorVo *) vo ;

@end
