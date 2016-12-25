//
//  TTNetErrorCode.m
//  TTProject
//
//  Created by Evan on 16/9/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "TTNetErrorCode.h"

NSString *TTRequestErrorDomain = @"PAFFRequestErrorDomain";

@implementation TTNetErrorCode

+ (NSString *)parseErrorCodeMsg:(NSInteger)code{
    switch (code) {
        case TTNetErrorCodeTypeInvalidParams:
            return NSLocalizedString(@"参数错误", @"错误码");
        case TTNetErrorCodeTypeInvalidResult:
            return NSLocalizedString(@"解析错误", @"错误码");
        default:
            return @"网络错误, 请稍后重试";
    }
    return nil;
}
+ (NSString *)parseErrorCodeMsg:(NSInteger)code withDefaultMesage:(NSString *)msg{
    
    //如果服务端没有返回错误信息，默认提示网络错误
    msg = msg ? msg:@"网络错误, 请稍后重试";
    
    switch (code) {
        default:
            return msg;
    }
    return nil;
}

+ (NSError *)erroWithCode:(NSInteger)code erroMsg:(NSString *)msg {
    msg = msg ? msg:@"网络错误, 请稍后重试";
    return [NSError errorWithDomain:TTRequestErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:msg}];
}

@end


@implementation NSError (TTNetErrorCode)

-(NSString *)errorMsg {
    if (self.userInfo[NSLocalizedRecoverySuggestionErrorKey]) {
        return [self.userInfo[NSLocalizedRecoverySuggestionErrorKey] description];
    }
    if (self.userInfo[NSLocalizedFailureReasonErrorKey]) {
        return [self.userInfo[NSLocalizedFailureReasonErrorKey] description];
    }
    if (self.userInfo[NSLocalizedFailureReasonErrorKey]) {
        return [self.userInfo[NSLocalizedDescriptionKey] description];
    }
    if (self.userInfo[NSLocalizedDescriptionKey]) {
        return [self.userInfo[NSLocalizedDescriptionKey] description];
    }
    NSString *msg = [TTNetErrorCode parseErrorCodeMsg:self.code];
    if (msg) {
        return msg;
    }
    return @"网络错误，请稍后重试";
}

@end





