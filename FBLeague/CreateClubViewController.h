//
//  CreateClubViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/7/21.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ChooseAreaViewController.h"
#import "VerifyClubViewController.h"
#import "WPAutoSpringTextViewController.h"

@interface CreateClubViewController : WPAutoSpringTextViewController <UITextFieldDelegate>

@property (nonatomic , strong) NSString *areaStr ;
@property (nonatomic , strong) NSString *areaCodeStr ;



@end
