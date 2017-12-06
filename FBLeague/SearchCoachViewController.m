//
//  SearchCoachViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/20.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "SearchCoachViewController.h"
#import "CoachChooseTableViewCell.h"
#import "CoachVo.h"

@interface SearchCoachViewController (){
    NSMutableArray *kouList ;

}

@end

@implementation SearchCoachViewController

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

-(void) searchCoachByContent :(NSArray *) contents  {
    [kouList removeAllObjects];
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
        UserDataVo *vo = [kouList objectAtIndex:indexPath.row];
        
        [cell setPhoneContactCellByImageName:vo.headpicurl andWithName:[CommonFunc textFromBase64String:vo.nickname] andWithPhoneNum:vo.cityName andWithChoose:vo.hasfocus andWithindex:indexPath.section];

        cell.delegate =  self ;

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
    
    UserDataVo *vo = [kouList objectAtIndex:indexPath.section];
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"forwardSeDetail" object:vo userInfo:nil]];

}

#pragma mark - error
-(void) focusContact :(UIView *) view {
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    UserDataVo *vo = [kouList objectAtIndex:view.tag];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.phone , @"fanphone" , vo.phone , @"famousphone" , @"1", @"famoustype", uvo.phone , @"token" , nil];
    
    [PPNetworkHelper POST:focusPerson parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            view.backgroundColor = [UIColor colorWithHexString:@"000000"];
            
            UILabel *focusLabel = [view viewWithTag:12];
            focusLabel.font = [UIFont systemFontOfSize:14];
            focusLabel.textColor = [UIColor whiteColor];
            focusLabel.text = @"已关注" ;
            view.userInteractionEnabled = NO ;
            
            [SVProgressHUD showSuccessWithStatus:@"关注成功"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            
        }else {
            [SVProgressHUD showSuccessWithStatus:@"系统错误"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        }
    } failure:^(NSError *error) {
        
    }];
}



@end
