//
//  LianSaiView.h
//  FBLeague
//
//  Created by long-laptop on 2017/9/6.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LianSaiView : UITableViewCell

-(UIView *)BaomingView :(NSString *)title andWithName :(NSString *)name andWithLineData:(NSString *)now withTotal :(NSString *)total ;

-(UIView *)getSaiLineView :(NSString *) content andWithType :(NSString *)type;

+ (UIView *)getDuiView :(NSString *) type andWithNum :(NSString *) num andWithPoint : (CGPoint) point ;

-(UIView *)getHeSuiCell :(NSString *) fromSai andToSai :(NSString *)toSai andWithResult :(NSString *)result ;

@end
