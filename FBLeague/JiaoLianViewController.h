//
//  JiaoLianViewController.h
//  FBLeague
//
//  Created by long-laptop on 2017/7/8.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol goToJiaoLianDetail <NSObject>

-(void) gotoDetail : (NSString *)phone ;

@end

@interface JiaoLianViewController : UIViewController

@property(nonatomic,strong)id<goToJiaoLianDetail> delegate;

@end
