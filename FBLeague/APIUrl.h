//
//  APIUrl.h
//  CarManager
//
//  Created by JinXin on 15/12/9.
//  Copyright © 2015年 droidgle. All rights reserved.
//

#ifndef APIUrl_h
#define APIUrl_h

#define API @"http://120.27.152.254:8081/club/api"

/*******登录注册********/
#define login [NSString stringWithFormat:@"%@/%@",API,@"login"]
#define registerUser [NSString stringWithFormat:@"%@/%@",API,@"register"]
#define getProvinces [NSString stringWithFormat:@"%@/%@",API,@"getProvinces"]
#define getCities [NSString stringWithFormat:@"%@/%@",API,@"getCities"]
#define getAreas [NSString stringWithFormat:@"%@/%@",API,@"getAreas"]
#define uploadHeadPics [NSString stringWithFormat:@"%@/%@",API,@"file/uploadHeadPics"]
#define apiupdate [NSString stringWithFormat:@"%@/%@",API,@"user/apiupdate"]
#define updateRegistrationId [NSString stringWithFormat:@"%@/%@",API,@"user/updateRegistrationId"]
#define sms [NSString stringWithFormat:@"%@/%@",API,@"sms"]
#define uploadPic [NSString stringWithFormat:@"%@/%@",API,@"file/uploadPic"]


#endif /* APIUrl_h */
