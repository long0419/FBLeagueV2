//
//  UnReadViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/10/19.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "UnReadViewController.h"

@interface UnReadViewController (){
    DongtaiViewController *dongtai ;
    DongtaiViewController *dongtai2 ;
    JiaoLianViewController *jiaolian ;
}

@end

@implementation UnReadViewController

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forward:) name:@"forwardQiuDetail" object:nil];
    self.navigationItem.rightBarButtonItem.customView.hidden=YES;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"@我" ;
    [self setBackBottmAndTitle];
    
    dongtai = [DongtaiViewController new] ;
    dongtai.type = @"5" ;
    dongtai.height = self.view.frame.size.height - 20 - 44  ;
    
    dongtai2 = [DongtaiViewController new] ;
    dongtai2.type = @"4" ;
    dongtai2.height = self.view.frame.size.height - 20 - 44  ;
    
    NSArray *viewControllers = @[
                                 @{@"@我的":dongtai},
                                 @{@"已关注":dongtai2}];
    
    YCSlideView * view = [[YCSlideView alloc] initWithFrame:CGRectMake(0, 20 + 44, kScreen_Width, kScreen_Height - 20 - 44) WithViewControllers:viewControllers] ;
    [self.view addSubview:view];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"forwardQiuDetail" object:nil];
}


-(void)setBackBottmAndTitle{
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 22, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(back)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)goAction{
    self.hidesBottomBarWhenPushed=YES;
    SearchJiaoLianViewController *search = [SearchJiaoLianViewController new] ;
    [self.navigationController pushViewController:search animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

-(void) getScrollIndex :(NSInteger) index {
    
    
}

-(void)handleSingleTap{
    
}


#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    NSLog(@"%@", photos);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        DFImagesSendViewController *controller = [[DFImagesSendViewController alloc] initWithImages:photos];
        controller.delegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:YES completion:nil];
    });
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
}


#pragma mark - 发送朋友圈结果
-(void) onSendTextImage:(NSString *) text images:(NSArray *)images{
    [dongtai onFCTextImage:text images:images];
}

-(void)forward : (NSNotification *) notification {
    UserDataVo *vo = [notification object];
    self.hidesBottomBarWhenPushed=YES;
    
    MemberViewController *mem = [MemberViewController new] ;
    mem.userVo = vo ;
    [self.navigationController pushViewController:mem animated:YES];
    
    self.hidesBottomBarWhenPushed=NO;
    
}

@end
