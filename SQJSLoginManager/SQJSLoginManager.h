//
//  SQJSLoginManager.h
//  Podtest
//
//  Created by apple on 2018/3/13.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQJSUserModel.h"

@interface SQJSLoginManager : NSObject

//获取用户id
+ (NSString *)getUserId;

//存储用户id
+ (void)saveUserId:(NSString *)userid;

//自动登录，设备第一次进入app调用
+ (void)autoLogiWithSuccess:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;

//登出当前账户
+ (void)loginOutWithSuccess:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;

//手机号验证码登录，需要传《手机号》和《验证码》两个参数
+ (void)logiWithPhone:(NSString *)phone verify:(NSString *)verify Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;

//绑定手机号，需要传《手机号》《验证码》《openid》《source》四个参数
+ (void)bindingWithPhone:(NSString *)phone verify:(NSString *)verify openId:(NSString *)openId source:(NSString *)source Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;


@end
