//
//  ZLVerifyCodeButton.h
//  FBLeague
//
//  Created by long-laptop on 2017/7/4.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLVerifyCodeButton : UIButton
// 由于有些时间需求不同，特意露出方法，倒计时时间次数
- (void)timeFailBeginFrom:(NSInteger)timeCount;
@end
