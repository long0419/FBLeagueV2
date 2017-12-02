//
//  BeiSaiNumViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/11/16.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "SaiChengVo.h"

@interface BeiSaiNumViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic , strong) SaiChengVo *vo ;
@property (nonatomic , strong) NSString *matchId ;


@end
