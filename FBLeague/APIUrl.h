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
#define IP @"http://120.27.152.254:8081/"

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
#define listTheme [NSString stringWithFormat:@"%@/%@",API,@"theme/apilist"]
#define clubTheme [NSString stringWithFormat:@"%@/%@",API,@"theme/clubTheme"]
#define userTheme [NSString stringWithFormat:@"%@/%@",API,@"theme/userTheme"]
#define focusTheme [NSString stringWithFormat:@"%@/%@",API,@"theme/focusTheme"]
#define getUnread [NSString stringWithFormat:@"%@/%@",API,@"theme/getUnread"]
#define getUnreadCount [NSString stringWithFormat:@"%@/%@",API,@"theme/getUnreadCount"]

/*******教练或球员相关********/
#define focusPerson [NSString stringWithFormat:@"%@/%@",API,@"fans/apisave"]
#define getCoaches [NSString stringWithFormat:@"%@/%@",API,@"user/listCoaches"]
#define getAllFocus [NSString stringWithFormat:@"%@/%@",API,@"fans/getAllFocus"]
#define getCBDetail [NSString stringWithFormat:@"%@/%@",API,@"user/apiinfo"]
#define setSkill [NSString stringWithFormat:@"%@/%@",API,@"user/setSkill"]
#define getUsersByClubId [NSString stringWithFormat:@"%@/%@",API,@"club/getUsersByClubId"]
#define getApplyTrainee [NSString stringWithFormat:@"%@/%@",API,@"user/getApplyTrainee"]
#define clubDetail [NSString stringWithFormat:@"%@/%@",API,@"club/apiinfo"]
#define applyClub [NSString stringWithFormat:@"%@/%@",API,@"user/apply"]
#define listCoaches [NSString stringWithFormat:@"%@/%@",API, @"user/listCoaches"]
#define searchCoaches [NSString stringWithFormat:@"%@/%@",API, @"user/searchCoaches"]
#define changeNicknameHeadPic [NSString stringWithFormat:@"%@/%@",API, @"user/changeNicknameHeadPic"]

/*******俱乐部********/
#define listClubs [NSString stringWithFormat:@"%@/%@",API,@"club/listClubs"]
#define crxClub [NSString stringWithFormat:@"%@/%@",API,@"club/apisave"]
#define getUsersByClubId [NSString stringWithFormat:@"%@/%@",API,@"club/getUsersByClubId"]
#define searchClubs [NSString stringWithFormat:@"%@/%@",API,@"club/searchClubs"]
#define focusClub [NSString stringWithFormat:@"%@/%@",API,@"fans/apisave"]
#define unfocusClub [NSString stringWithFormat:@"%@/%@",API,@"fans/apisave"]
#define getUsersByClubId [NSString stringWithFormat:@"%@/%@",API,@"club/getUsersByClubId"]
#define getMyTeam [NSString stringWithFormat:@"%@/%@",API,@"user/getMyTeam"]
#define getApplyTrainee [NSString stringWithFormat:@"%@/%@",API,@"user/getApplyTrainee"]
#define joinTrainee [NSString stringWithFormat:@"%@/%@",API,@"user/joinTrainee"]
#define joinTeam [NSString stringWithFormat:@"%@/%@",API,@"user/joinTeam"]
#define exitTeam [NSString stringWithFormat:@"%@/%@",API,@"user/exitTeam"]
#define updateClub [NSString stringWithFormat:@"%@/%@",API,@"club/apiupdate"]

/*******保证金********/
#define getDepositProtocol [NSString stringWithFormat:@"%@/%@",API,@"ht/user/getDepositProtocol"]
#define getCoachProtocol [NSString stringWithFormat:@"%@/%@",API,@"ht/user/getCoachProtocol"]
#define isAuth [NSString stringWithFormat:@"%@/%@",API,@"api/user/isAuth"]
#define getProtocolURL [NSString stringWithFormat:@"%@/%@",IP,@"club/league_protocol.html"]
#define getCUPProtocolURL [NSString stringWithFormat:@"%@/%@",IP,@"club/league_cup_protocol.html"]


/******支付*******/
#define getWXPrepayId [NSString stringWithFormat:@"%@/%@",API,@"pay/getWXPrepayId"]
#define getRandomId [NSString stringWithFormat:@"%@/%@",API,@"pay/getRandomId"]
#define zfbPayNotify [NSString stringWithFormat:@"%@/%@",API,@"pay/zfbPayNotify"]
#define wxPayNotify [NSString stringWithFormat:@"%@/%@",API,@"pay/wxPayNotify"]
#define zfbPayForCourseNotify [NSString stringWithFormat:@"%@/%@",API,@"pay/zfbPayForCourseNotify"]
#define wxPayForCourseNotify [NSString stringWithFormat:@"%@/%@",API,@"pay/wxPayForCourseNotify"]

/******联赛*******/
#define liansaidetail [NSString stringWithFormat:@"%@/%@",API,@"league/getDefault"]
#define joinSave [NSString stringWithFormat:@"%@/%@",API,@"joinin/apisave"]
#define listJoinin [NSString stringWithFormat:@"%@/%@",API,@"joinin/getClubJoinin"]
#define listSchedules [NSString stringWithFormat:@"%@/%@",API,@"schedule/listSchedules"]
#define listClubSchedules [NSString stringWithFormat:@"%@/%@",API,@"schedule/listClubSchedules"]
#define getJoinins [NSString stringWithFormat:@"%@/%@",API, @"joinin/getJoinins"]
#define getJoininDetail [NSString stringWithFormat:@"%@/%@",API, @"schedule/apiinfo"]
#define joinLeague [NSString stringWithFormat:@"%@/%@",API, @"joinin/join"]
#define requestMatch [NSString stringWithFormat:@"%@/%@",API, @"schedule/requestMatch"]
#define submitResult [NSString stringWithFormat:@"%@/%@",API, @"schedule/submitResult"]
#define respondMatch [NSString stringWithFormat:@"%@/%@",API, @"schedule/respondMatch"]
#define cancelMatch [NSString stringWithFormat:@"%@/%@",API, @"schedule/cancelMatch"]

/******杯赛*********/
#define leagueshow [NSString stringWithFormat:@"%@/%@",API,@"leagueshow/show"]
#define leaguedefault [NSString stringWithFormat:@"%@/%@",API,@"leaguecup/getDefault"]
#define getCountyAreas [NSString stringWithFormat:@"%@/%@",API,@"getCountyAreas"]
#define prejoinincup [NSString stringWithFormat:@"%@/%@",API,@"joinincup/preJoin"]
#define joinincup [NSString stringWithFormat:@"%@/%@",API,@"joinincup/join"]
#define getJoininCount [NSString stringWithFormat:@"%@/%@",API,@"joinincup/getJoininCount"]
#define getClubJoinin [NSString stringWithFormat:@"%@/%@",API,@"joinincup/getClubJoinin"]
#define listSchedulesCup [NSString stringWithFormat:@"%@/%@",API,@"schedulecup/listSchedules"]
#define listCurrentSchedules [NSString stringWithFormat:@"%@/%@",API,@"schedulecup/listCurrentSchedules"]
#define submitCupResult [NSString stringWithFormat:@"%@/%@",API,@"schedulecup/submitResult"]
#define getAreaJoininCount [NSString stringWithFormat:@"%@/%@",API,@"joinincup/getAreaJoininCount"]


#endif /* APIUrl_h */
