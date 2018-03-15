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
+ (void)bindingWithPhone:(NSString *)phone verify:(NSString *)verify Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail {
    NSDictionary    *param = @{@"phone":phone, @"verify":verify};
    [SQRequest postRequestWithApi:KAPI_BINDINGPhoneADDRESS param:param result:^(id resultData) {
        [self successBlock:success withResult:resultData];
    } failure:^(NSString *errcode, NSString *errmsg) {
        [self failBlock:fail witheResultErr:errmsg];
    }];
}

+ (void)logMediaType:(NSInteger)type Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail {
    if ([self judgeType:type]) {
        NSLog(@"请输入正确的type");
        return;
    }
    [JSHAREService getSocialUserInfo:type handler:^(JSHARESocialUserInfo *userInfo, NSError *error) {
        if (error) {
            [self failBlock:fail witheResultErr:error.domain];
        } else {
            NSString    *openId = [userInfo.userOriginalResponse valueForKey:@"openId"];
            NSString    *sex = [NSString stringWithFormat:@"%ld", userInfo.gender];
            NSString    *source = [self loginSourceWithType:type];
            NSDictionary  *param = @{@"openId":openId, @"source":source, @"nickName":userInfo.name, @"avator":userInfo.iconurl, @"sex":sex};
            [SQRequest postRequestWithApi:KAPI_MEDIALOGINADDRESS param:param result:^(id resultData) {
                [self successBlock:success withResult:resultData];
            } failure:^(NSString *errcode, NSString *errmsg) {
                [self failBlock:fail witheResultErr:error.domain];
            }];
        }
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

+ (NSString *)loginSourceWithType:(NSInteger)type {
    if (type==1) {
        return @"wechat";
    } else if (type==4) {
        return @"QQ";
    } else {
        return @"weibo";
    }
}
+ (BOOL)judgeType:(NSInteger)type{
    if (type!=1&&type!=4&&type!=6) {
        return YES;
    } else {
        return NO;
    }
}
@end
