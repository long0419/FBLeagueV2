//
//  AddSaiViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/9/6.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BHBPopView.h"

@interface AddSaiViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic , strong) NSString *areaStr ;
@property (nonatomic , strong) NSString *areaCodeStr ;
@property (nonatomic , strong) NSString *leagueId ;

- (void) share ;

@end
