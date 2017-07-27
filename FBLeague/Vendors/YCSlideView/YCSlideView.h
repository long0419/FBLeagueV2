//
//  YCSlideView.h
//  youzer
//
//  Created by 王禹丞 on 15/12/16.
//  Copyright © 2015年 QXSX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollIndex <NSObject>

-(void) getScrollIndex :(NSInteger) index ;

@end


@interface YCSlideView : UIView

@property (nonatomic,strong)NSArray * vcArray;
@property (nonatomic , strong) id<ScrollIndex> delegate ;

- (instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSArray *)viewControllers;



@end
