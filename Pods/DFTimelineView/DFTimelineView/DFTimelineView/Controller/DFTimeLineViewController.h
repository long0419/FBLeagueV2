//
//  DFTimeLineViewController.h
//  DFTimelineView
//
//  Created by Allen Zhong on 15/9/27.
//  Copyright (c) 2015年 Datafans, Inc. All rights reserved.
//

#import "DFBaseLineItem.h"

#import "DFLineLikeItem.h"
#import "DFLineCommentItem.h"

#import "DFBaseTimeLineViewController.h"

@interface DFTimeLineViewController : DFBaseTimeLineViewController

//添加到末尾
-(void) addItem:(DFBaseLineItem *) item;

//添加到头部
-(void) addItemTop:(DFBaseLineItem *) item;

//根据ID删除
-(void) deleteItem:(long long) itemId;

//赞
-(void) addLikeItem:(DFLineLikeItem *) likeItem itemId:(NSString *) itemId;

//评论
-(void) addCommentItem:(DFLineCommentItem *) commentItem itemId:(NSString *) itemId replyCommentId:(NSString *) replyCommentId;


//发送图文
-(void)onSendTextImage:(NSString *)text images:(NSArray *)images;

//发送视频消息
-(void)onSendVideo:(NSString *)text videoPath:(NSString *)videoPath screenShot:(UIImage *) screenShot;


- (void) sendFC ;

@end
