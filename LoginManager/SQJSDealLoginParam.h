//
//  SQJSDealLoginParam.h
//  Podtest
//
//  Created by apple on 2018/3/13.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SQJSUserModel.h"

@interface SQJSDealLoginParam : NSObject

+ (NSDictionary *)requestParam;

+ (SQJSUserModel *)loginUserWithData:(id)result;

@end
