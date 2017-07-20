//
//  SearchJiaoLianViewController.m
//  FBLeague
//
//  Created by long-laptop on 2016/12/12.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "SearchJiaoLianViewController.h"
#import "SVPullToRefresh.h"
#import "MBProgressHUD.h"
#import "CoachVo.h"
#import "CoachChooseTableViewCell.h"
#import "YCSlideView.h"

@interface SearchJiaoLianViewController (){
    UITextField  *searchTxt;
    UIButton *go ;
    UIButton *srecord ;
    int order;
    NSString *pageNO ;
    NSMutableArray *kouList ;
    NSString *soText ;
    YCSlideView * view ;
}

@end

@implementation SearchJiaoLianViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self closeProgressView];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    kouList = [[NSMutableArray alloc] init];
    
    //设置顶部搜索
    [self setHeader];
 
    self.soTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44 + 30 , kScreen_Width, kScreen_Height - (20+44) )];
    _soTableView.delegate = self ;
    _soTableView.dataSource = self;
    _soTableView.backgroundColor = [UIColor clearColor];
    _soTableView.separatorStyle = NO ;
    [self.view addSubview:_soTableView];
    
}


-(void)setHeader{
    self.titleName = @"" ;
    
    UIView *headerBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0 ,kScreen_Width, 44 + 22)];
    headerBar.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self.view addSubview:headerBar];
    
    CGSize goTextSize = [NSString getStringContentSizeWithFontSize:14 andContent:@"取消"];
    go = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width - goTextSize.width - 12 , (44 - goTextSize.height)/2 + 22 , goTextSize.width , goTextSize.height)];
    [go addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    go.backgroundColor = [UIColor clearColor];
    go.titleLabel.font =SystemFontOfSize(14);
    go.titleLabel.textAlignment = NSTextAlignmentCenter ;
    go.userInteractionEnabled = NO ;
    [go setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [go setTitle:@"取消" forState:UIControlStateNormal];
    [headerBar addSubview:go];
    
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(search)];
    UIView *btn = [[UIView alloc] initWithFrame:CGRectMake(go.left , go.top , kScreen_Width - go.left , go.height)] ;
    btn.backgroundColor = [UIColor clearColor] ;
    [btn addGestureRecognizer:tapGesture];
    [headerBar addSubview:btn];
    
    UIView *searchBar = [[UIView alloc] initWithFrame:CGRectMake(12 , (44 - 48/2)/2 + 22 , kScreen_Width - 12 - go.width - 24 , 48/2)];
    [[searchBar layer]setCornerRadius:3];//圆角
    [searchBar layer].borderColor = [UIColor blackColor].CGColor ;
    searchBar.layer.borderWidth = 1 ;
    searchBar.backgroundColor=[UIColor colorWithHexString:@"ffffff" andAlpha:.2];
    [headerBar addSubview:searchBar];
    
    UIImageView *soPic = [[UIImageView alloc] initWithFrame:CGRectMake(8 , (searchBar.height - 16)/2, 16, 16)] ;
    [soPic setImage :[UIImage imageNamed:@"搜索2"]];
    soPic.backgroundColor = [UIColor clearColor];
    [searchBar addSubview:soPic];
    
    CGSize placeholderSize = [NSString getStringContentSizeWithFontSize:14 andContent:@"请输入人名或地区名"];
    searchTxt = [[UITextField alloc] initWithFrame:CGRectMake(soPic.right + 6 , (searchBar.height - placeholderSize.height)/2, searchBar.width - 16, placeholderSize.height)];
    searchTxt.delegate = self ;
    UIColor *color = [UIColor colorWithHexString:@"000" andAlpha:.4];
    searchTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入人名或地区名" attributes:@{NSForegroundColorAttributeName: color}];
    searchTxt.font = SystemFontOfSize(14);
    searchTxt.textColor = [UIColor colorWithHexString:@"000"];
    searchTxt.textAlignment = NSTextAlignmentLeft ;
    searchTxt.returnKeyType = UIReturnKeySearch ;
    searchTxt.backgroundColor = [UIColor clearColor];
    [searchTxt addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [searchBar addSubview: searchTxt];
    
    srecord = [[UIButton alloc] initWithFrame:CGRectMake(searchBar.right - 12 - 23 , (searchBar.height - 12)/2 , 12, 12)] ;
    [srecord setImage:[UIImage imageNamed:@"选择关闭"] forState:UIControlStateNormal];//resettext
    srecord.backgroundColor = [UIColor clearColor];
    [srecord addTarget:self action:@selector(deleteAllMsg:) forControlEvents:UIControlEventTouchUpInside];
    srecord.hidden = YES ;
    [searchBar addSubview:srecord];
 

}

-(void)search {
    [searchTxt resignFirstResponder];
    if ([go.titleLabel.text isEqualToString:@"取消"]) {
        [self back];
    }else{
        [self getNeedDatas];
    }
    soText = searchTxt.text ;
}

-(void)getNeedDatas {
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone , @"phone"  , soText , @"cityOrArea" , nil];
    
    [PPNetworkHelper POST:getCoaches parameters:params success:^(id object) {
        
        if([object[@"code"] isEqualToString:@"0000"]){
            NSDictionary *list = object[@"coaches"];
            CoachVo *model = nil ;
            [kouList removeAllObjects];
            
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *dic in list) {
                    model = [CoachVo new];
                    model.cityName = [NSString stringWithFormat:@"%@" , dic[@"cityName"]] ;
                    model.firstLetter = [NSString stringWithFormat:@"%@" ,dic[@"firstLetter"]] ;
                    model.hasFocus = [NSString stringWithFormat:@"%@" ,dic[@"hasFocus"]] ;
                    model.level = [NSString stringWithFormat:@"%@" ,dic[@"level"]]  ;
                    model.name = [NSString stringWithFormat:@"%@" ,dic[@"name"]]  ;
                    model.phone =  [NSString stringWithFormat:@"%@" ,dic[@"phone"]]  ;
                    model.headerUrl =  [NSString stringWithFormat:@"%@" ,dic[@"headpicurl"]]  ;
                    [kouList addObject:model];
                }
                [_soTableView reloadData];
            }
            
            
            if ([kouList count] > 0) {
                btn_filter.hidden = NO ;
                btn_order.hidden = NO ;
            }else{
                btn_filter.hidden = YES ;
                btn_order.hidden = YES ;
            }
        }else {
//            self.HUD.mode = MBProgressHUDModeText;
//            self.HUD.removeFromSuperViewOnHide = YES;
//            self.HUD.labelText = @"系统错误";
//            [self.HUD hide:YES afterDelay:3];
        }

        
    } failure:^(NSError *error) {
        
    }];
    
//    [self closeProgressView];
    
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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



#pragma mark textarea
// 设置输入框，是否可以被修改
// NO-将无法修改，不出现键盘
// YES-可以修改，默认值
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

// 当点击键盘的返回键（右下角）时，执行该方法。
// 一般用来隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    soText = textField.text ;
    [self getNeedDatas];
    [textField resignFirstResponder];
    return YES;
}

// 当输入框获得焦点时，执行该方法。
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
}

// 指定是否允许文本字段结束编辑，允许的话，文本字段会失去first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

// 文本框的文本，是否能被修改
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if ([searchTxt.text length]>0) {
        srecord.hidden = NO ;
    }else{
        srecord.hidden = YES ;
    }
}

-(void)deleteAllMsg :(UIButton *) btn{
    searchTxt.text = @"" ;
    [self textFieldDidChange:searchTxt];
}


@end
