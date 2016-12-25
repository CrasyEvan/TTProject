

//
//  HHBookRequstFactory.m
//  TTProject
//
//  Created by Evan on 16/8/23.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "TTBookRequstFactory.h"
#import "TTRequest.h"
#import "TTBookModel.h"

//https://api.douban.com/v2/book/1220562

#define kBookListMethod @"v2/book/1220562"
#define kBookInfoMethod @"http://apis.baidu.com"


@implementation TTBookRequstFactory

+ (TTRequest *)getBookRequest {
    
    TTRequest *requst = [[TTRequest alloc] initWithRequestType:HRequestType_Get
                                                          host:@"https://api.douban.com"
                                                        method:@"v2/book/1220562"
                                                            modelClass:[TTBookModel class]
                                                        params:nil];
    return requst;
}

+ (TTRequest *)getCityWeatherById:(NSString *)cityId {
    
    NSDictionary *parmas = @{@"area":cityId};
    TTRequest *requst = [[TTRequest alloc] initWithRequestType:HRequestType_Get
                                                          host:@"http://apis.baidu.com"
                                                        method:@"tianyiweather/basicforecast/weatherapi"
                                                    modelClass:[TTBookModel class]
                                                        params:parmas];
    return requst;
}



@end
