//
//  TTBaseViewController.h
//  TTProject
//
//  Created by Evan on 16/8/29.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CloseBtnClickBlock)(void);

@interface TTBaseViewController : UIViewController

@property (nonatomic, assign) BOOL hideNavBar;
@property (nonatomic, assign) BOOL showCloseButton;
@property (nonatomic, copy) CloseBtnClickBlock closeBtnClickBlock;

/**
 *  隐藏网络错误提示界面
 */
- (void)hideNetErrorView;

/**
 *  显示网络错误界面
 */
- (void)showNetErrorViewWithClickBlock:(void (^)(void))clickBlock;

//返回按钮点击后触发
- (void)handleReturnBtnPressed:(id)sender;


@end
