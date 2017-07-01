//
//  UserDataVo.h
//  CarManager
//
//  Created by long-laptop on 16/1/1.
//  Copyright © 2016年 droidgle. All rights reserved.
//

#import <Foundation/Foundation.h>

//这里使用NSCoding 因为要使用NSData 进行本地缓存
@interface UserDataVo : NSObject <NSCoding>

@property (nonatomic , strong) NSString *brithday ;
@property (nonatomic , strong) NSString *citycode ;
@property (nonatomic , strong) NSString *cityName ;
@property (nonatomic , strong) NSString *club ;
@property (nonatomic , strong) NSString *headpicurl ;
@property (nonatomic , strong) NSString *level ;
@property (nonatomic , strong) NSString *nickname ;
@property (nonatomic , strong) NSString *openid ;
@property (nonatomic , strong) NSString *provincecode ;
@property (nonatomic , strong) NSString *pwd ;
@property (nonatomic , strong) NSString *realname ;
@property (nonatomic , strong) NSString *role ;
@property (nonatomic , strong) NSString *phone ;
@property (nonatomic , strong) NSString *areacode ;
@property (nonatomic , strong) NSString *desc ;
@property (nonatomic , strong) NSString *firstletter ;
@property (nonatomic , strong) NSString *position ;
@property (nonatomic , strong) NSString *registrationid ;
@property (nonatomic , strong) NSString *regtime ;
@property (nonatomic , strong) NSString *skillCount ;
@property (nonatomic , strong) NSString *status ;


@property (nonatomic , strong) NSString *speed ;
@property (nonatomic , strong) NSString *stimulate ;
@property (nonatomic , strong) NSString *strength ;
//@property (nonatomic , strong) NSString *strongHand ;
@property (nonatomic , strong) NSString *withstand ;
@property (nonatomic , strong) NSString *pass ;
@property (nonatomic , strong) NSString *defend ;
@property (nonatomic , strong) NSString *dribbling ;

@property (nonatomic , strong) NSString *skill ;
@property (nonatomic , strong) NSString *control ;
@property (nonatomic , strong) NSString *counterattack ;
@property (nonatomic , strong) NSString *stronghand ;
@property (nonatomic , strong) NSString *compete ;


@property (nonatomic , strong) NSString *hasAuth ;



@end
