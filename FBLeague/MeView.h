//
//  MeView.h
//  FBLeague
//
//  Created by long-laptop on 2017/1/2.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"
@protocol MeData

- (void)meData : (NSString *)title andWithValue : (NSString *)value andWithRawValue : (NSString *) rawnum ;

@end

@interface MeView : UIView <UITextViewDelegate>

-(UIView *) getMePic :(NSString *)title andWithTintPic : (NSString *)tintPic andWithEndImage :(NSString *)imageName andWithImageSize :(CGSize) size andPoint :(CGPoint) point andIsline :(BOOL) isline ;


-(UIView *) getImportData :(NSString *)title andWithRatioNum :(NSString *) num andWithMax :(NSString *)total ;

-(UIView *) getKeShi : (NSString *)title andWithContent :(NSString *)content
          andWithType:(NSString *) type ;

-(UIView *) getzhan :(NSString *)title andWithContentTextField :(NSString *)content ;

@property(nonatomic , strong) id<MeData> delegate ;

@end
