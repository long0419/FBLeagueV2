//
//  APIUrl.h
//  CarManager
//
//  Created by JinXin on 15/12/9.
//  Copyright © 2015年 droidgle. All rights reserved.
//

#ifndef APIUrl_h
#define APIUrl_h

#define API @"http://139.196.10.164/ktou"
//#define API @"http://192.168.1.106:8081/ktou"
//#define API @"http://120.27.152.254:8081/ktou"

/*******登录注册********/
#define registerUser [NSString stringWithFormat:@"%@/%@",API,@"ht/user/registerUser"]
#define sms [NSString stringWithFormat:@"%@/%@",API,@"ht/user/sms"]
#define updateRid [NSString stringWithFormat:@"%@/%@",API,@"ht/user/updateRid"]
#define login [NSString stringWithFormat:@"%@/%@",API,@"ht/login/login"]
#define uploadHeadPics [NSString stringWithFormat:@"%@/%@",API,@"ht/user/uploadHeadPics"]
#define getAllAdPics [NSString stringWithFormat:@"%@/%@",API,@"ht/file/getAdPics"]
#define uploadIdcardPics [NSString stringWithFormat:@"%@/%@",API,@"ht/user/uploadIdcardPics"]
#define changePassword [NSString stringWithFormat:@"%@/%@",API,@"ht/login/changePassword"]
#define uploadPic [NSString stringWithFormat:@"%@/%@",API,@"ht/user/uploadPic"]

/*******发起众筹相关********/
#define getUserAccount [NSString stringWithFormat:@"%@/%@",API,@"ht/user/getUserAccount"]
#define addLoan [NSString stringWithFormat:@"%@/%@",API,@"ht/loan/addLoan"]
#define getLoanById [NSString stringWithFormat:@"%@/%@",API,@"ht/loan/getLoanById"]
#define listLoan [NSString stringWithFormat:@"%@/%@",API,@"ht/loan/listLoan"]
#define loanRegisterBindNotify [NSString stringWithFormat:@"%@/%@",API,@"ht/loan/loanRegisterBindNotify"]
#define loanTransferNotify [NSString stringWithFormat:@"%@/%@",API,@"ht/loan/loanTransferNotify"]
#define updateCertification [NSString stringWithFormat:@"%@/%@",API,@"ht/user/updateCertification"]
#define getLoanByPhone [NSString stringWithFormat:@"%@/%@",API,@"ht/loan/getLoanByPhone"]
#define getInvestedLoanByPhone [NSString stringWithFormat:@"%@/%@",API,@"ht/loan/getInvestedLoanByPhone"]
#define loanRechargeNotify [NSString stringWithFormat:@"%@/%@",API,@"ht/loan/loanRechargeNotify"]
#define getInvestedAmount [NSString stringWithFormat:@"%@/%@",API,@"ht/loan/getInvestedAmount"]
#define getRepaymentAmount [NSString stringWithFormat:@"%@/%@",API,@"ht/loan/getRepaymentAmount"]
#define getRepayOrders [NSString stringWithFormat:@"%@/%@",API,@"ht/loan/getRepayOrders"]
#define repay [NSString stringWithFormat:@"%@/%@",API,@"ht/loan/repay"]
/***********好友相关**************/
#define getFriendAlls [NSString stringWithFormat:@"%@/%@",API,@"ht/user/getFriends"]
#define getPendingFriends [NSString stringWithFormat:@"%@/%@",API,@"ht/user/getPendingFriends"]
#define checkHasRegPhones [NSString stringWithFormat:@"%@/%@",API,@"ht/user/checkHasRegPhones"]
#define inviteFriends [NSString stringWithFormat:@"%@/%@",API,@"ht/user/inviteFriends"]
#define acceptFriends [NSString stringWithFormat:@"%@/%@",API,@"ht/user/acceptFriends"]

/*************朋友圈相关****************/
#define addPublish [NSString stringWithFormat:@"%@/%@",API,@"ht/publish/addPublish"]
#define addComment [NSString stringWithFormat:@"%@/%@",API,@"ht/publish/addComment"]
#define getPublishById [NSString stringWithFormat:@"%@/%@",API,@"ht/publish/getPublishById"]
#define getPublishsByPhone [NSString stringWithFormat:@"%@/%@",API,@"ht/publish/getPublishsByPhone"]
#define getPublishByComPhone [NSString stringWithFormat:@"%@/%@",API,@"ht/publish/getPublishByComPhone"]
#define listPublish [NSString stringWithFormat:@"%@/%@",API,@"ht/publish/listPublish"]
#define setPraise [NSString stringWithFormat:@"%@/%@",API,@"ht/publish/setPraise"]

/***************分享相关*******************/
#define downloadApp [NSString stringWithFormat:@"%@/%@",API,@"qt/app/index"]
#define getContentById [NSString stringWithFormat:@"%@/%@",API,@"ht/publish/getContentById"]

/****************第二期补充接口*********************/
#define getAllPurposes [NSString stringWithFormat:@"%@/%@" , API , @"ht/purpose/getAllPurposes"]
#define getPurposeById [NSString stringWithFormat:@"%@/%@" , API , @"ht/purpose/getPurposeById"]
#define getIdcardFrontPics [NSString stringWithFormat:@"%@/%@" , API , @"ht/user/getIdcardFrontPics"]

#endif /* APIUrl_h */
