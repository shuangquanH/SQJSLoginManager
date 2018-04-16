//
//  SQJSLoginManager.h
//  Podtest
//
//  Created by apple on 2018/3/13.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQJSUserModel.h"

@interface SQJSLoginModel : NSObject

/** 手机号 */
@property (nonatomic, copy) NSString        *phoneNumber;
/** 验证码 */
@property (nonatomic, copy) NSString        *verifyCode;
/** 邀请码 */
@property (nonatomic, copy) NSString        *inviteCode;
/** 第三方登录的openid */
@property (nonatomic, copy) NSString        *userOpenid;
/** 第三方登录的类型 */
@property (nonatomic, copy) NSString        *userSource;

@end


@interface SQJSLoginManager : NSObject

/** 获取用户id */
+ (NSString *)getUserId;

/** 存储用户id */
+ (void)saveUserId:(NSString *)userid;

/** 自动登录，设备第一次进入app调用 */
+ (void)autoLogiWithSuccess:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;

/** 登出当前账户 */
+ (void)loginOutWithSuccess:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;

/** 手机号登录，需要传入《手机号》，《验证码》，可选填入《邀请码》 */
+ (void)loginWithLoginModel:(SQJSLoginModel *)model Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;

/** 绑定手机号，需要传入《手机号》，《验证码》，《openid》，《source》 */
+ (void)bindingWhitLoginModel:(SQJSLoginModel   *)model Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;

/**
 1.第三方登录，需要传《type》一个参数( 微信传1,  qq传4, 微博传6)
 2.登录成功返回usermodel
 3.登录失败返回errcode，如果errcode返回nil，证明调用第三方出错，如果返回2000则为未绑定手机号,此时ermag为openid
 */
+ (void)logMediaType:(NSInteger)type Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *ercode, NSString *ermag))fail;


@end
