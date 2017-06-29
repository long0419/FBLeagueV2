//
//  APIClientManager.m
//  CarManager
//
//  Created by JinXin on 15/12/9.
//  Copyright © 2015年 droidgle. All rights reserved.
//

#import "APIClientManager.h"

@implementation APIClientManager

+ (instancetype)sharedManager {
    static APIClientManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

//配件分类一级分类
- (void)request_Category_WithBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/product/product-category!mFirstCategorySearch.action" withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//配件分类二级分类
- (void)request_Category_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/product/product-category!mSecondCategorySearch.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//二级类目获取商品配件信息
- (void)request_productCategory_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/product!searchByCategory.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//获取商品配件详情信息
- (void)request_productDetail_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/product.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//获取订单信息
- (void)request_Order_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/so.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//获取购物车
- (void)request_ShopCart_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/shopping-cart.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//添加购物车
- (void)request_AddCart_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/shopping-cart!joinToCart.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//获取用户信息
- (void)request_User_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/member-info!info.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//保存用户信息
- (void)request_SaveUser_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/member-register!save.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//查询地址
- (void)request_Recipient_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/recipient-msg.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//订单结算
- (void)request_Clearing_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/shopping-cart!joinToSo.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//确认收货
- (void)request_ConfirmProduct_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/so!confirmProduct.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//关闭订单
- (void)request_CloseOrder_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/so!toClose.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//汽车品牌
- (void)request_Brands_WithBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/product!getBrands.action" withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//搜索
- (void)request_SearchProduct_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/product!searchProduct.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//save
- (void)request_saveProduct_WithUrl:(NSString *)url andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:url withParams:nil withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//删除商品
- (void)request_DeleteProduct_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/shopping-cart!delete.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//修改商品数量
- (void)request_CountProduct_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/shopping-cart!save.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//退换货
- (void)request_ReturnProduct_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/so!grf.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}

//评论
- (void)request_CommentProduct_WithParams:(id)params andBlock:(void (^)(id data, NSError *error))block{
    [[APIClient sharedJsonClient] requestJsonDataWithPath:@"/front/so!commentProduct.action" withParams:params withMethodType:Get andBlock:^(id data, NSError *error) {
        if (data) {
            block(data, nil);
        }else{
            block(nil, error);
        }
    }];
}
@end
