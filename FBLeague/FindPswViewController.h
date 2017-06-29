//
//  FindPswViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/3/11.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface FindPswViewController : BaseViewController<UITextFieldDelegate>

@property(nonatomic , strong) NSString *phone ;
@property (nonatomic , strong) UIView *account ;
@property (nonatomic , strong) UIView *account2 ;

@end
