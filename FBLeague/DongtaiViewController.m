//
//  DongtaiViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/8.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "DongtaiViewController.h"

@interface DongtaiViewController (){
    NSString *picUrl ;
    NSMutableArray *kouList ;
    NSMutableArray *tmpList ;
    NSString *pageNO ;
    NSString *nextPageNo ;
    NSString *currPage ;
    BOOL isload ;
}

@end

@implementation DongtaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kouList = [[NSMutableArray alloc] init] ;
    tmpList = [[NSMutableArray alloc] init];
    pageNO = @"1" ;
    isload = true ; //标识当前 第一次进来
    
    [self refresh];
    
}

-(void)getFCDataByPage :(NSString *) page {
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:page , @"page" ,uvo.phone ,@"token" , nil];
    NSString *url = apilist ;
    if ([_type isEqualToString:@"2"]) {
        params = [NSDictionary dictionaryWithObjectsAndKeys:page , @"page" , uvo.club , @"clubId" ,uvo.phone ,@"token" , nil];
        url = clubTheme ;
    }else if([_type isEqualToString:@"3"]){
        params = [NSDictionary dictionaryWithObjectsAndKeys:page , @"page" , _phone , @"phone" ,uvo.phone ,@"token" , nil];
        url = userTheme ;
    }else if([_type isEqualToString:@"4"]){
        params = [NSDictionary dictionaryWithObjectsAndKeys:page , @"page" , uvo.phone ,@"phone",uvo.phone ,@"token" , nil];
        url = focusTheme ;
    }else if([_type isEqualToString:@"5"]){
        params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.phone ,@"phone",uvo.phone ,@"token" , nil];
        url = getUnread ;
    }

    [PPNetworkHelper POST:url parameters:params success:^(id object) {
            if([object[@"code"] isEqualToString:@"0000"]){
                if ([object[@"page"] isEqual:[NSNull null]]) {
                    return ;
                }
                NSDictionary *list = object[@"page"][@"list"];
                currPage = [NSString stringWithFormat:@"%@" ,object[@"page"][@"currPage"]];
                NSString *nextPage = object[@"page"][@"nextPage"];
                
                DongtaiVo *model = nil ;
                CommentVo *cmv = nil ;
                [kouList removeAllObjects];
                if(![currPage isEqualToString :pageNO] || isload == true){
                    if (![list isEqual:[NSNull null]]) {
                        for (NSDictionary *dic in list) {
                            model = [DongtaiVo new];
                            model.contents = [NSString stringWithFormat:@"%@" ,dic[@"contents"]] ;
                            model.headpicurl = [NSString stringWithFormat:@"%@" ,dic[@"headpicurl"]] ;
                            model.picurl = [NSString stringWithFormat:@"%@" ,dic[@"picurl"]];
                            model.name = [NSString stringWithFormat:@"%@" ,dic[@"name"]]  ;
                            model.phone =  [NSString stringWithFormat:@"%@" ,dic[@"phone"]]  ;
                            model.pubtime = [NSString stringWithFormat:@"%@" ,dic[@"pubtime"]] ;
                            model.role = [NSString stringWithFormat:@"%@" ,dic[@"role"]]  ;
                            model.did = [NSString stringWithFormat:@"%@" ,dic[@"id"]] ;
                            model.cityName = [NSString stringWithFormat:@"%@" ,dic[@"cityName"]] ;
                            model.name = [NSString stringWithFormat:@"%@" ,dic[@"name"]] ;
                            NSMutableArray *cmlist = [NSMutableArray new] ;
                            for (NSDictionary *cm in dic[@"comments"]) {
                                cmv = [CommentVo new];
                                cmv.cid = cm[@"id"] ;
                                cmv.name = cm[@"name"] ;
                                cmv.phone = cm[@"phone"] ;
                                cmv.picurl = cm[@"picurl"] ;
                                cmv.headpicurl = cm[@"headpicurl"] ;
                                cmv.targetname = cm[@"targetname"] ;
                                cmv.themeid = cm[@"themeid"] ;
                                cmv.targetphone = cm[@"targetphone"] ;
                                cmv.role = cm[@"role"] ;
                                cmv.contents = cm[@"contents"] ;
                                cmv.clubid = cm[@"clubid"] ;
                                cmv.commenttime = cm[@"commenttime"] ;
                                [cmlist addObject:cmv];
                            }
                            model.comments = cmlist ;
                            [kouList addObject:model];
                            
                        }
                        if (currPage.longLongValue == nextPage.longLongValue) {
                            pageNO =  currPage ;
                        }else{
                            pageNO =  nextPage ;
                        }
                        
                        isload = false ;
                        
                        nextPageNo = nextPage ;
                        
                        [self initData];
                    }
                }
                [self endLoadMore];
                [self endRefresh];
            }
        } failure:^(NSError *error) {
    }];
}

