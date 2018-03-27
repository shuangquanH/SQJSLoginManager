//
//  SQJSLoginManager.m
//  Podtest
//
//  Created by apple on 2018/3/13.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import "SQJSLoginManager.h"
#import "SQJSLoginDefine.h"
#import "SQJSDealLoginParam.h"
#import "SQRequest.h"
#import "JSHAREService.h"

@implementation SQJSLoginManager


//获取用户id
+ (NSString *)getUserId {
    return [[NSUserDefaults standardUserDefaults] valueForKey:K_USER_ID];
}

//存储用户id
+ (void)saveUserId:(NSString *)userid {
    [[NSUserDefaults standardUserDefaults] setValue:userid forKey:K_USER_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)autoLogiWithSuccess:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail {
    NSDictionary    *param =    [SQJSDealLoginParam requestParam];
    [SQRequest postRequestWithApi:KAPI_LOGINADDRESS param:param result:^(id resultData) {
        [self successBlock:success withResult:resultData];
    } failure:^(NSString *errcode, NSString *errmsg) {
        [self failBlock:fail witheResultErr:errmsg];
    }];
}
+ (void)loginOutWithSuccess:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail {
    [SQRequest postRequestWithApi:KAPI_LOGINOUTADDRESS param:nil result:^(id resultData) {
        [self successBlock:success withResult:resultData];
    } failure:^(NSString *errcode, NSString *errmsg) {
        [self failBlock:fail witheResultErr:errmsg];
    }];
}

+ (void)logiWithPhone:(NSString *)phone verify:(NSString *)verify Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail {
    NSDictionary    *param = @{@"phone":phone, @"verify":verify};
    [SQRequest postRequestWithApi:KAPI_LOGINPhoneADDRESS param:param result:^(id resultData) {
        [self successBlock:success withResult:resultData];
    } failure:^(NSString *errcode, NSString *errmsg) {
        [self failBlock:fail witheResultErr:errmsg];
    }];
}
+ (void)bindingWithPhone:(NSString *)phone verify:(NSString *)verify openId:(NSString *)openId source:(NSString *)source Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail {
    NSDictionary    *param = @{@"phone":phone, @"verify":verify, @"openId":openId, @"source":source};
    [SQRequest postRequestWithApi:KAPI_BINDINGPhoneADDRESS param:param result:^(id resultData) {
        [self successBlock:success withResult:resultData];
    } failure:^(NSString *errcode, NSString *errmsg) {
        [self failBlock:fail witheResultErr:errmsg];
    }];
}

+ (void)logMediaType:(NSInteger)type Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *ercode, NSString *ermag))fail {
    if ([self judgeType:type]) {  return; }
    
    [JSHAREService getSocialUserInfo:type handler:^(JSHARESocialUserInfo *userInfo, NSError *error) {
        if (error) {
            [self failBlock:fail withCode:nil msg:error.domain];
        } else {
            NSDictionary *param = [self thirdLoginSuccessWithDic:userInfo type:type];
            [SQRequest postRequestWithApi:KAPI_MEDIALOGINADDRESS param:param result:^(id resultData) {
                [self successBlock:success withResult:resultData];
            } failure:^(NSString *errcode, NSString *errmsg) {
                NSString    *passString;
                if (type==6) {
                    passString = ([errcode isEqualToString:@"2000"])?userInfo.uid:errmsg;
                } else {
                    passString = ([errcode isEqualToString:@"2000"])?userInfo.openid:errmsg;
                }
                [self failBlock:fail withCode:errcode msg:passString];
            }];
        }
    }];
}

//第三方登录成功后返回的数据
+ (NSDictionary *)thirdLoginSuccessWithDic:(JSHARESocialUserInfo *)userInfo type:(NSInteger)loginType {
    if (loginType==1) {
        return [self wechatLoginSuccessWithDic:userInfo];
    } else if (loginType==4) {
        return [self qqLoginSuccessWithDic:userInfo];
    } else if (loginType==6) {
        return [self weiboLoginSuccessWithDic:userInfo];
    } else {
        return nil;
    }
}

//微信登录成功后返回的数据
+ (NSDictionary *)wechatLoginSuccessWithDic:(JSHARESocialUserInfo *)userInfo {
    NSString *openId = userInfo.openid;
    NSString *source = @"WEIXIN";
    NSString *nickName = userInfo.userOriginalResponse[@"nickname"];
    NSString *avator = userInfo.userOriginalResponse[@"headimgurl"];
    NSString *sex = (userInfo.gender==1)?@"1":@"0";
    NSString *country = userInfo.userOriginalResponse[@"country"];
    NSString *province = userInfo.userOriginalResponse[@"province"];
    NSString *city = userInfo.userOriginalResponse[@"city"];
    return @{@"openId":openId,
             @"source":source,
             @"nickName":nickName,
             @"avator":avator,
             @"sex":sex,
             @"country":country,
             @"province":province,
             @"city":city
             };
}
//qq登录成功后返回的数据
+ (NSDictionary *)qqLoginSuccessWithDic:(JSHARESocialUserInfo *)userInfo {
    NSString *openId = userInfo.openid;
    NSString *source = @"QQ";
    NSString *nickName = userInfo.userOriginalResponse[@"nickname"];
    NSString *avator = userInfo.userOriginalResponse[@"figureurl_qq_2"];
    NSString *sex = (userInfo.gender==1)?@"1":@"0";
    NSString *city = userInfo.userOriginalResponse[@"city"];
    return @{@"openId":openId,
             @"source":source,
             @"nickName":nickName,
             @"avator":avator,
             @"sex":sex,
             @"city":city
             };
}

//微博登录成功后返回的数据
+ (NSDictionary *)weiboLoginSuccessWithDic:(JSHARESocialUserInfo *)userInfo {
    NSString *openId = userInfo.uid;
    NSString *source = @"WEIBO";
    NSString *nickName = userInfo.name;
    NSString *avator = userInfo.iconurl;
    NSString *sex = (userInfo.gender==1)?@"1":@"0";
    NSString *city = userInfo.userOriginalResponse[@"location"];
    return @{@"openId":openId,
             @"source":source,
             @"nickName":nickName,
             @"avator":avator,
             @"sex":sex,
             @"city":city
             };
}


+ (BOOL)judgeType:(NSInteger)type{
    if (type!=1&&type!=4&&type!=6) {
        NSLog(@"请输入正确的type");
        return YES;
    } else {
        return NO;
    }
}


+ (void)successBlock:(void(^)(SQJSUserModel  *user))success withResult:(id)resultData {
    if (success) {
        success([SQJSDealLoginParam loginUserWithData:resultData]);
    }
}

+ (void)failBlock:(void(^)(NSString *errmag))fail witheResultErr:(NSString *)errmsg {
    if (fail) {
        fail(errmsg);
    }
}
//第三方登录失败返回code码和errmsg（code==2000时，errmsg为openid）
+ (void)failBlock:(void(^)(NSString *errcod, NSString *errmsg))fail withCode:(NSString *)errcode msg:(NSString *)errmsg {
    if (fail) {
        fail(errcode, errmsg);
    }
}

@end
