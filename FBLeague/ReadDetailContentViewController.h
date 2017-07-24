//
//  ReadDetailContentViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/2/16.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ReadDetailContentViewController : BaseViewController <UIWebViewDelegate>

@property(nonatomic, strong) UIWebView *uview;
@property(nonatomic, strong) NSString *type ;

@end
