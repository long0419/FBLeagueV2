/**
 @@create by 刘智援 2016-11-28
 
 @简书地址:    http://www.jianshu.com/users/0714484ea84f/latest_articles
 @Github地址: https://github.com/lyoniOS
 @return WXApiManager（微信结果回调类）
 */

#import "WXApiManager.h"
#import "WXApi.h"

@implementation WXApiManager

#pragma mark - 单粒

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

#pragma mark - WXApiDelegate

- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg;
    
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }else{
        SendAuthResp * resp1 = (SendAuthResp *)resp;

        NSString * grantStr =@"grant_type=authorization_code";
        
        NSString * tokenUrl =@"https://api.weixin.qq.com/sns/oauth2/access_token?";
        
        NSString * tokenUrl1 = [tokenUrl stringByAppendingString:[NSString stringWithFormat:@"appid=%@&",MXWechatAPPID]];
        
        NSString * tokenUrl2 = [tokenUrl1 stringByAppendingString:[NSString stringWithFormat:@"secret=%@&",AppSecret]];
        
        NSString * tokenUrl3 = [tokenUrl2 stringByAppendingString:[NSString stringWithFormat:@"code=%@&",resp1.code]];
        
        NSString * tokenUrlend = [tokenUrl3 stringByAppendingString:grantStr];

        
    [PPNetworkHelper POST:tokenUrlend parameters:nil success:^(id data) {
        NSString * userfulStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@" , data[@"access_token"] , data[@"openid"]];
        [PPNetworkHelper POST:userfulStr parameters:nil success:^(id data) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"showRegisterView" object:data];
        } failure:^(NSError *error) {
        }];
    } failure:^(NSError *error) {
            
    }];


    }
}


@end
