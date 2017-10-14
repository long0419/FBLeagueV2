//
//  ApplyListViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/3/10.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "ApplyListViewController.h"
#import "UserDataVo.h"

@interface ApplyListViewController (){
    NSString *pageNO ;
    NSMutableArray *coachList ;
    UserDataVo *user ;
    NSString *clubId ;

}

@end

@implementation ApplyListViewController

-(void)viewWillAppear:(BOOL)animated{
    [self hideTabBottom];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"审核列表" ;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f6f7"];
    
    [self setBackBottmAndTitle];
    
//    [self setRightBottom];
    
    coachList = [[NSMutableArray alloc] init] ;
    
    _coachTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    _coachTableView.delegate = self ;
    _coachTableView.dataSource = self;
    _coachTableView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    _coachTableView.separatorStyle = NO ;
    [self.view addSubview:_coachTableView];
    
    [self getCoachDatas:@"1"];
    
}

-(void) sendapply : (NSString *)clubid andWith :(NSString *)phone {
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: clubid ,  @"clubId" , phone , @"phone",uvo.phone ,  @"token", nil];
    
    [PPNetworkHelper POST:getApplyTrainee parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"同意申请";
            [self.HUD hide:YES afterDelay:3];
        }else {
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"系统错误";
            [self.HUD hide:YES afterDelay:3];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)getCoachDatas : (NSString *) page {
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.club , @"clubId"  , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:getApplyTrainee parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            NSDictionary *list = object[@"users"];
            UserDataVo *vo = nil ;
            [coachList removeAllObjects];
            
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *dic in list) {
                    vo = [UserDataVo new];
                    vo.citycode = [NSString stringWithFormat:@"%@" ,dic[@"citycode"]] ;
                    vo.club = [NSString stringWithFormat:@"%@" ,dic[@"clubid"]]  ;
                    vo.headpicurl = [NSString stringWithFormat:@"%@" ,dic[@"headpicurl"]] ;
                    vo.realname = [NSString stringWithFormat:@"%@" ,dic[@"name"]] ;
                    vo.phone = [NSString stringWithFormat:@"%@" ,dic[@"phone"]] ;
                    vo.status = [NSString stringWithFormat:@"%@" ,dic[@"status"]] ;
                    
                    [coachList addObject:vo];
                    
                }
                [_coachTableView reloadData];
            }
        }else {
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"系统错误";
            [self.HUD hide:YES afterDelay:3];
        }
    } failure:^(NSError *error) {
         
    }];
    [self closeProgressView];

}

#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [coachList count] ;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Categorys = @"Categorys";
    
    CoachChooseTableViewCell *cell = [[CoachChooseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Categorys];
    if (coachList.count > 0){
        UserDataVo *vo = [coachList objectAtIndex:indexPath.section];
        cell.delegate = self ;
        [cell setPhoneApplyCellByImageName:vo.headpicurl andWithName:vo.realname andWithPhoneNum:vo.phone andWithindex:indexPath.section andWithRole:vo.club andPosition:vo.status];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
    
}

#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70  ;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end