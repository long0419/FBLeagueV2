//
//  SearchJiaoLianViewController.h
//  FBLeague
//
//  Created by long-laptop on 2016/12/12.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "YCSlideView.h"

@protocol SearchContentByIndex <NSObject>

-(void) searchClubByContent :(NSArray *) contents  ;

-(void) searchCoachByContent :(NSArray *) contents  ;

@end


@interface SearchJiaoLianViewController : BaseViewController <
    UITableViewDataSource , UITableViewDelegate ,
    UITextFieldDelegate ,ScrollIndex>{
    UIButton *btn_order,*btn_filter;
}

@property (nonatomic , strong) UITableView *soTableView;
@property (nonatomic , strong) NSString *titleName ;
@property (nonatomic , strong) NSMutableArray *soGoods ;
@property (nonatomic , strong) id<SearchContentByIndex> delegate ;

@end
