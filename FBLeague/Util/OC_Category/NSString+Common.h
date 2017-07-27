//
//  NSString+Common.h
//  HotMate
//
//  Created by JinXin on 15/1/4.
//  Copyright (c) 2015年 iwoapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#define gkey		  @"my.oschina.net/51kcgj?#@"
#define gIv		   @"01234567"

@interface NSString (Common) <UITableViewDataSource>
- (NSString *)md5Str;
- (NSString*) sha1Str;
+ (NSString*) threeDesEncrypt:(NSString*)plainText;
+ (NSString*) threeDesDecrypt:(NSString*)encryptText;

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
//单行文本size
+ (CGSize)getStringContentSizeWithFontSize : (CGFloat) size andContent : (NSString *) content ;
//多行文本的size
+ (CGSize)getMultiStringContentSizeWithFontSize : (CGFloat) size andContent : (NSString *) content ;

+ (NSString *)sizeDisplayWithByte:(CGFloat)sizeOfByte;

//根据时间戳显示时间
+(NSString *)displayTimeByInterval :(NSString *)time ;

//生成验证码
+ (NSString *)getAuthcode ;

- (NSString *)trimWhitespace;
- (BOOL)isEmpty;
//判断是否为整形
- (BOOL)isPureInt;
//判断是否为浮点形
- (BOOL)isPureFloat;

+ (BOOL)validateIDCardNumber:(NSString *)value ;

- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;
+ (NSString *)convertToJsonData:(NSDictionary *)dict ;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString ;

@end
