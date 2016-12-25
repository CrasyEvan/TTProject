//
//  TTRTViewController.m
//  TTProject
//
//  Created by Evan on 16/8/6.
//  Copyright © 2016年 Evan. All rights reserved.
//

/**
 *  runtime
 *  oc是动态语言， oc代码最终都会转换成底层runtime代码
 *  动态的创建类
 *  在程序运行时遍历类的实例变量，属性和方法
 *  在程序运行中动态的创建类、  在类中动态的添加属性和方法
 *  Method Swizzle
 */

#import "TTRuntimeViewController.h"
#import "TTPerson.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation TTRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSwizzLabel];
}


- (void)initSwizzLabel {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
    label.text = @"getMethod";
    [self.view addSubview:label];
}


- (IBAction)getIvar:(id)sender {
    [self testProperties];
}

- (IBAction)getMethod:(id)sender {
    
    //遍历对象方法  .cxx_destruct 隐藏的一个方法，和对象的销毁有关
    TTPerson *person = [TTPerson person];
    Class personClass = person.class;
    unsigned int outCount = 0;

    Method *methodPtr = class_copyMethodList(personClass, &outCount);
    for(NSInteger i = 0; i < outCount; i++) {
        Method method = methodPtr[i];
        SEL selector = method_getName(method);
        NSLog(@"method :%@", NSStringFromSelector(selector));
    }
}


- (IBAction)addProperty:(id)sender {
    /**
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     object:保存到哪个对象中
     key:用什么属性保存传入的值
     value:需保存值
     policy:策略,strong,weak等
     
     // 获取值的方法:
     objc_getAssociatedObject(id object, const void *key);
     object:从哪个对象中获取值
     key: 用什么属性获取值
     */
    TTPerson *person = [TTPerson person];
    objc_setAssociatedObject(person, "weight", @"50KG", OBJC_ASSOCIATION_COPY);
    NSString *weight =  objc_getAssociatedObject(person, "weight");
    NSLog(@"weight: %@", weight);
    
}



- (IBAction)addMethod:(id)sender {
    [self testAddMethod];
}

- (void)testProperties {
    
    //遍历实例变量
    TTPerson *person = [TTPerson person];
    Class personClass = person.class;
    NSLog(@"class: %@", personClass);
    unsigned int outCount = 0;
    Ivar *ivarPtr = class_copyIvarList(personClass, &outCount);
    for (NSInteger i = 0; i < outCount; i++) {
        Ivar ivar = ivarPtr[i];
        NSLog(@"attribute: %s", ivar_getName(ivar));
    }
    
    //遍历属性
    objc_property_t *propertyPtr = class_copyPropertyList(personClass, &outCount);
    for (NSInteger i = 0; i < outCount; i++) {
        objc_property_t property = propertyPtr[i];
        NSLog(@"property: %s", property_getName(property));
    }
    

    [person setAge:@"18"];
    NSLog(@"age1:%@", person.age);
    
    objc_msgSend(person, @selector(setAge:), @"20");
    NSLog(@"age2:%@", person.age);
    
}

- (void)testAddMethod {
    TTPerson *person = [TTPerson person];
    [person performSelector:@selector(studyEngilsh)];

}






@end
