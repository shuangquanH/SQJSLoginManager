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

//自动登录，设备第一次进入app调用
+ (void)autoLogiWithSuccess:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;

//登出当前账户
+ (void)loginOutWithSuccess:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;

//手机号验证码登录，需要传《手机号》和《验证码》两个参数
+ (void)logiWithPhone:(NSString *)phone verify:(NSString *)verify Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;

//绑定手机号，需要传《手机号》和《验证码》两个参数
+ (void)bindingWithPhone:(NSString *)phone verify:(NSString *)verify Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;

//第三方登录，需要传《type》一个参数( 微信传1,  qq传4, 微博传6)
+ (void)logMediaType:(NSInteger)type Success:(void(^)(SQJSUserModel  *user))success failure:(void(^)(NSString *errmag))fail;

@end
