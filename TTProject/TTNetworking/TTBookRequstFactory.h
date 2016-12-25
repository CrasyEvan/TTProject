//
//  HHBookRequstFactory.h
//  TTProject
//
//  Created by Evan on 16/8/23.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTRequest.h"

#define kBookRequest

@interface TTBookRequstFactory : NSObject

+ (TTRequest *)getBookRequest;
+ (TTRequest *)getCityWeatherById:(NSString *)cityId;


@end