-(void)setBackBottmAndTitle{
    UIButton *backViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backViewBtn.frame = CGRectMake(0, 0, 22, 17);
    [backViewBtn setImage:[UIImage imageNamed:@"back2"] forState:UIControlStateNormal];
    [backViewBtn addTarget:self action: @selector(back)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backViewBtn];
    self.navigationItem.leftBarButtonItem = backItem ;
    self.navigationItem.rightBarButtonItem.customView.hidden=YES;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) processData :(NSString *) phone andWithName :(NSString *) name andWithText :(NSString *)text andWithItemId :(NSString *) itemId andWithCommentId :(NSString *) commentId{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    [tmpList removeAllObjects];
    [SVProgressHUD show];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: uvo.phone ,@"token" , nil];
    [PPNetworkHelper POST:getAllThemes parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
            NSDictionary *list = object[@"themes"];
            DongtaiVo *model = nil ;
            CommentVo *cmv = nil ;
            if (![list isEqual:[NSNull null]]) {
                for (NSDictionary *dic in list) {
                    model = [DongtaiVo new];
                    model.did = [NSString stringWithFormat:@"%@" ,dic[@"id"]] ;
                    model.pubtime = [NSString stringWithFormat:@"%@" ,dic[@"pubtime"]] ;
                    model.phone = [NSString stringWithFormat:@"%@" ,dic[@"phone"]] ;
                    model.picurl = [NSString stringWithFormat:@"%@" ,dic[@"picurl"]] ;
                    model.viewscount = [NSString stringWithFormat:@"%@" ,dic[@"viewscount"]] ;
                    model.likescount = [NSString stringWithFormat:@"%@" ,dic[@"likescount"]] ;
                    model.headpicurl = [NSString stringWithFormat:@"%@" ,dic[@"headpicurl"]] ;
                    model.commentscount = [NSString stringWithFormat:@"%@" ,dic[@"commentscount"]] ;
                    model.role = [NSString stringWithFormat:@"%@" ,dic[@"role"]] ;
                    model.contents = [NSString stringWithFormat:@"%@" ,dic[@"contents"]] ;
                    model.clubid = [NSString stringWithFormat:@"%@" ,dic[@"clubid"]] ;
                    model.name = [NSString stringWithFormat:@"%@" ,dic[@"name"]] ;

                    NSMutableArray *cmlist = [NSMutableArray new] ;
                    for (NSDictionary *cm in dic[@"comments"]) {
                            cmv = [CommentVo new];
                            cmv.cid = cm[@"id"] ;
                            cmv.name = cm[@"name"] ;
                            cmv.phone = cm[@"phone"] ;
                            cmv.picurl = cm[@"picurl"] ;
                            cmv.headpicurl = cm[@"headpicurl"] ;
                            cmv.targetname = cm[@"targetname"] ;
                            cmv.themeid = cm[@"themeid"] ;
                            cmv.targetphone = cm[@"targetphone"] ;
                            cmv.role = cm[@"role"] ;
                            cmv.contents = cm[@"contents"] ;
                            cmv.clubid = cm[@"clubid"] ;
                            cmv.commenttime = cm[@"commenttime"] ;
                            [cmlist addObject:cmv];
                    }
                    model.comments = cmlist ;
                    [tmpList addObject:model];
                }
                
                DFLineCommentItem *commentItem = [[DFLineCommentItem alloc] init];
                commentItem.userId = uvo.phone;
                commentItem.userNick = uvo.nickname ;
                commentItem.text = text ;
                for(DongtaiVo *dong in tmpList){
                    for(CommentVo *vo in dong.comments){
                        if([vo.cid isEqualToString:commentId]){
                            commentItem.replyUserId = vo.phone;
                            commentItem.replyUserNick = vo.name ;
                            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: itemId , @"themeid" , uvo.phone , @"phone" , [CommonFunc base64StringFromText:text] , @"contents" ,vo.name , @"targetname" , dong.phone , @"themephone" ,vo.phone ,@"targetphone", uvo.phone , @"token",nil];
                            [PPNetworkHelper POST:apicmsave parameters:params success:^(id object) {
                                commentItem.commentId = object[@"id"] ;
                                [self addCommentItem:commentItem itemId:itemId replyCommentId:commentId];
                                [SVProgressHUD dismiss];

                            } failure:^(NSError *error) {
                            }];
                        }
                    }
                }
            }
        }
    } failure:^(NSError *error) {
    }];
    
}

