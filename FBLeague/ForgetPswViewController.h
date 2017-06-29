//
//  ForgetPswViewController.h
//  kinvest
//
//  Created by long-laptop on 16/4/14.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPAutoSpringTextViewController.h"

@interface ForgetPswViewController : WPAutoSpringTextViewController<UITextFieldDelegate>

@property (nonatomic , strong) NSString *phoneNum ;

@end
