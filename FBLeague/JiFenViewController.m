//
//  JiFenViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/2.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "JiFenViewController.h"
#import "JiFenVo.h"

@interface JiFenViewController (){
    YYCache *cache ;
    UserDataVo *uvo ;
    NSMutableArray *kouList ;
    NSArray *titles ;
}

@end

@implementation JiFenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    titles = [NSArray arrayWithObjects: @"球队" ,@"赛" ,@"胜" , @"平" ,@"负" ,@"进" ,@"失" ,@"积" , nil] ;
    kouList = [[NSMutableArray alloc] init];
    
    [self getNeedDatas];
    

}

-(void) getNeedDatas {
    cache = [YYCache cacheWithName:@"FB"];
    uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.club , @"clubId" , _leagueId , @"leagueId" , uvo.phone ,  @"token", nil];
    [PPNetworkHelper POST:getJoinins parameters:params success:^(id data) {
        if([data[@"code"] isEqualToString:@"0000"]){
            NSDictionary *list = data[@"joinin"];
            JiFenVo *model = nil ;
            
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *dic in list) {
                    model = [JiFenVo new];
                    model.clubname = [NSString stringWithFormat:@"%@" , [CommonFunc textFromBase64String:dic[@"clubname"]]] ;
                    model.jid = [NSString stringWithFormat:@"%@" , dic[@"id"]] ;
                    model.paymentorder = [NSString stringWithFormat:@"%@" , dic[@"paymentorder"]] ;
                    model.eva = [NSString stringWithFormat:@"%@" , dic[@"eva"]] ;
                    model.matchname = [NSString stringWithFormat:@"%@" , dic[@"matchname"]] ;
                    model.leagueid = [NSString stringWithFormat:@"%@" , dic[@"leagueid"]] ;
                    model.fumblecount = [NSString stringWithFormat:@"%@" , dic[@"fumblecount"]] ;
                    model.playedcount = [NSString stringWithFormat:@"%@" , dic[@"playedcount"]] ;
                    model.lostcount = [NSString stringWithFormat:@"%@" , dic[@"lostcount"]] ;
                    model.paymenttype = [NSString stringWithFormat:@"%@" , dic[@"paymenttype"]] ;
                    model.integral = [NSString stringWithFormat:@"%@" , dic[@"integral"]] ;
                    model.lostcount = [NSString stringWithFormat:@"%@" , dic[@"lostcount"]] ;
                    model.tiedcount = [NSString stringWithFormat:@"%@" , dic[@"tiedcount"]] ;
                    model.woncount = [NSString stringWithFormat:@"%@" , dic[@"woncount"]] ;
                    model.matchid = [NSString stringWithFormat:@"%@" , dic[@"matchid"]] ;
                    model.goalcount = [NSString stringWithFormat:@"%@" , dic[@"goalcount"]] ;
                    model.clubid = [NSString stringWithFormat:@"%@" , dic[@"clubid"]] ;
                    
                    [kouList addObject:@[
                                         model.clubname ,
                                         model.playedcount,
                                         model.woncount,
                                         model.lostcount,
                                         model.tiedcount,
                                         model.goalcount,
                                         model.fumblecount,
                                         model.integral
                                         ]];
                }
            }
            
            ZRGridViewLayoutAndStyle *gridViewLayout = [[ZRGridViewLayoutAndStyle alloc] init];
            gridViewLayout.showGridLine = YES;
            gridViewLayout.headerBackgroudColor = [UIColor colorWithHexString:@"3a444e"];
            gridViewLayout.fieldTitleColor = [UIColor whiteColor];
            
            ZRGridView *gridView = [[ZRGridView alloc] initWithFrame:CGRectMake(0 , 0 ,kScreen_Width , kScreen_Height - 200) gridViewLayoutAndStyle:gridViewLayout];
            gridView.gridViewDelegate = self;
            gridView.gridViewDataSource = self;
            [self.view addSubview:gridView];

        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - ZRGridViewDataSource

- (NSInteger)numberOfColumnsInGridView:(ZRGridView *)gridView{
    return 8;
}

- (NSInteger)numberOfRowsInGridView:(ZRGridView *)gridView{
    return [kouList count];
}

- (NSString *)gridView:(ZRGridView *)gridView titleOfColumnsAtIndex:(NSInteger)index{
    return [titles objectAtIndex:index];
}

- (NSString *)gridView:(ZRGridView *)gridView valueAtRow:(NSInteger)rowIndex column:(NSInteger)columnIndex{
    
    NSArray *data = [kouList objectAtIndex:rowIndex];
    NSString *value = [data objectAtIndex:columnIndex];
    return value ;
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
        return kScreen_Width - 30*7 ;
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
