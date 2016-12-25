//
//  TTBaseViewController.m
//  TTProject
//
//  Created by Evan on 16/8/29.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "TTBaseViewController.h"
#import "UIColor+Hex.h"

#import "FLEXManager.h"

#ifdef DEBUG

#import "FLEXManager.h"
#define SHOWFLEXDEBUG

#endif

#define kBackgroundColor [UIColor colorWithHexString:@"#f7f7f7"]

@interface TTBaseViewController ()

@property (nonatomic, strong) UIView * netErrorView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *baseCloseButton;

@property (nonatomic, assign) BOOL backButtonHidden; //返回按钮是否隐藏

@end

@implementation TTBaseViewController


- (void)dealloc {

}

- (void)viewWillAppear:(BOOL)animated {
    [self setupNavBar];
    NSArray *vcArray = self.navigationController.viewControllers;
    if (vcArray != nil && [vcArray count] > 1) {
        _backButton.hidden = NO || _backButtonHidden; // 外部如何设置则以外部设置为主
    }else{
        _backButton.hidden = YES & _backButtonHidden;
    }
    
#ifdef kStatusBarStyle
    [[UIApplication sharedApplication] setStatusBarStyle:kStatusBarStyle animated:YES];
#else
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
#endif
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initBaseView];
}

- (void)setupNavBar {
    [self updateNavBar];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
}

#pragma mark - Property
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
}

- (void)initBaseView{
    
    self.view.backgroundColor = kBackgroundColor;
}

- (void)updateNavBar {
    
    self.navigationController.navigationBarHidden = self.hideNavBar;
}

- (void)hideNetErrorView {
    
}


- (void)showNetErrorViewWithClickBlock:(void (^)(void))clickBlock {
    
}


- (void)handleReturnBtnPressed:(id)sender {
    
}

#pragma mark <Rotate>
- (BOOL)shouldAutorotate {
    //所有ViewController 默认不旋转,有个别需求的,请在子类中重载这3个方法
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    //所有ViewController 默认只支持竖屏朝上,有个别需求的,请在子类中重载这个方法
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
#ifdef SHOWFLEXDEBUG
    [[FLEXManager sharedManager] showExplorer];
#endif
    
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}


@end
