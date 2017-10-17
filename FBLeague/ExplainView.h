//
//  ExplainView.h
//  kinvest
//
//  Created by long-laptop on 16/4/14.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExplainView : UIView

-(UIView *) showTipByText : (NSString *) txt andWithRect : (CGRect) rect ;

-(UIView *) uploadPicAndTip : (NSString *)txt andWithRect : (CGRect) rect ;

-(void) setTipShowPhoto :(NSString *) name withSize :(CGSize) size ;
-(void) setTipBackGroundColor : (UIColor *) color ;

+ (UIView *)titleView :(NSString *)title ;

+ (UIView *)textView :(NSString *)firstName ;

+(UIView *) goToView : (NSString *) title ;

+(UIView *) metricDetail : (NSString *) title
              andWithNum :(CGFloat) num andWithColor : (NSString *) color andRight : (BOOL) isright ;

@property (nonatomic , strong) UIImageView *tipShow ;
@property (nonatomic , strong) UIView *tip ;


@end
