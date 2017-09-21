//
//  SaiResultViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/9/4.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SaiChengVo.h"
#import "DSLLoginTextField.h"

@interface SaiResultViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic , strong) SaiChengVo *vo ;
@property (nonatomic , strong) NSString *matchId ;

@end
