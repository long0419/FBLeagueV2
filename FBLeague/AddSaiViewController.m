//
//  AddSaiViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/9/6.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "AddSaiViewController.h"
#import "DSLLoginTextField.h"
#import "ChooseAreaViewController.h"
#import "RadioButton.h"

@interface AddSaiViewController (){
    DSLLoginTextField *psw ;
}

@end

@implementation AddSaiViewController

-(void)viewDidAppear:(BOOL)animated{
    if (_areaStr != nil && ![@"" isEqualToString:_areaStr] && psw != nil) {
        ((UITextField *)psw).text = _areaStr ;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联赛报名";
//    self.view.backgroundColor = [UIColor colorWithHexString:@"323c45"];

    [self setBackBottmAndTitle];
    
    [self setRightBottom];
    
    psw=[[DSLLoginTextField alloc]init];
    psw.frame = CGRectMake(30 , 20 + 44 + 52/2 , kScreen_Width - 60 , 40);
    psw.clearButtonMode=UITextFieldViewModeWhileEditing;
    psw.placeholderColor=[UIColor colorWithHexString:@"000000"];
    psw.textColor = [UIColor blackColor] ;
    psw.font=[UIFont systemFontOfSize:14];
    psw.placeholder=@"选择地区";
    psw.maxTextLength= 11;
    psw.delegate = self ;
    psw.tag = 10 ;
    psw.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:psw];
    
    QMUILabel *label3 = [[QMUILabel alloc] init];
    label3.text = @"选择组别";
    label3.font = UIFontMake(12);
    label3.textColor = UIColorBlack ;
    [label3 sizeToFit];
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(psw.mas_bottom).with.offset(20);
    }];

    
    NSMutableArray* buttons = [NSMutableArray arrayWithCapacity:2];
    RadioButton* btn = [[RadioButton alloc] init];
    [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btn setTitle:@"女" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btn];
    
    RadioButton* btn2 = [[RadioButton alloc] init];
    [btn2 addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btn2 setTitle:@"男" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn2 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn2.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btn2];
    
    [buttons addObject:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(label3.mas_bottom).with.offset(15);
        make.width.mas_equalTo(100);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(psw);
        make.top.mas_equalTo(label3.mas_bottom).with.offset(15);
        make.width.mas_equalTo(30);
    }];
    [buttons addObject:btn2];
    
    [buttons[0] setGroupButtons:buttons];
    [buttons[0] setSelected:YES];

    QMUILabel *label13 = [[QMUILabel alloc] init];
    label13.text = @"选择赛制";
    label13.font = UIFontMake(12);
    label13.textColor = UIColorBlack ;
    [label13 sizeToFit];
    [self.view addSubview:label13];
    [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(btn2.mas_bottom).with.offset(20);
    }];

    
    NSMutableArray* buttons2 = [NSMutableArray arrayWithCapacity:3];
    RadioButton* btnx = [[RadioButton alloc] init];
    [btnx addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btnx setTitle:@"教练" forState:UIControlStateNormal];
    [btnx setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnx.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnx setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btnx setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btnx.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnx.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btnx];
    [buttons2 addObject:btnx];
    
    RadioButton* btnx2 = [[RadioButton alloc] init];
    [btnx2 addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btnx2 setTitle:@"球员" forState:UIControlStateNormal];
    [btnx2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnx2.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnx2 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btnx2 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btnx2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnx2.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btnx2];
    [buttons2 addObject:btnx2];
    
    RadioButton* btnx3 = [[RadioButton alloc] init];
    [btnx3 addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
    [btnx3 setTitle:@"球迷" forState:UIControlStateNormal];
    [btnx3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnx3.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnx3 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [btnx3 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    btnx3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btnx3.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    [self.view addSubview:btnx3];
    [buttons2 addObject:btnx3];
    
    [btnx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(label13.mas_bottom).with.offset(10);
        make.width.mas_equalTo(100);
    }];
    
    [btnx2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(label13.mas_bottom).with.offset(10);
        make.width.mas_equalTo(44);
    }];
    
    [btnx3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(psw);
        make.top.mas_equalTo(label13.mas_bottom).with.offset(10);
        make.width.mas_equalTo(44);
    }];
    [buttons2[0] setGroupButtons:buttons2];
    [buttons2[0] setSelected:YES];
    
    
    QMUILabel *label14 = [[QMUILabel alloc] init];
    label14.text = @"报名费";
    label14.font = UIFontMake(12);
    label14.textColor = UIColorBlack ;
    [label14 sizeToFit];
    [self.view addSubview:label14];
    [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(btnx3.mas_bottom).with.offset(20);
    }];
    
    DSLLoginTextField *money1=[[DSLLoginTextField alloc]init];
