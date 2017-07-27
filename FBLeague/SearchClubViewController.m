//
//  SearchClubViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/20.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "SearchClubViewController.h"
#import "CoachChooseTableViewCell.h"
#import "CoachVo.h"

@interface SearchClubViewController (){
    NSMutableArray *kouList ;

}

@end

@implementation SearchClubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    kouList = [[NSMutableArray alloc] init] ;
    
    self.soTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , kScreen_Width, kScreen_Height - (20+44) - 36)];
    _soTableView.delegate = self ;
    _soTableView.dataSource = self;
    _soTableView.backgroundColor = [UIColor clearColor];
    _soTableView.separatorStyle = NO ;
    [self.view addSubview:_soTableView];

}

-(void) searchClubByContent :(NSArray *) contents  {
    [kouList addObjectsFromArray:contents] ;
    [_soTableView reloadData];
}

#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [kouList count];
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Categorys = @"Categorys";
    
    CoachChooseTableViewCell *cell = [[CoachChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Categorys];
    if (kouList.count > 0){
        CoachVo *vo = [kouList objectAtIndex:indexPath.row];
        
        [cell setPhoneContactCellByImageName:vo.headerUrl andWithName:vo.name andWithPhoneNum:vo.cityName andWithChoose:vo.hasFocus andWithindex:indexPath.section];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
}

#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70 ;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CoachVo *vo = [kouList objectAtIndex:indexPath.section];

}

@end