-(void) initData {
    DFTextImageLineItem *textImageItem = nil ;
    
    for(DongtaiVo *dt in kouList){
        textImageItem = [[DFTextImageLineItem alloc] init];
        textImageItem.itemId = dt.did ;
        textImageItem.userId = dt.phone ;
        textImageItem.userAvatar = dt.headpicurl ;
        textImageItem.userNick = [CommonFunc textFromBase64String:dt.name];
        textImageItem.text = [CommonFunc textFromBase64String:dt.contents];
        
        NSMutableArray *images = nil ;
        if(nil != dt.picurl){
            images = [dt.picurl componentsSeparatedByString:@","];
            if([images count] == 1){
                NSMutableArray *tmp = [[NSMutableArray alloc] initWithArray:images];
                [tmp addObject:@"http://www.baidu.com"];
                textImageItem.srcImages = tmp;
                textImageItem.thumbImages = tmp;
            }else{
                textImageItem.srcImages = images;
                textImageItem.thumbImages = images;
            }
        }
        
        textImageItem.ts = [self timeSwitchTimestamp:dt.pubtime];
        
        DFLineLikeItem *likeItem = nil ;
        DFLineCommentItem *commentItem = nil ;
        if(nil != dt.comments && [dt.comments count]>0){
            for(CommentVo *cvo in dt.comments){
                if([cvo.headpicurl isEqualToString:@"praise"]){ //点赞
                    DFLineLikeItem *likeItem1_1 = [[DFLineLikeItem alloc] init];
                    likeItem1_1.userId = cvo.phone;
                    likeItem1_1.userNick = [CommonFunc textFromBase64String:cvo.name];
                    [textImageItem.likes addObject:likeItem1_1];
                    
                }else{
                    DFLineCommentItem *commentItem1_1 = [[DFLineCommentItem alloc] init];
                    commentItem1_1.commentId = cvo.cid;
                    commentItem1_1.userId =  cvo.phone;
                    commentItem1_1.userNick =  [CommonFunc textFromBase64String:cvo.name] ;
                    commentItem1_1.text = [CommonFunc textFromBase64String:cvo.contents];
                    
                    if(![cvo.targetname isEqual:[NSNull null]]) {
                        commentItem1_1.replyUserId = cvo.phone;
                        commentItem1_1.replyUserNick = [CommonFunc textFromBase64String:cvo.targetname] ;
                    }
                    [textImageItem.comments addObject:commentItem1_1];
                }
            }
        }
        [self addItem:textImageItem];        
    }
}

-(NSInteger)timeSwitchTimestamp:(NSString *)formatTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime];
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp * 1000;
}

-(void)onCommentCreate:(NSString *)commentId text:(NSString *)text itemId:(NSString *) itemId
{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];

    if (commentId == nil) { //直接点击评论
        DFLineCommentItem *commentItem = [[DFLineCommentItem alloc] init];
        commentItem.userId = uvo.phone;
        commentItem.userNick = uvo.nickname ;
        commentItem.text = text ;
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: itemId , @"themeid" , uvo.phone , @"phone" , [CommonFunc base64StringFromText:text] , @"contents" , uvo.phone , @"token",nil];
        [PPNetworkHelper POST:apicmsave parameters:params success:^(id object) {
            commentItem.commentId = object[@"id"] ;
            [self addCommentItem:commentItem itemId:itemId replyCommentId:commentId];
        } failure:^(NSError *error) {
        }];
    }else{ //点击别人的评论
        //通过当前commentId 去找相应的评论人
        [self processData :uvo.phone andWithName:uvo.nickname andWithText:text andWithItemId:itemId andWithCommentId:commentId];
        
    }
}

