
//
//  ChooseAreaViewController.m
//  FBLeague
//
//  Created by long-laptop on 2016/11/23.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "ChooseAreaViewController.h"
#import "ProvinceVo.h"

@interface ChooseAreaViewController (){
    NSMutableArray *kouList ;
}

@end

@implementation ChooseAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackBottmAndTitle];
    kouList = [[NSMutableArray alloc] init] ;

    self.title = @"选择地区" ;
    self.view.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor,nil];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self setBackBottmAndTitle];

    
    _goodTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0 , kScreen_Width, kScreen_Height)];
    _goodTableView.delegate = self ;
    _goodTableView.dataSource = self;
    _goodTableView.backgroundColor = [UIColor clearColor];
    _goodTableView.separatorStyle = NO ;
    [self.view addSubview:_goodTableView];
    
    [self getNeedDatas];

}

-(void)getNeedDatas{
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    APIClient *client = [APIClient sharedJsonClient];

    [client requestJsonDataWithPath:getProvinces withParams:nil withMethodType:Post andBlock:^(id data, NSError *error) {
        if([data[@"code"] isEqualToString:@"0000"]){
            NSDictionary *list = data[@"provinces"];
            ProvinceVo *model = nil ;
            [kouList removeAllObjects];
            
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *dic in list) {
                    model = [ProvinceVo new];
//                    if (![dic[@"name"] isEqualToString:@""]) {
                        model.code = [NSString stringWithFormat:@"%@" , dic[@"code"]] ;
                        model.name = [NSString stringWithFormat:@"%@" ,dic[@"name"]] ;
                        model.pid = [NSString stringWithFormat:@"%@" ,dic[@"id"]] ;
                        [kouList addObject:model];

//                    }
                }
            }
            [_goodTableView reloadData];
        }else {
            self.HUD.mode = MBProgressHUDModeText;
            self.HUD.removeFromSuperViewOnHide = YES;
            self.HUD.labelText = @"系统错误";
            [self.HUD hide:YES afterDelay:3];
        }
    }];
    [self closeProgressView];

}

#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [kouList count] ;
}

#pragma mark 返回每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}

#pragma mark返回每行的单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Categorys = @"ChooseArea";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Categorys];
        if (kouList.count > 0){
            ProvinceVo *vo = [kouList objectAtIndex:indexPath.section];
            [cell addSubview:[self chooseAreaView:vo.name]];
        }
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    return cell ;
}

#pragma mark - 代理方法
#pragma mark 重新设置单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 98/2 ;
}


#pragma mark 点击行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ProvinceVo *vo = [kouList objectAtIndex:indexPath.section];
    
    ChooseCityViewController *city = [[ChooseCityViewController alloc] init];
    city.code = vo.code ;
    city.provincename = vo.name ;
    city.isfrom = _isfrom ;
    [self.navigationController pushViewController:city animated:YES];
}

-(UIView *) chooseAreaView :(NSString *) title {
    
    UIView *qiumi = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kScreen_Width, 98/2)];
    qiumi.backgroundColor = [UIColor clearColor] ;

    CGSize qiumiSize = [NSString getStringContentSizeWithFontSize:15 andContent:title] ;
    UILabel *qiumiTxt = [[UILabel alloc] initWithFrame:CGRectMake(15 , (qiumi.height - qiumiSize.height)/2 , qiumiSize.width, qiumiSize.height)] ;
    qiumiTxt.text = title ;
    qiumiTxt.font = [UIFont systemFontOfSize:15] ;
    qiumiTxt.textColor = [UIColor colorWithHexString:@"333333"] ;
    [qiumi addSubview:qiumiTxt];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15 , qiumi.bottom - 1 , kScreen_Width - 30 , 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"f3f3f4"];
    [qiumi addSubview:line];
    
    UIImageView *extend = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"extend"]];
    extend.frame = CGRectMake(kScreen_Width - 15 , (qiumi.height - 14/2)/2, 14/2, 24/2);
    [qiumi addSubview:extend];
    return qiumi ;
}


@end
