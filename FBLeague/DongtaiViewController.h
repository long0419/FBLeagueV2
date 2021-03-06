//
//  DongtaiViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/7/8.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DFTimelineView.h"
#import "LianmengViewController.h"
#import "DFImagesSendViewController.h"
#import "MMSheetView.h"
#import "TZImagePickerController.h"
#import "DongtaiVo.h"
#import "CommentVo.h"
#import "CommonFunc.h"

@interface DongtaiViewController : DFTimeLineViewController

@property (nonatomic , strong) NSString *type ; //1.首页 2.俱乐部 3.个人动态 4.已关注动态 5.未读帖子列表

@property (nonatomic , strong) NSString *phone ; 
@property (nonatomic , strong) NSString *club ;

- (void) onFCTextImage:(NSString *) text images:(NSArray *)images ;

@end
