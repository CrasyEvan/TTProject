
//
//  HHNetController.m
//  TTProject
//
//  Created by Evan on 16/8/22.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "TTNetController.h"
#import "TTRequest.h"
#import <AFNetworking.h>
#import "TTBookRequstFactory.h"
#import "MJExtension.h"

@interface TTNetController ()

@property (nonatomic, strong) TTRequest *bookRequest;
@property (nonatomic, strong) TTRequest *weatherRequest;
@end

@implementation TTNetController


- (void)viewDidLoad {
    
}

- (TTRequest *)bookRequest {
    
    if(!_bookRequest) {
        _bookRequest = [TTBookRequstFactory getBookRequest];
    }
    return _bookRequest;
}

- (TTRequest *)weatherRequest {
    
    if(!_weatherRequest) {
        _weatherRequest = [TTBookRequstFactory getCityWeatherById:@"101010100"];
    }
    return _weatherRequest;
}

- (IBAction)GetRequest:(id)sender {
    
//    [self.bookRequest sendRequestWithComplete:^(NSDictionary *info,
//                                                TTRequestModel *requestModel,
//                                                TTCallBackStatus status, NSError *err) {
//        NSLog(@"info:%@", info);
//    }];
    UIStoryboard *secondStoryboard = [UIStoryboard storyboardWithName:@"second" bundle:nil];
    UIViewController *firstVC = [secondStoryboard instantiateViewControllerWithIdentifier:@"testStoryVC1"];
    [self.navigationController pushViewController:firstVC animated:YES];
    
}
- (IBAction)getRuquestWithParams:(id)sender {
    [self.weatherRequest sendRequestWithComplete:^(NSDictionary *info,
                                                   TTRequestModel *requestModel,
                                                   TTCallBackStatus status, NSError *err) {
        if(status == TCallBackStatus_Succ) {
            NSLog(@"info:%@", info);

        }else {
            NSLog(@"err:%@", err);
        }

    }];
}

@end
