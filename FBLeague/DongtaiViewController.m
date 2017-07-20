//
//  DongtaiViewController.m
//  FBLeague
//
//  Created by long-laptop on 2017/7/8.
//  Copyright © 2017年 long-laptop. All rights reserved.
//

#import "DongtaiViewController.h"

@interface DongtaiViewController (){
    DongtaiViewController *dongtai ;
    NSString *picUrl ;
}

@end

@implementation DongtaiViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
}

-(void) initData
{
    DFTextImageLineItem *textImageItem = [[DFTextImageLineItem alloc] init];
    textImageItem.itemId = 1;
    textImageItem.userId = 10086;
    textImageItem.userAvatar = @"http://file-cdn.datafans.net/avatar/1.jpeg";
    textImageItem.userNick = @"Allen";
    textImageItem.title = @"";
    textImageItem.text = @"你是我的小苹果 小苹果 我爱你 就像老鼠爱大米 18680551720 [亲亲]";
    
    NSMutableArray *srcImages = [NSMutableArray array];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/11.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/12.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/13.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/14.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/15.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/16.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/17.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/18.jpg"];
    [srcImages addObject:@"http://file-cdn.datafans.net/temp/19.jpg"];
    
    
    
    textImageItem.srcImages = srcImages;
    
    
    NSMutableArray *thumbImages = [NSMutableArray array];
    [thumbImages addObject:@"http://file-cdn.datafans.net/temp/11.jpg_160x160.jpeg"];
    [thumbImages addObject:@"http://file-cdn.datafans.net/temp/12.jpg_160x160.jpeg"];
    [thumbImages addObject:@"http://file-cdn.datafans.net/temp/13.jpg_160x160.jpeg"];
    [thumbImages addObject:@"http://file-cdn.datafans.net/temp/14.jpg_160x160.jpeg"];
    [thumbImages addObject:@"http://file-cdn.datafans.net/temp/15.jpg_160x160.jpeg"];
    [thumbImages addObject:@"http://file-cdn.datafans.net/temp/16.jpg_160x160.jpeg"];
    [thumbImages addObject:@"http://file-cdn.datafans.net/temp/17.jpg_160x160.jpeg"];
    [thumbImages addObject:@"http://file-cdn.datafans.net/temp/18.jpg_160x160.jpeg"];
    [thumbImages addObject:@"http://file-cdn.datafans.net/temp/19.jpg_160x160.jpeg"];
    textImageItem.thumbImages = thumbImages;
    
    
    NSMutableArray *thumbPreviewImages = [NSMutableArray array];
    [thumbPreviewImages addObject:@"http://file-cdn.datafans.net/temp/11.jpg_600x600.jpeg"];
    [thumbPreviewImages addObject:@"http://file-cdn.datafans.net/temp/12.jpg_600x600.jpeg"];
    [thumbPreviewImages addObject:@"http://file-cdn.datafans.net/temp/13.jpg_600x600.jpeg"];
    [thumbPreviewImages addObject:@"http://file-cdn.datafans.net/temp/14.jpg_600x600.jpeg"];
    [thumbPreviewImages addObject:@"http://file-cdn.datafans.net/temp/15.jpg_600x600.jpeg"];
    [thumbPreviewImages addObject:@"http://file-cdn.datafans.net/temp/16.jpg_600x600.jpeg"];
    [thumbPreviewImages addObject:@"http://file-cdn.datafans.net/temp/17.jpg_600x600.jpeg"];
    [thumbPreviewImages addObject:@"http://file-cdn.datafans.net/temp/18.jpg_600x600.jpeg"];
    [thumbPreviewImages addObject:@"http://file-cdn.datafans.net/temp/19.jpg_600x600.jpeg"];
//    textImageItem.thumbPreviewImages = thumbPreviewImages;
    
    
    textImageItem.location = @"中国 • 广州";
    textImageItem.ts = [[NSDate date] timeIntervalSince1970]*1000;
    
    
    DFLineLikeItem *likeItem1_1 = [[DFLineLikeItem alloc] init];
    likeItem1_1.userId = 10086;
    likeItem1_1.userNick = @"Allen";
    [textImageItem.likes addObject:likeItem1_1];
    
    
    DFLineLikeItem *likeItem1_2 = [[DFLineLikeItem alloc] init];
    likeItem1_2.userId = 10088;
    likeItem1_2.userNick = @"奥巴马";
    [textImageItem.likes addObject:likeItem1_2];
    
    
    
    DFLineCommentItem *commentItem1_1 = [[DFLineCommentItem alloc] init];
    commentItem1_1.commentId = 10001;
    commentItem1_1.userId = 10086;
    commentItem1_1.userNick = @"习大大";
    commentItem1_1.text = @"精彩 大家鼓掌";
    [textImageItem.comments addObject:commentItem1_1];
    
    
    DFLineCommentItem *commentItem1_2 = [[DFLineCommentItem alloc] init];
    commentItem1_2.commentId = 10002;
    commentItem1_2.userId = 10088;
    commentItem1_2.userNick = @"奥巴马";
    commentItem1_2.text = @"欢迎来到美利坚";
    commentItem1_2.replyUserId = 10086;
    commentItem1_2.replyUserNick = @"习大大";
    [textImageItem.comments addObject:commentItem1_2];
    
    
    DFLineCommentItem *commentItem1_3 = [[DFLineCommentItem alloc] init];
    commentItem1_3.commentId = 10003;
    commentItem1_3.userId = 10010;
    commentItem1_3.userNick = @"神雕侠侣";
    commentItem1_3.text = @"呵呵";
    [textImageItem.comments addObject:commentItem1_3];
    
    [self addItem:textImageItem];
    
    
}



