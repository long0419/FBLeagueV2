//
//  UpdateUserInfoViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/3/10.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BeginTouView.h"
#import "UserDataVo.h"
#import "JulebuViewController.h"
#import "CommonFunc.h"
#import "MeViewController.h"

@interface UpdateUserInfoViewController : BaseViewController<BeginTouTapDelegate ,
    UITextViewDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIActionSheetDelegate>

@property (nonatomic , strong) NSString *name ;
@property (nonatomic , strong) NSString *clubname ;
@property (nonatomic,retain) UIDatePicker *datePicker;
@property (nonatomic , strong) NSString *jianjie ;
@property (nonatomic , strong) NSString *areaStr;
@property (nonatomic , strong) NSString *clubId ;

@end
