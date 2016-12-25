

//
//  TTBaseWebViewController.m
//  TTProject
//
//  Created by Evan on 16/9/21.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "TTBaseWebViewController.h"
#import "TTNativeBetweenJSInterface.h"
#import "TTNativeBetweenJSInterfaceMocras.h"

@interface TTBaseWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) TTNativeBetweenJSInterface *nativeJSInterface;

@end

@implementation TTBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configWebView];
}

- (void)configWebView {
    
    self.webView.scrollView.bounces = YES;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.delegate = self;
    
    NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:TestPagePath];
    NSURL *URL = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if(!_nativeJSInterface) {
        _nativeJSInterface = [[TTNativeBetweenJSInterface alloc] init];
        //[_nativeJSInterface setDelegate:self];
    }
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"Native"] = _nativeJSInterface;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}



@end