-(void)onCommentCreate:(long long)commentId text:(NSString *)text itemId:(long long) itemId
{
    DFLineCommentItem *commentItem = [[DFLineCommentItem alloc] init];
    commentItem.commentId = [[NSDate date] timeIntervalSince1970];
    commentItem.userId = 10098;
    commentItem.userNick = @"金三胖";
    commentItem.text = text;
    [self addCommentItem:commentItem itemId:itemId replyCommentId:commentId];
    
}


-(void)onLike:(long long)itemId
{
    //点赞
    NSLog(@"onLike: %lld", itemId);
    
    DFLineLikeItem *likeItem = [[DFLineLikeItem alloc] init];
    likeItem.userId = 10092;
    likeItem.userNick = @"琅琊榜";
    [self addLikeItem:likeItem itemId:itemId];
    
    
    
    
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
    //下来刷新
    //模拟网络请求
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self endRefresh];
    });
}



-(void) loadMore
{
    //加载更多
    //模拟网络请求
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        DFTextImageLineItem *textImageItem = [[DFTextImageLineItem alloc] init];
        textImageItem.itemId = 3;
        textImageItem.userId = 10018;
        textImageItem.userAvatar = @"http://file-cdn.datafans.net/avatar/1.jpeg";
        textImageItem.userNick = @"富二代";
        textImageItem.title = @"发表了";
        textImageItem.text = @"你才是富二代";
        
        
        NSMutableArray *srcImages3 = [NSMutableArray array];
        [srcImages3 addObject:@"http://file-cdn.datafans.net/temp/11.jpg"];
        textImageItem.srcImages = srcImages3;
        
        
        NSMutableArray *thumbImages3 = [NSMutableArray array];
        [thumbImages3 addObject:@"http://file-cdn.datafans.net/temp/11.jpg_640x420.jpeg"];
        textImageItem.thumbImages = thumbImages3;
        
        
        NSMutableArray *thumbPreviewImages3 = [NSMutableArray array];
        [thumbPreviewImages3 addObject:@"http://file-cdn.datafans.net/temp/11.jpg_600x600.jpeg"];
//        textImageItem.thumbPreviewImages = thumbPreviewImages3;
        
        
        textImageItem.width = 640;
        textImageItem.height = 360;
        
        //        textImageItem.location = @"广州信息港";
        [self addItem:textImageItem];
        
        [self endLoadMore];
    });
}



#pragma mark - 发送图文消息
- (void) onFCTextImage:(NSString *) text images:(NSArray *)images{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];

    DFTextImageLineItem *textImageItem = [[DFTextImageLineItem alloc] init];
    textImageItem.itemId = 10000000; //随便设置一个 待服务器生成
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
//    textImageItem.location = @"广州信息港";
    [self addItemTop:textImageItem];
    
    NSMutableArray *picUrls = [NSMutableArray array];
    //接着上传图片 和 请求服务器接口
    for (id image in images){
        NSData *datas = UIImageJPEGRepresentation(image, 0.4);
        NSString *_encodedImageStr = [datas base64Encoding];
        [picUrls addObject:_encodedImageStr];
    }
    
    if ([srcImages count]>0) {
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:picUrls , @"files" , nil];
        [PPNetworkHelper POST:uploadPics parameters:params success:^(id object) {
            if([object[@"code"] isEqualToString:@"0000"]){
                NSString *url = object[@"URL"] ;
                
                //            params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone , @"phone" , text , @"contents" ,uvo.phone ,@"token" , picUrl ,  @"picurl" , nil];
                //                [PPNetworkHelper POST:apisave parameters:params success:^(id object) {
                //                    if([object[@"code"] isEqualToString:@"0000"]){
                //
                //
                //                    }
                //                } failure:^(NSError *error) {
                //                }];
                
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
