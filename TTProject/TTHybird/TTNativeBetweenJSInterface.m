


//
//  TTNativeBetweenJSInterface.m
//  TTProject
//
//  Created by Evan on 16/9/21.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "TTNativeBetweenJSInterface.h"

@interface TTNativeBetweenJSInterface()<NativeBetweenJSInterfaceProtocol>

@end

@implementation TTNativeBetweenJSInterface


- (void)testString:(NSString *)string {
    NSLog(@"string:%@", string);
}


- (void)testArray:(NSArray *)array {
    NSLog(@"array:%@", array);
}

-(void)testMethodWithParam1:(NSString *)param1 param2:(NSString *)param2{
    NSLog(@"param1:%@, param2:%@ ",param1, param2);
}

-(void)test:(NSNumber *)param1 method:(NSString *)param2{
    NSLog(@"param1:%@, param2:%@ ",param1, param2);
}


@end
