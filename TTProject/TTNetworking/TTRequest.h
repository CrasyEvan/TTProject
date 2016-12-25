//
//  HHRequest.h
//  TTProject
//
//  Created by Evan on 16/8/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 请求类型
 */
typedef enum {
    HRequestType_Get = 0,
    HRequestType_Post,
    HRequestType_Download,
    HRequestType_Upload,
}TTRequestType;

/**
 统一的回调返回状态
 */
typedef enum {
    TCallBackStatus_Invalid = 0,    //不合法
    TCallBackStatus_Succ = 1,       //成功
    TCallBackStatus_Fail = 2,       //失败
    TCallBackStatus_Processing = 3, //处理中
    TCallBackStatus_Cancel = 4,     //取消
}TTCallBackStatus;

@class TTRequestModel;

typedef void(^TTRequestCallBackBlock)(NSDictionary *info, TTRequestModel *model, TTCallBackStatus status, NSError *err);


@interface TTRequest : NSObject

@property (nonatomic, strong) NSString * url;               // url = host + method
@property (nonatomic, strong) NSString * host;
@property (nonatomic, strong) NSString * method;
@property (nonatomic, strong) NSMutableDictionary * params;
@property (nonatomic, strong) Class modelClass;             //数据模型元类

@property (nonatomic, assign) TTRequestType requestType;    // default ERequestType_Get
@property (nonatomic, assign) BOOL showLoading;             // default YES
@property (nonatomic, assign) BOOL isCache;                 // 暂时没有用到
@property (nonatomic, assign) BOOL mock;                    // 是否需要mock数据, default NO


- (void)sendRequestWithComplete:(TTRequestCallBackBlock)block;

- (instancetype)initWithRequestType:(TTRequestType)type
                               host:(NSString *)host
                             method:(NSString *)method
                         modelClass:(Class)modelClass
                             params:(NSDictionary *)params;


@end
