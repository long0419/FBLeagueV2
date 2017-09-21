//
//  AddSaiTimeViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/9/8.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "DSLLoginTextField.h"

@interface AddSaiTimeViewController : BaseViewController<QMUITextViewDelegate , UITextFieldDelegate>
@property (nonatomic , strong) NSString *leagueId ;

@end
