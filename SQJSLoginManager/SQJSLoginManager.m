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
+ (void)bindingWithPhone:(NSString *)phone verify:(NSString *)verify openId:(NSString *)openId Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail {
    NSDictionary    *param = @{@"phone":phone, @"verify":verify, @"openId":openId};
    [SQRequest postRequestWithApi:KAPI_BINDINGPhoneADDRESS param:param result:^(id resultData) {
        [self successBlock:success withResult:resultData];
    } failure:^(NSString *errcode, NSString *errmsg) {
        [self failBlock:fail witheResultErr:errmsg];
    }];
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

@end
