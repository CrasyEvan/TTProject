//
//  AppDelegate.m
//  TTProject
//
//  Created by Evan on 16/7/27.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "AppDelegate.h"
#import "CocoaLumberjack.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window.backgroundColor = [UIColor whiteColor];
    
    //    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
    //    for (int i = 0; i< 10000; i++) {
    //        [MJStudent mj_objectWithKeyValues:dict];
    //    }
    //    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    //    MJExtensionLog(@"%f", end - begin);
    
    [TTLogger setUp];
    application.applicationSupportsShakeToEdit = YES;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
}




- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    NSLog(@"motionBegan");
    
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}



@end