//    money1.frame = CGRectMake(30 , 20 + label14.bottom , kScreen_Width - 60 , 40);
    money1.clearButtonMode=UITextFieldViewModeWhileEditing;
    money1.placeholderColor=[UIColor colorWithHexString:@"000000"];
    money1.textColor = [UIColor blackColor] ;
    money1.font=[UIFont systemFontOfSize:14];
    money1.placeholder=@"550元";
    money1.maxTextLength= 11;
    money1.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:money1];
    [money1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label14.mas_bottom).with.offset(20);
        make.width.mas_equalTo(kScreen_Width - 60) ;
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(30) ;
    }];

    QMUILabel *label15 = [[QMUILabel alloc] init];
    label15.text = @"比赛押金";
    label15.font = UIFontMake(12);
    label15.textColor = UIColorBlack ;
    [label15 sizeToFit];
    [self.view addSubview:label15];
    [label15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(money1.mas_bottom).with.offset(20);
    }];

    
    DSLLoginTextField *money12=[[DSLLoginTextField alloc]init];
    money12.frame = CGRectMake(30 , 20 + label15.bottom , kScreen_Width - 60 , 40);
    money12.clearButtonMode=UITextFieldViewModeWhileEditing;
    money12.placeholderColor=[UIColor colorWithHexString:@"000000"];
    money12.textColor = [UIColor blackColor] ;
    money12.font=[UIFont systemFontOfSize:14];
    money12.placeholder=@"1000元";
    money12.maxTextLength= 11;
    //    money1.delegate = self ;
    //    money1.tag = 10 ;
    money12.textAlignment = NSTextAlignmentCenter ;
    [self.view addSubview:money12];
    [money12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label15.mas_bottom).with.offset(20);
        make.width.mas_equalTo(kScreen_Width - 60) ;
        make.height.mas_equalTo(40);
        make.left.mas_equalTo(30) ;
    }];
    
    QMUILabel *label16 = [[QMUILabel alloc] init];
    label16.text = @"请选择支付方式";
    label16.font = UIFontMake(12);
    label16.textColor = UIColorBlack ;
    [label16 sizeToFit];
    [self.view addSubview:label16];
    [label16 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psw);
        make.top.mas_equalTo(money12.mas_bottom).with.offset(20);
    }];
    
    

}

-(void) onRadioButtonValueChanged:(RadioButton*)sender
{
    NSString *text = sender.titleLabel.text ;
    if(sender.selected) {
        NSLog(@"Selected color: %@", sender.titleLabel.text);

    }
}

- (void)setRightBottom {
    CGSize size = [NSString getStringContentSizeWithFontSize:15 andContent:@"分享"] ;
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    sender.frame = CGRectMake(0, 0, size.width , size.height);
    [sender setTitle:@"分享" forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize: 15];
    [sender setTitleColor:[UIColor colorWithHexString:@"ffffff"]forState:UIControlStateNormal];
    [sender addTarget:self action: @selector(share)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:sender];
    self.navigationItem.rightBarButtonItem = backItem ;
}


-(void)setBackBottmAndTitle{
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 17, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(back)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField*)textField

{
    [textField resignFirstResponder];
    
    if(textField.tag == 10){
        self.hidesBottomBarWhenPushed = YES ;
        ChooseAreaViewController *area = [[ChooseAreaViewController alloc] init];
        area.isfrom = @"2" ;
        [self.navigationController pushViewController:area animated:YES];
        self.hidesBottomBarWhenPushed = NO ;
    }
}


@end
