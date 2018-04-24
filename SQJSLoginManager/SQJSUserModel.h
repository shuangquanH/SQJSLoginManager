//
//  SQJSUserModel.h
//  Podtest
//
//  Created by apple on 2018/3/13.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQJSUserModel : NSObject

/** id */
@property (nonatomic, copy) NSString        *userId;
/** 姓名 */
@property (nonatomic, copy) NSString        *name;
/** 昵称 */
@property (nonatomic, copy) NSString        *nickName;
/** 手机 */
@property (nonatomic, copy) NSString        *phone;
/** 电话 */
@property (nonatomic, copy) NSString        *tel;
/** 邮箱 */
@property (nonatomic, copy) NSString        *email;
/** 性别 -1未知， 0女， 1男 */
@property (nonatomic, copy) NSString        *sex;
/** 省份 */
@property (nonatomic, copy) NSString        *province;
/** 城市 */
@property (nonatomic, copy) NSString        *city;
/** 地区 */
@property (nonatomic, copy) NSString        *district;
/** 头像 */
@property (nonatomic, copy) NSString        *avator;
/** 地址 */
@property (nonatomic, copy) NSString        *address;
/** 推荐来源 */
@property (nonatomic, copy) NSString        *recommendation;
/** 推荐用户id */
@property (nonatomic, copy) NSString        *referrerId;
/// type 0-游客 1-登录用户
@property (nonatomic, copy) NSString        *type;
@end
