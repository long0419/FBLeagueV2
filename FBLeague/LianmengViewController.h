//
//  LianmengViewController.h
//  league
//
//  Created by long-laptop on 2016/11/7.
//  Copyright © 2016年 long-laptop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCSlideView.h"
#import "TZImagePickerController.h"
#import "DFImagesSendViewController.h"
#import "JiaoLianViewController.h"
#import "SearchJiaoLianViewController.h"


@interface LianmengViewController : QMUICommonViewController<UIScrollViewDelegate,UIViewControllerPreviewingDelegate ,UINavigationControllerDelegate, UIImagePickerControllerDelegate ,TZImagePickerControllerDelegate , DFImagesSendViewControllerDelegate ,goToJiaoLianDetail>

@property (nonatomic, strong) UIImagePickerController *pickerController;

@end
