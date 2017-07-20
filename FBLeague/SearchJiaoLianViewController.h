//
//  SearchJiaoLianViewController.h
//  FBLeague
//
//  Created by long-laptop on 2016/12/12.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SearchJiaoLianViewController : BaseViewController <
    UITableViewDataSource , UITableViewDelegate ,
    UITextFieldDelegate>{
    
    UIButton *btn_order,*btn_filter;
    
}

@property (nonatomic , strong) UITableView *soTableView;
@property (nonatomic , strong) NSString *titleName ;
@property (nonatomic , strong) NSMutableArray *soGoods ;


@end
