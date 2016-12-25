//
//  TTNetErrorCode.h
//  TTProject
//
//  Created by Evan on 16/9/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *TTRequestErrorDomain;

typedef enum : NSUInteger {
    
    TTNetErrorCodeTypeSuccess = 0,
    TTNetErrorCodeTypeInvalidParams = 900001,
    TTNetErrorCodeTypeInvalidResult = 900002,
    TTNetErrorCodeTypeNetValid = 900003,
    
} TTNetErrorCodeType;

@interface TTNetErrorCode : NSObject


/**
 *  将errorcode解析成相应的错误信息
 *
 *  @param code
 *
 *  @return
 */
+ (NSString *)parseErrorCodeMsg:(NSInteger)code;
/**
 *  将errorcode解析成相应的错误信息,
 *
 *  @param code 错误码
 *  @param msg 服务端返回的信息（作为没有对应错误码时的默认值）
 *
 *  @return
 */
+ (NSString *)parseErrorCodeMsg:(NSInteger)code withDefaultMesage:(NSString *)msg;


+ (NSError *)erroWithCode:(NSInteger)code erroMsg:(NSString *)msg;


@end


@interface NSError (TTNetErrorCode)

-(NSString *)errorMsg;

@end


