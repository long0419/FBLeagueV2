//
//  APIClient.m
//  CarManager
//
//  Created by JinXin on 15/12/9.
//  Copyright © 2015年 droidgle. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

+ (APIClient *)sharedJsonClient {
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:API]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html",nil];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    self.securityPolicy.allowInvalidCertificates = YES;
    
    return self;
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(int)NetworkMethod
                       andBlock:(void (^)(id data, NSError *error))block{
    //log请求数据
    DebugLog(@"\n===========request===========\n%@:\n%@", aPath, params);
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //发起请求
    switch (NetworkMethod) {
        case Get:{
            [self GET:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n%@===========response===========:\n%@", aPath, responseObject);
                block(responseObject, nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n%@===========response===========:\n%@", aPath, error);
                [self showError:error];
                block(nil, error);
            }];
            break;}
        case Post:{
            [self POST:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n%@===========response===========:\n%@", aPath, responseObject);
                block(responseObject, nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n%@===========response===========:\n%@", aPath, error);
                [self showError:error];
                block(nil, error);
            }];
            break;}
        case Put:{
            [self PUT:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n%@===========response===========:\n%@", aPath, responseObject);
                block(responseObject, nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n%@===========response===========:\n%@", aPath, error);
                [self showError:error];
                block(nil, error);
            }];
            break;}
        case Delete:{
            [self DELETE:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DebugLog(@"\n%@===========response===========:\n%@", aPath, responseObject);
                block(responseObject, nil);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DebugLog(@"\n%@===========response===========:\n%@", aPath, error);
                [self showError:error];
                block(nil, error);
            }];}
        default:
            break;
    }
}
@end
