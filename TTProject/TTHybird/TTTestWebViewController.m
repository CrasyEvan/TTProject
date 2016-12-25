//
//  TTTestWebViewController.m
//  TTProject
//
//  Created by Evan on 16/9/20.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "TTTestWebViewController.h"

@interface TTTestWebViewController ()

@end

@implementation TTTestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)jumpBaseWebViewController:(id)sender {
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BaseWebViewControllerID"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)jumpWebURL:(id)sender {
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BaseWebViewID"];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
