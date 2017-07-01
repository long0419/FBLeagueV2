//
//  UserDataVo.m
//  CarManager
//
//  Created by long-laptop on 16/1/1.
//  Copyright © 2016年 droidgle. All rights reserved.
//

#import "UserDataVo.h"

@implementation UserDataVo

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.realname forKey:@"realname"];
    [aCoder encodeObject:self.pwd forKey:@"pwd"];
    [aCoder encodeObject:self.phone forKey:@"phone"];
    [aCoder encodeObject:self.brithday forKey:@"brithday"];
    [aCoder encodeObject:self.citycode forKey:@"citycode"];
    [aCoder encodeObject:self.club forKey:@"club"];
    [aCoder encodeObject:self.headpicurl forKey:@"headpicurl"];
    [aCoder encodeObject:self.level forKey:@"level"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.openid forKey:@"openid"];
    [aCoder encodeObject:self.provincecode forKey:@"provincecode"];
    [aCoder encodeObject:self.headpicurl forKey:@"headpicurl"];
    [aCoder encodeObject:self.role forKey:@"role"];

}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init]) {
        self.realname = [aDecoder decodeObjectForKey:@"realname"];
        self.pwd = [aDecoder decodeObjectForKey:@"pwd"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.brithday = [aDecoder decodeObjectForKey:@"brithday"];
        self.citycode = [aDecoder decodeObjectForKey:@"citycode"];
        self.club = [aDecoder decodeObjectForKey:@"club"];
        self.headpicurl = [aDecoder decodeObjectForKey:@"headpicurl"];
        self.level = [aDecoder decodeObjectForKey:@"level"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.openid = [aDecoder decodeObjectForKey:@"openid"];
        self.provincecode = [aDecoder decodeObjectForKey:@"provincecode"];
        self.headpicurl = [aDecoder decodeObjectForKey:@"headpicurl"];
        self.role = [aDecoder decodeObjectForKey:@"role"];
    }
    return self ;
}

@end
