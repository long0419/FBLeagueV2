//
//  CoachChooseTableViewCell.h
//  FBLeague
//
//  Created by long-laptop on 2016/12/5.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonFunc.h"

@protocol focusAction <NSObject>

-(void) focusContact :(UIView *) view ;
-(void) gofans :(UIView *) view ;
-(void) gofanlist :(NSString *)pid  ;
-(void) sendapply : (NSString *)clubid andWith :(NSString *)phone ;
@end

@interface CoachChooseTableViewCell : UITableViewCell

-(void) setPhoneContactCellByImageName :(NSString *) imageName andWithName :(NSString *) name andWithPhoneNum : (NSString *) num andWithChoose :(NSString *) use andWithindex :(NSInteger) indexPath ;

-(void) setPhoneContactCellByImageName2 :(NSString *) imageName andWithName :(NSString *) name andWithPhoneNum : (NSString *) num andWithChoose :(NSString *) use andWithindex :(NSInteger) indexPath ;

@property (nonatomic , strong) id<focusAction> delegate ;

@end
