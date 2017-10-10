//
//  PicButton.h
//  kinvest
//
//  Created by long-laptop on 16/4/12.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicButton : UIButton

-(void) getPicButtonWithText : (NSString *) imageName andWithTint : (NSString *) text andWithTintColor : (NSString *) tintColor andCGRectImage : (CGRect) imageRect andWithTintSpace : (CGFloat) space ;

-(void) getPicButtonWithText2 : (NSString *) imageName andWithTint : (NSString *) text andWithTintColor : (NSString *) tintColor andCGRectImage : (CGRect) imageRect andWithTintSpace : (CGFloat) space ;

-(void) btnWithTopPic :(NSString *) name andWithText :(NSString *) text andWithTextSize :(CGFloat) size andWithImageViewFrame :(CGRect) frame1  andSpaceWithTwo :(CGFloat) space andWithTintColor :(NSString *) tintColor;

@end
