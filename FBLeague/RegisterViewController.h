//
//  RegisterViewController.h
//  kinvest
//
//  Created by long-laptop on 16/4/11.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WPAutoSpringTextViewController.h"
#import "ZLVerifyCodeButton.h"

@interface RegisterViewController : BaseViewController <UITextFieldDelegate , UIImagePickerControllerDelegate , UIActionSheetDelegate>


@property (nonatomic , strong) NSString *phoneNum ;
@property (nonatomic , strong) NSString *nickname ;
@property (nonatomic , strong) NSString *openId ;
@property (nonatomic , strong) NSString *from ;

@end
