
//
//  TTBaseWebViewController.m
//  TTProject
//
//  Created by Evan on 16/9/20.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "TTWebViewBridgeController.h"
#import <WebViewJavascriptBridge.h>


@interface TTWebViewBridgeController ()<UIWebViewDelegate>

@property (nonatomic, strong) WebViewJavascriptBridge *bridge;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TTWebViewBridgeController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 2.加载网页
    NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:indexPath encoding:NSUTF8StringEncoding error:nil];
    NSAssert(appHtml != nil, @"未获取到本地html文件");
    NSURL *baseUrl = [NSURL fileURLWithPath:indexPath];
    [self.webView loadHTMLString:appHtml baseURL:baseUrl];
    
    // 3.开启日志
    [WebViewJavascriptBridge enableLogging];
    
    // 4.给webView建立JS和OC的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    
    
    /* JS调用OC的API:访问相册 */
    [self.bridge registerHandler:@"openCamera" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"需要%@图片", data[@"count"]);
        
        UIImagePickerController *imageVC = [[UIImagePickerController alloc] init];
        imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imageVC animated:YES completion:nil];
    }];
    
    
    /* JS调用OC的API:访问底部弹窗 */
    [self.bridge registerHandler:@"showSheet" handler:^(id data, WVJBResponseCallback responseCallback) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"你猜我谈不谈?"
                                                                    message:@"不谈不谈,就不谈!!"
                                                             preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [vc addAction:cancelAction];
        [vc addAction:okAction];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}

- (IBAction)insertImage:(UIButton *)sender {
    
}

- (IBAction)alert:(UIButton *)sender {
    // 调用JS中的API
    [self.bridge callHandler:@"alertMessage"
                        data:@"调用了js中的Alert弹窗!" responseCallback:^(id responseData) {
        
    }];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];

}

- (IBAction)getUserInfo:(id)sender {
    
    // 调用JS中的API
    [self.bridge callHandler:@"getUserInfo" data:@{@"userId":@"DX001"} responseCallback:^(id responseData) {
        NSString *userInfo = [NSString stringWithFormat:@"%@,姓名:%@,年龄:%@", responseData[@"userID"], responseData[@"userName"], responseData[@"age"]];
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"从网页端获取的用户信息" message:userInfo preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        [vc addAction:cancelAction];
        [vc addAction:okAction];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}


- (IBAction)jumpAction:(id)sender {
    // 调用JS中的API
    [self.bridge callHandler:@"pushToNewWebSite" data:@{@"url":@"http://m.jd.com"} responseCallback:^(id responseData) {
        
    }];
}


@end
