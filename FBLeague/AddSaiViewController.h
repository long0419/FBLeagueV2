//
//  AddSaiViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/9/6.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
//#import "KYShareViewController.h"

@interface AddSaiViewController : BaseViewController<UITextFieldDelegate>
//, KYShareDismissDelegate>

@property (nonatomic , strong) NSString *areaStr ;
@property (nonatomic , strong) NSString *areaCodeStr ;

@end
