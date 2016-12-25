//
//  HHRequest.m
//  TTProject
//
//  Created by Evan on 16/8/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "TTRequest.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import "TTRequstConfig.h"
#import "NSString+CMUtils.h"


@implementation TTRequest

- (instancetype)initWithRequestType:(TTRequestType)type
                               host:(NSString *)host
                             method:(NSString *)method
                         modelClass:(Class )modelClass
                             params:(NSDictionary *)params {
    self = [super init];
    if (self) {
        _requestType = type;
        _host = host;
        _method = method;
        _params = [[NSMutableDictionary alloc] initWithDictionary:params];
        _showLoading = NO;
        _modelClass = modelClass;
        _url = [self configURL];
    }
    return self;
}

- (NSString *)configURL {
    NSString *redirectURL;
    redirectURL = [self.host stringByAppendingPathComponent:_method];
    return redirectURL;

}

#pragma mark - Send Request
- (void)startRequest:(TTRequestCallBackBlock)block {
    
    [self buildParams];
    switch (self.requestType) {
        case HRequestType_Get:
            [self getRequestWithURL:_url params:_params modelClass:_modelClass callBack:block];
            break;
        case HRequestType_Post:
            [self postRequestWithURL:_url postData:_params modelClass:_modelClass callBack:block];
            break;
        default:
            break;
    }
}

- (void)buildParmas{
    //添加公共参数
    NSDictionary *dic = [TTRequest buildCommonParams];
    for (id key in dic) {
        if (dic[key]) {
            [self.params setObject:dic[key] forKey:key];
        }
    }
}

//build Common Params
+ (NSDictionary *)buildCommonParams {
    
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    NSString *screenSize =
    [NSString stringWithFormat:@"%f,%f", screenWidth, screenHeight];
    
    NSDictionary *tmpDic = @{
                             @"appVersion":appVersion,
                             @"screenSize":screenSize,
                             };
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:tmpDic];
    return params;
}

- (void)sendRequestWithComplete:(TTRequestCallBackBlock)block {
    
    if (_url == nil) {
        NSError *err = [NSError errorWithDomain:@"URL为空" code:0 userInfo:nil];
        block(nil, nil, TCallBackStatus_Fail, err);
    }
    
    if (self.url.length == 0) {
        self.url = [self.host stringByAppendingPathComponent:self.method];
    }
    [self startRequest:block];
}

- (void)buildParams {
    //添加公共参数
    NSDictionary *dic = [TTRequest buildCommonParams];
    for (id key in dic) {
        
        if (dic[key]) {
            [self.params setObject:dic[key] forKey:key];
        }
    }

    LogInfo(@"Send Request:%@\n, Params:%@", _url, _params);
}



#pragma mark - GET Request
- (void)getRequestWithURL:(NSString *)url
                   params:(NSDictionary *)params
               modelClass:(Class)modelClass
                 callBack:(TTRequestCallBackBlock)block {
    
    NSParameterAssert(url != nil);
    NSString *sortedDicString = [self sortDic:params];
    NSString *requestURL = [NSString stringWithFormat:@"%@?%@", url, sortedDicString];
    
    if (self.mock) {
        NSDictionary *mockInfo = [self mockResponseDicFromMethod:_method];
        TTCallBackStatus mockStatus = TCallBackStatus_Succ;
        [self handleResponseInfo:mockInfo
              withCallBackStatus:mockStatus
                      modelClass:self.modelClass requestCallBack:block];
    }
    else {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = TTRequstTimeOut;
        [manager GET:requestURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            [self handleResponseInfo:responseObject
                  withCallBackStatus:TCallBackStatus_Succ
                          modelClass:self.modelClass
                     requestCallBack:block];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            block(nil, nil, TCallBackStatus_Fail,  error);
        }];
    }
}

//把dic排序，转成string
- (NSString *)sortDic:(NSDictionary *)postDic {
    
    if (postDic == nil) {
        return nil;
    }
    
    NSArray *keys = [postDic allKeys];
    NSComparator sort = ^(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    };
    NSArray *allKeys = [keys sortedArrayUsingComparator:sort];
    NSString *sortDicString = @"";
    for (id ikey in allKeys) {
        id value = [postDic objectForKey:ikey];
        if ([value isKindOfClass:[NSString class]]) {
            value = [((NSString *)value)urlEncodedString];
        }
        sortDicString =
        [NSString stringWithFormat:@"%@&%@=%@", sortDicString, ikey, value];
    }
    
    if ([sortDicString length] < 2) {
        return nil;
    }
    else {
        return [sortDicString substringFromIndex:1];
    }
}


#pragma mark - POST Request
- (void)postRequestWithURL:(NSString *)url
                  postData:(NSDictionary *)postData
                modelClass:(Class)modelClass callBack:(TTRequestCallBackBlock)block {
    
    NSParameterAssert(url != nil);
    if (self.mock) {
        NSDictionary *mockInfo = [self mockResponseDicFromMethod:self.method];
        TTCallBackStatus mockStatus = TCallBackStatus_Succ;
        [self handleResponseInfo:mockInfo
              withCallBackStatus:mockStatus
                      modelClass:self.modelClass requestCallBack:block];
    }
    else {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer.timeoutInterval = TTRequstTimeOut;
        [manager POST:url
           parameters:postData
             progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [self handleResponseInfo:responseObject
                       withCallBackStatus:TCallBackStatus_Succ
                               modelClass:self.modelClass
                          requestCallBack:block];
                  
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 block(nil, nil, TCallBackStatus_Fail,  error);
             }];
    }
}

- (void)handleResponseInfo:(NSDictionary *)info
        withCallBackStatus:(TTCallBackStatus)status
                modelClass:(Class)modelClass
           requestCallBack:(TTRequestCallBackBlock)block {
    
    if(status == TCallBackStatus_Succ) {
        
        //dic to model
        //用户处理数据统一利用模型来处理, 强烈建议不要通过objectForKey来取, 避免后台数据返回异常导致的crash
        TTRequestModel *model = [modelClass mj_objectWithKeyValues:info];
        block(info, model, TCallBackStatus_Succ, nil);
    }
}


#pragma mark - 构建mock数据
- (NSDictionary *)mockResponseDicFromMethod:(NSString *)method {
    
    //TODO: build mock response
    NSString *resourcePath = [NSString stringWithFormat:@"Mockjson.bundle/#%@", method];
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:resourcePath ofType:@"do"];
    if (jsonPath) {
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:jsonPath];
        if (jsonData) {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            if (jsonString) {
                return @{@"data" : jsonString};
            }
            else {
                NSLog(@"json parse error");
            }
        }
        else {
            NSLog(@"json data error");
        }
    }
    else {
        NSLog(@"jsonpath = nil");
    }
    return nil;
    
}


@end
