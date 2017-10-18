//
//  LianmengViewController.m
//  league
//
//  Created by long-laptop on 2016/11/7.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import "LianmengViewController.h"
#import "YCSlideView.h"
#import "FocusViewController.h"
#import "JiaoLianViewController.h"
#import "DongtaiViewController.h"
#import "UserDataVo.h"
#import "CommonFunc.h"
#import "SearchJiaoLianViewController.h"

@interface LianmengViewController (){
    DongtaiViewController *dongtai ;
    DongtaiViewController *dongtai2 ;
    FocusViewController *focus ;
    JiaoLianViewController *jiaolian ;
}

@end

@implementation LianmengViewController

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forward:) name:@"forwardQiuDetail" object:nil];

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"动态" ;
    [self setBackBottmAndTitle];
    [self setRightBottom];
    
    dongtai = [DongtaiViewController new] ;
    dongtai.type = @"1" ;
    dongtai.height = self.view.frame.size.height - 20 - 44 - 98/2 - 36 - 10 ;
    
    dongtai2 = [DongtaiViewController new] ;
    dongtai2.type = @"4" ;
    dongtai2.height = self.view.frame.size.height - 20 - 44 - 98/2 - 36 - 10 ;
    
    jiaolian = [JiaoLianViewController new] ;

    NSArray *viewControllers = @[
                @{@"全部动态":dongtai},
                @{@"已关注":dongtai2},
                @{@"教练员列表":jiaolian}];
    
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
    [backViewBtn setImage:[UIImage imageNamed:@"相机2"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(sendfc:)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
}

-(void) sendfc : (id) sender{
    MMPopupItemHandler block = ^(NSInteger index){
        switch (index) {
            case 0:
                [self takePhoto];
                break;
            case 1:
                [self pickFromAlbum];
                break;
            default:
                break;
        }
    };
    
    NSArray *items = @[
                       MMItemMake(@"拍照", MMItemTypeNormal, block),
                       MMItemMake(@"从相册选取", MMItemTypeNormal, block)];
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:@"" items:items];
    
    [sheetView show];

}

-(void) takePhoto
{
    _pickerController = [[UIImagePickerController alloc] init];
    _pickerController.delegate = self;
    _pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_pickerController animated:YES completion:nil];
}

-(void) pickFromAlbum
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}


- (void)setRightBottom {
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 17, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(goAction)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.rightBarButtonItem = backItem ;
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

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    DFImagesSendViewController *controller = [[DFImagesSendViewController alloc] initWithImages:@[image]];
    controller.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navController animated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
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
