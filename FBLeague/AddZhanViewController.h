//
//  AddZhanViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/1/4.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BeginTouView.h"
#import "ACActionSheet.h"
#import "MeView.h"

@interface AddZhanViewController : BaseViewController<BeginTouTapDelegate ,
UITextViewDelegate , UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIActionSheetDelegate>

@property (nonatomic , strong) NSString *club ;

@end
