//
//  VerifyPswViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/7/4.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface VerifyPswViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic , strong) NSString *phoneNum ;
@property (nonatomic , strong) NSString *from ;

@end
