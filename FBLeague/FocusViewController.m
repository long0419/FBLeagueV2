//
//  FocusViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/8.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "FocusViewController.h"
#import "CoachVo.h"
#import "CoachChooseTableViewCell.h"
#import "ChineseString.h"
#import "pinyin.h"

@interface FocusViewController (){
    NSString *pageNO ;
    NSMutableArray *coachList ;
}

@end

@implementation FocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getCoachDatas:@"1"];
    
    pageNO = @"1" ;
    
    coachList = [[NSMutableArray alloc] init] ;
    
    _coachTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    _coachTableView.delegate = self ;
    _coachTableView.dataSource = self;
    _coachTableView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    _coachTableView.separatorStyle = NO ;
    [self.view addSubview:_coachTableView];
 
    __weak FocusViewController *weakSelf = self ;
    [_coachTableView addPullToRefreshWithActionHandler:^{
        [weakSelf getCoachDatas : @"1"];
        [weakSelf.coachTableView.pullToRefreshView stopAnimating];
    }];
    
    __weak NSString *no = pageNO ;
    [_coachTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getCoachDatas : [NSString stringWithFormat:@"%@", no]];
        [weakSelf.coachTableView.infiniteScrollingView stopAnimating];
    }];
    
    [_coachTableView.pullToRefreshView setTitle:@"下拉刷新..." forState:SVPullToRefreshStateStopped];
    [_coachTableView.pullToRefreshView setTitle:@"释放更新..." forState:SVPullToRefreshStateTriggered];
    [_coachTableView.pullToRefreshView setTitle:@"加载中..." forState:SVPullToRefreshStateLoading];
    
}

-(void)getCoachDatas : (NSString *) page {
    
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:page , @"page" ,
                            uvo.phone , @"phone"  , @"d3e61391-ba6e-45b0-9e78-dc552f3d1fd8" , @"token" , nil];
    
    [PPNetworkHelper POST:getCoaches parameters:params success:^(id object) {
        
        if([object[@"code"] isEqualToString:@"0000"]){
            NSDictionary *list = object[@"list"];
            CoachVo *model = nil ;
            [coachList removeAllObjects];
            
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *dic in list) {
                    model = [CoachVo new];
                    model.cityName = [NSString stringWithFormat:@"%@" , dic[@"cityName"]] ;
                    model.firstLetter = [NSString stringWithFormat:@"%@" ,dic[@"firstLetter"]] ;
                    model.hasFocus = [NSString stringWithFormat:@"%@" ,dic[@"hasFocus"]] ;
                    model.level = [NSString stringWithFormat:@"%@" ,dic[@"level"]]  ;
                    model.name = [NSString stringWithFormat:@"%@" ,dic[@"name"]]  ;
                    model.phone =  [NSString stringWithFormat:@"%@" ,dic[@"phone"]]  ;
                    [coachList addObject:model];
                    
                }
                
                [self processCoachData];
                
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


-(void)processCoachData{
    
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    for (CoachVo *vo in coachList) {
        [tmp addObject:[NSString stringWithFormat:@"%@" , vo.name]];
    }
    
    self.indexArray = [ChineseString IndexArray:tmp];
    
    NSLog(@"%@" , self.indexArray);
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
        CoachVo *vo = [coachList objectAtIndex:indexPath.section];
        
        [cell setPhoneContactCellByImageName:vo.headerUrl andWithName:vo.name andWithPhoneNum:vo.cityName andWithChoose:vo.hasFocus andWithindex:indexPath.section];
        
        cell.delegate =  self ;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
    
}

-(void) focusContact :(UIView *) view {
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    CoachVo *vo = [coachList objectAtIndex:view.tag];
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.phone , @"fanPhone" , vo.phone , @"famousPhone" , @"1", @"famousType", nil];
    [PPNetworkHelper POST:focusPerson parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            view.backgroundColor = [UIColor colorWithHexString:@"2eb66a"];
            
            UILabel *focusLabel = [view viewWithTag:12];
            focusLabel.font = [UIFont systemFontOfSize:14];
            focusLabel.textColor = [UIColor whiteColor];
            focusLabel.text = @"已关注" ;
            
            view.userInteractionEnabled = NO ;
            
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"关注成功";
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


#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70  ;
}

#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CoachVo *vo = [coachList objectAtIndex:indexPath.section];
    
    [self.delegate gotoDetail:vo.phone];
    
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20 ;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section

{
    
    view.tintColor = [UIColor whiteColor];
    
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.contentView.backgroundColor= [UIColor colorWithHexString:@"f6f6f6"];
    
    header.textLabel.textAlignment=NSTextAlignmentLeft;
    
    header.textLabel.font = [UIFont systemFontOfSize:13];
    
    [header.textLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
}

@end