-(void)onLike:(NSString *)itemId
{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    //自己点赞屏蔽
    BOOL isMe = false ;
    for(DongtaiVo *dt in kouList){
        if ([dt.did isEqualToString:itemId]) {
            if ([dt.phone isEqualToString:uvo.phone]) {
                isMe = true ;
                return ;
            }
        }
    }
    
    DFLineLikeItem *likeItem = [[DFLineLikeItem alloc] init];
    likeItem.userId = uvo.phone;
    likeItem.userNick = uvo.nickname;
    [self addLikeItem:likeItem itemId:itemId];
        
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys: itemId , @"themeid" , uvo.phone , @"phone" , @"praise" ,@"headpicurl", uvo.phone , @"token" , nil];
    [PPNetworkHelper POST:apicmsave parameters:params success:^(id object) {
        if([object[@"code"] isEqualToString:@"0000"]){
        }
    } failure:^(NSError *error) {
    }];
}


-(void)onClickUser:(NSUInteger)userId
{
    //点击左边头像 或者 点击评论和赞的用户昵称
    NSLog(@"onClickUser: %ld", userId);
    
}


-(void)onClickHeaderUserAvatar
{
    [self onClickUser:1111];
}



-(void) refresh
{
    [self getFCDataByPage:pageNO];
    
}



-(void) loadMore
{
    [self getFCDataByPage:pageNO];
    
}

#pragma mark - 发送图文消息
- (void) onFCTextImage:(NSString *) text images:(NSArray *)images{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];

    DFTextImageLineItem *textImageItem = [[DFTextImageLineItem alloc] init];
    textImageItem.itemId = [NSString stringWithFormat:@"%f" , [[NSDate date] timeIntervalSince1970]*1000] ; //随便设置一个 待服务器生成
    textImageItem.userId = uvo.phone ;
    
    NSString *nickname = uvo.nickname ;
    textImageItem.userAvatar = uvo.headpicurl;
    textImageItem.userNick = nickname ;
    textImageItem.title = @"";
    textImageItem.text = text;
    textImageItem.ts = [[NSDate date] timeIntervalSince1970]*1000;
    
    NSMutableArray *srcImages = [NSMutableArray array];
    textImageItem.srcImages = srcImages; //大图 可以是本地路径 也可以是网络地址 会自动判断
    
    NSMutableArray *thumbImages = [NSMutableArray array];
    textImageItem.thumbImages = thumbImages; //小图 可以是本地路径 也可以是网络地址 会自动判断
    
    for (id img in images) {
        [srcImages addObject:img];
        [thumbImages addObject:img];
    }
    [self addItemTop:textImageItem];
    
    NSMutableArray *picUrls = [NSMutableArray array];
    //接着上传图片 和 请求服务器接口
    for (id image in images){
        NSData *datas = UIImageJPEGRepresentation(image, 0.4);
        NSString *_encodedImageStr = [datas base64Encoding];
        [picUrls addObject:_encodedImageStr];
    }
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ([srcImages count]>0) {
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:picUrls , @"files" , nil];
        [PPNetworkHelper POST:uploadPics parameters:params success:^(id object) {
            if([object[@"code"] isEqualToString:@"0000"]){
                NSArray *urls = object[@"URLS"] ;
                NSString *pl = [urls componentsJoinedByString:@","];
                
                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone , @"phone" , [CommonFunc base64StringFromText:text] , @"contents" ,uvo.phone ,@"token" , pl ,  @"picurl" , nil];
                [PPNetworkHelper POST:apisave parameters:params success:^(id object){                                               if([object[@"code"] isEqualToString:@"0000"]){
                        HUD.mode = MBProgressHUDModeText;
                        HUD.removeFromSuperViewOnHide = YES;
                        HUD.labelText = @"发布成功";
                        [HUD hide:YES afterDelay:2];
                    }
                } failure:^(NSError *error) {
                }];
            }
        } failure:^(NSError *error) {
        }];

    }else{
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone , @"phone" , text , @"contents" ,uvo.phone ,@"token" , nil];
        [PPNetworkHelper POST:apisave parameters:params success:^(id object) {
            if([object[@"code"] isEqualToString:@"0000"]){
                
            }
        } failure:^(NSError *error) {
        }];
    }

}
@end
