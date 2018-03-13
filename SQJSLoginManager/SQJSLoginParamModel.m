//
//  SQJSLoginParamModel.m
//  Podtest
//
//  Created by apple on 2018/3/13.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import "SQJSLoginParamModel.h"
#import <AdSupport/AdSupport.h>
#import <UIKit/UIKit.h>
#import "sys/utsname.h"

@implementation SQJSLoginParamModel


static SQJSLoginParamModel *model;
+ (SQJSLoginParamModel *)sharedRequestModel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[SQJSLoginParamModel alloc] init];
        model.idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        model.idfv =  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        struct utsname systemInfo;
        uname(&systemInfo);
        model.deviceType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
        model.osVesion = [UIDevice currentDevice].systemVersion;
        model.vendor = @"china";
        model.model = @"CN";
        model.screenSize = [self getDeviceScreenSize];
    });
    return model;
}


+ (NSString *)getDeviceScreenSize {
    NSString *sizeStr = [NSString stringWithFormat:@"%.0f*%0.0f", [self getDeviceScreenWidth], [self getDeviceScreenHeight]];
    return sizeStr;
}
+ (CGFloat)getDeviceScreenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)getDeviceScreenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}


@end
