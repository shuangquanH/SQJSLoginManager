//
//  SQJSDealLoginParam.m
//  Podtest
//
//  Created by apple on 2018/3/13.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import "SQJSDealLoginParam.h"
#import "SQJSLoginParamModel.h"
#import "SQAsiNetworkDefine.h"
#import "YYModel.h"

@implementation SQJSDealLoginParam

+ (NSDictionary *)requestParam {
    SQJSLoginParamModel   *model = [SQJSLoginParamModel sharedRequestModel];
    NSMutableDictionary *mutaParam = [NSMutableDictionary dictionary];
    
    [mutaParam setValue:model.idfa forKey:@"idfa"];
    [mutaParam setValue:model.idfv forKey:@"idfv"];
    [mutaParam setValue:model.deviceType forKey:@"deviceType"];
    [mutaParam setValue:model.osVesion forKey:@"osVesion"];
    [mutaParam setValue:model.vendor forKey:@"vendor"];
    [mutaParam setValue:model.model forKey:@"model"];
    [mutaParam setValue:model.screenSize forKey:@"screenSize"];
    return mutaParam;
}
+ (SQJSUserModel *)loginUserWithData:(id)result {
    NSDictionary    *dic = [NSDictionary dictionaryWithDictionary:result];
    SQJSUserModel   *model = [SQJSUserModel yy_modelWithDictionary:dic];
    [[NSUserDefaults standardUserDefaults] setValue:model.userId forKey:K_USER_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return model;
}

@end
