//
//  SQJSLoginParamModel.h
//  Podtest
//
//  Created by apple on 2018/3/13.
//  Copyright © 2018年 Fly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQJSLoginParamModel : NSObject

@property (nonatomic, copy) NSString        *idfa;
@property (nonatomic, copy) NSString        *idfv;
@property (nonatomic, copy) NSString        *deviceType;
@property (nonatomic, copy) NSString        *osVesion;
@property (nonatomic, copy) NSString        *vendor;
@property (nonatomic, copy) NSString        *model;
@property (nonatomic, copy) NSString        *screenSize;
@property (nonatomic, copy) NSString        *mac;


+ (SQJSLoginParamModel *)sharedRequestModel;

@end
