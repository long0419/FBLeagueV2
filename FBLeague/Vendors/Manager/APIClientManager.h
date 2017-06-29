//
//  APIClientManager.h
//  CarManager
//
//  Created by JinXin on 15/12/9.
//  Copyright © 2015年 droidgle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIClient.h"

@interface APIClientManager : NSObject

+ (instancetype)sharedManager;

//配件分类一级分类
- (void)request_Category_WithBlock:(void (^)(id data, NSError *error))block;

//配件分类二级分类
- (void)request_Category_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//二级类目获取商品配件信息
- (void)request_productCategory_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//获取商品配件详情信息
- (void)request_productDetail_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//获取订单信息
- (void)request_Order_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//获取购物车
- (void)request_ShopCart_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//添加购物车
- (void)request_AddCart_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//获取用户信息
- (void)request_User_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//保存用户信息
- (void)request_SaveUser_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//查询地址
- (void)request_Recipient_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//订单结算
- (void)request_Clearing_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//确认收货
- (void)request_ConfirmProduct_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//关闭订单
- (void)request_CloseOrder_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//汽车品牌
- (void)request_Brands_WithBlock:(void (^)(id data, NSError *error))block;

//搜索
- (void)request_SearchProduct_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//save
- (void)request_saveProduct_WithUrl:(NSString *)url andBlock:(void (^)(id data, NSError *error))block;

//删除商品
- (void)request_DeleteProduct_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//修改商品数量
- (void)request_CountProduct_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//退换货
- (void)request_ReturnProduct_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;

//评论
- (void)request_CommentProduct_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block;
@end
