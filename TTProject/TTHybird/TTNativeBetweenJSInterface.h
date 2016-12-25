//
//  TTNativeBetweenJSInterface.h
//  TTProject
//
//  Created by Evan on 16/9/21.
//  Copyright © 2016年 Evan. All rights reserved.
//
/*
 * JavaScript 和 native 接口, 通过该对象实现JS的行为
 */

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol NativeBetweenJSInterfaceProtocol <JSExport>

/*
 * 字符串
 */
- (void)testString:(NSString *)phone;

/*
 * 数组
 */
- (void)testArray:(NSArray *)array;

/*
 * 带两个参数
 */
-(void)testMethodWithParam1:(NSString *)param1 param2:(NSString *)param2;


/*
 * 带两个参数
 */
-(void)test:(NSNumber *)param1 method:(NSString *)param2;

@end

@interface TTNativeBetweenJSInterface : NSObject

@property (nonatomic, weak)id<NativeBetweenJSInterfaceProtocol> delegate;

@end
