//
//  BeginTouView.h
//  kinvest
//
//  Created by long-laptop on 16/4/18.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BeginTouTapDelegate

- (void)tapAction : (id) sender andWithTag :(NSString *)tag;

@end
@interface BeginTouView : UIView

@property (nonatomic , strong) id<BeginTouTapDelegate> delegate ;

-(UIView *) getBeginTouView : (NSString *) title  andWithTintTitle :(NSString *)tintStr andWithEndTint :(NSString *)endTint andPoint : (CGPoint) point ;

-(UIView *) getBeginTouView : (NSString *) title  andWithTintTitle :(NSString *)tintStr andWithEndImage :(NSString *)imageName andWithImageSize :(CGSize) size  andPoint :(CGPoint) point andWithTag :(NSInteger) tag;

-(UIView *) beginTouListOne :(NSString *) title andWithType :(NSString *) type andWithBackRatio :(NSString *) ratio andWithDays :(NSString *)day andWithPercent :(NSString *) percentage : andWithMoney :(NSString *) money : andWithTotalMoney :(NSString *) total ;

-(UIView *) getBeginTouPic :(NSString *)title andWithPic :(NSString *) pic andWithEndImage :(NSString *)imageName andWithImageSize :(CGSize) size andPoint :(CGPoint) point;

-(UIView *) getBeginTouPic :(NSString *)title andWithContent: (NSString *)content andWithEndImage :(NSString *)imageName andWithImageSize :(CGSize) size andPoint :(CGPoint) point;

-(UIView *) getBeginTouViewBg :(CGRect) frame ;

@end
