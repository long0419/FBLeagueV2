/**
 @@create by 刘智援 2016-11-28
 
 @简书地址:    http://www.jianshu.com/users/0714484ea84f/latest_articles
 @Github地址: https://github.com/lyoniOS
 @return MXWechatPayHandler（微信调用工具类）
 */

#import "MXWechatPayHandler.h"
#if __has_include(<AFNetworking/AFNetworking.h>)
#import <AFNetworking/AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#else
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#endif
///用户获取设备ip地址
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "MXWechatSignAdaptor.h"
#import "XMLDictionary.h"
#import "WXApi.h"
#import "MXWechatSignAdaptor.h"
#import "UserDataVo.h"

@implementation MXWechatPayHandler

#pragma mark - Public Methods

+ (void)jumpToWxPay :(NSString *) money andWithTitle :(NSString *) title
{
    
    [self generateTradeNO:money andWithTitle:title];
    
}

#pragma mark - Private Method
/**
 ------------------------------
 产生随机字符串
 ------------------------------
 1.生成随机数算法 ,随机字符串，不长于32位
 2.微信支付API接口协议中包含字段nonce_str，主要保证签名不可预测。
 3.我们推荐生成随机数算法如下：调用随机数函数生成，将得到的值转换为字符串。
 */
+ (void)generateTradeNO :(NSString *)money andWithTitle :(NSString *)title
{
    YYCache *cache = [YYCache cacheWithName:@"FB"];
    UserDataVo *uvo = [cache objectForKey:@"userData"];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uvo.phone ,  @"token", nil];

    [PPNetworkHelper POST:getRandomId parameters:params success:^(id object) {
        
        NSString *tradeType = @"APP";                                       //交易类型
        NSString *totalFee  = money ;//交易价格1表示0.01元，10表示0.1元
        NSString *tradeNO   = [self generateTradeNO];                       //随机字符串变量 这里最好使用和安卓端一致的生成逻辑
        NSString *addressIP = [self fetchIPAddress];                        //设备IP地址,请再wifi环境下测试,否则获取的ip地址为error,正确格式应该是8.8.8.8
        if (addressIP == nil || [@"error" isEqualToString:addressIP]) {
            addressIP = @"192.168.1.1" ;
        }
        NSString *orderNo   = [NSString stringWithFormat:@"%ld",time(0)];   //随机产生订单号用于测试，正式使用请换成你从自己服务器获取的订单号
        
        NSString *notifyUrl = wxPayNotify ;// 交易结果通知网站此处用于测试，随意填写，正式使用时填写正确网站
        if ([@"课程费用" isEqualToString : title]) {
            notifyUrl = wxPayForCourseNotify ;
        }
        
        //获取SIGN签名
        MXWechatSignAdaptor *adaptor = [[MXWechatSignAdaptor alloc] initWithWechatAppId:MXWechatAPPID
                                                                            wechatMCHId:MCH_ID
                                                                                tradeNo:tradeNO
                                                                       wechatPartnerKey:WX_PartnerKey
                                                                               payTitle:title
                                                                                orderNo:orderNo
                                                                               totalFee:totalFee
                                                                               deviceIp:addressIP
                                                                              notifyUrl:notifyUrl
                                                                              tradeType:tradeType
                                                                                attach : uvo.phone];
        
        NSString *string = [[adaptor dic] XMLString];
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
        [session.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [session.requestSerializer setValue:WXUNIFIEDORDERURL forHTTPHeaderField:@"SOAPAction"];
        [session.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
            return string;
        }];
        
        [session POST:WXUNIFIEDORDERURL parameters:string progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                  
                  //  输出XML数据
                  NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] ;
                  //  将微信返回的xml数据解析转义成字典
                  NSDictionary *dic = [NSDictionary dictionaryWithXMLString:responseString];
                  
                  // 判断返回的许可
                  if ([[dic objectForKey:@"result_code"] isEqualToString:@"SUCCESS"]
                      &&[[dic objectForKey:@"return_code"] isEqualToString:@"SUCCESS"] ) {
                      // 发起微信支付，设置参数
                      PayReq *request = [[PayReq alloc] init];
                      request.openID = [dic objectForKey:WXAPPID];
                      request.partnerId = [dic objectForKey:WXMCHID];
                      request.prepayId= [dic objectForKey:WXPREPAYID];
                      request.package = @"Sign=WXPay";
                      request.nonceStr= [dic objectForKey:WXNONCESTR];
                      
                      // 将当前时间转化成时间戳
                      NSDate *datenow = [NSDate date];
                      NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
                      UInt32 timeStamp =[timeSp intValue];
                      request.timeStamp= timeStamp;
                      
                      // 签名加密
                      MXWechatSignAdaptor *md5 = [[MXWechatSignAdaptor alloc] init];
                      
                      request.sign=[md5 createMD5SingForPay:request.openID
                                                  partnerid:request.partnerId
                                                   prepayid:request.prepayId
                                                    package:request.package
                                                   noncestr:request.nonceStr
                                                  timestamp:request.timeStamp];
                      // 调用微信
                      [WXApi sendReq:request];
                  }
                  
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
              }];

    } failure:^(NSError *error) {
        
    }];

}
+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    NSMutableString *resultStr = [[NSMutableString alloc] init];

    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wshorten-64-to-32"
    srand(time(0)); // 此行代码有警告:
    #pragma clang diagnostic pop
    for (int i = 0; i < kNumber; i++) {
        
        unsigned index = rand() % [sourceStr length];
        
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
/**
 ------------------------------
 获取设备ip地址
 ------------------------------
 1.貌似该方法获取ip地址只能在wifi状态下进行
 */
+ (NSString *)fetchIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}
@end
