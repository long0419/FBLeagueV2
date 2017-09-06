//
//  JiFenViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/2.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "JiFenViewController.h"

@interface JiFenViewController ()

@end

@implementation JiFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZRGridViewLayoutAndStyle *gridViewLayout = [[ZRGridViewLayoutAndStyle alloc] init];
    gridViewLayout.showGridLine = YES;
    gridViewLayout.headerBackgroudColor = [UIColor colorWithHexString:@"3a444e"];
    gridViewLayout.fieldTitleColor = [UIColor whiteColor];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    ZRGridView *gridView = [[ZRGridView alloc] initWithFrame:CGRectMake(0 , 0 ,kScreen_Width , kScreen_Height - 200) gridViewLayoutAndStyle:gridViewLayout];
    gridView.gridViewDelegate = self;
    gridView.gridViewDataSource = self;
    [self.view addSubview:gridView];

}

#pragma mark - ZRGridViewDataSource

- (NSInteger)numberOfColumnsInGridView:(ZRGridView *)gridView{
    return 7;
}

- (NSInteger)numberOfRowsInGridView:(ZRGridView *)gridView{
    return 100;
}

- (NSString *)gridView:(ZRGridView *)gridView titleOfColumnsAtIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"field_%lu",index];
}

- (NSString *)gridView:(ZRGridView *)gridView valueAtRow:(NSInteger)rowIndex column:(NSInteger)columnIndex{
    return [NSString stringWithFormat:@"%lu*%lu",rowIndex,columnIndex];
}

- (UIColor *)gridView:(ZRGridView *)gridView itemBackgroudColorAtRow:(NSInteger)rowIndex column:(NSInteger)column{
    if (rowIndex%2) {
        return [UIColor colorWithHexString:@"eeeeee"];
    } else {
        return [UIColor whiteColor];
    }
}

- (CGFloat)gridView:(ZRGridView *)gridView widthForColumn:(NSInteger)index{
    if (index == 0) {
        return kScreen_Width - 30*6 ;
    }else{
        return 30 ;
    }
}

- (CGFloat)gridView:(ZRGridView *)gridView heightForRow:(NSInteger)index{
    return 40 ;
}

- (CGFloat)headerHeightOfGridView:(ZRGridView *)gridView{
    return 20 ;
}


@end
