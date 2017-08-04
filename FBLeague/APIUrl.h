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
#define uploadPics [NSString stringWithFormat:@"%@/%@",API,@"file/uploadPics"]

/*******朋友圈********/
#define apisave [NSString stringWithFormat:@"%@/%@",API,@"theme/apisave"]
#define apilist [NSString stringWithFormat:@"%@/%@",API,@"theme/apilist"]
#define setPraise [NSString stringWithFormat:@"%@/%@",API,@"theme/setPraise"]
#define apicmsave [NSString stringWithFormat:@"%@/%@",API,@"comment/apisave"]
#define listTheme [NSString stringWithFormat:@"%@/%@",API,@"theme/listTheme"]

/*******教练或球员相关********/
#define focusPerson [NSString stringWithFormat:@"%@/%@",API,@"fans/apisave"]
#define getCoaches [NSString stringWithFormat:@"%@/%@",API,@"user/listCoaches"]
#define getAllFocus [NSString stringWithFormat:@"%@/%@",API,@"fans/getAllFocus"]
#define getCBDetail [NSString stringWithFormat:@"%@/%@",API,@"user/apiinfo"]
#define setSkill [NSString stringWithFormat:@"%@/%@",API,@"user/setSkill"]
#define getUsersByClubId [NSString stringWithFormat:@"%@/%@",API,@"club/getUsersByClubId"]

/*******俱乐部********/
#define listClubs [NSString stringWithFormat:@"%@/%@",API,@"club/listClubs"]

/*******保证金********/
#define getDepositProtocol [NSString stringWithFormat:@"%@/%@",API,@"ht/user/getDepositProtocol"]
#define getCoachProtocol [NSString stringWithFormat:@"%@/%@",API,@"ht/user/getCoachProtocol"]
#define isAuth [NSString stringWithFormat:@"%@/%@",API,@"ht/user/isAuth"]



#endif /* APIUrl_h */
