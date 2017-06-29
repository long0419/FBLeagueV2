//
//  APIClient.h
//  CarManager
//
//  Created by JinXin on 15/12/9.
//  Copyright © 2015年 droidgle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "APIUrl.h"
#import "NSObject+Common.h"
#import "JSONKit.h"
typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;

@interface APIClient : AFHTTPRequestOperationManager

+ (id)sharedJsonClient;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(int)NetworkMethod
                       andBlock:(void (^)(id data, NSError *error))block;
@end
