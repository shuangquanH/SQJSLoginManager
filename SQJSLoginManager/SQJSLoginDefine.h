//
//  SQJSLoginDefine.h
//  Podtest
//
//  Created by apple on 2018/3/13.
//  Copyright © 2018年 Fly. All rights reserved.
//

//用户登录工具类头文件

#ifndef SQJSLoginDefine_h
#define SQJSLoginDefine_h

/** 用户登录工具类 */
#import "SQJSLoginManager.h"
/** 登录参数处理类 */
#import "SQJSDealLoginParam.h"

/** 自动登录接口 */
#define KAPI_LOGINADDRESS @"/api/ucs/login/auto"

/** 登出接口 */
#define KAPI_LOGINOUTADDRESS @"/api/ucs/login/logout"

/** 手机号登录 */
#define KAPI_LOGINPhoneADDRESS @"/api/ucs/login/phone"

/** 手机号绑定 */
#define KAPI_BINDINGPhoneADDRESS @"/api/ucs/login/banding"

/** 第三方登录 */
#define KAPI_MEDIALOGINADDRESS @"/api/ucs/login/third"



#endif /* SQJSLoginDefine_h */
