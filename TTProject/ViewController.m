//
//  ViewController.m
//  TTProject
//
//  Created by Evan on 16/7/27.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "ViewController.h"
#import "TTRuntimeViewController.h"
#import "TTTestWebViewController.h"
#import "TTCoreDataViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *listView;
@property (nonatomic, strong) NSArray *demoLists;
@property (nonatomic, strong) UIImageView *barImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    self.barImageView = self.navigationController.navigationBar.subviews.firstObject;
//    self.barImageView.alpha = 0.0f;
    
    self.navigationItem.title = @"Function List";
    self.listView.delegate = self;
    self.listView.dataSource = self;
    self.demoLists = @[@"运行时demo", @"网络", @"Hybrid", @"数据-模型转换", @"数据库sqlite", @"CoreData"];
    
//    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
//    LogError(@"Test Error System!");
    
    //[self testMutableCopy];
    
    

}


//- (void)testCopy {
//    
//    NSArray *array = @[@"array1", @"array2", @"array3"];
//    NSArray *copyArray = [array copy];
//    
//    LogInfo(@"array: %p", array);
//    LogInfo(@"cppyArray: %p", copyArray);
//}

//- (void)testMutableCopy {
//    
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
//    [array addObject:@"array1"];
//    [array addObject:@"array2"];
//    [array addObject:@"array3"];
//    NSMutableArray *copyArray = [array mutableCopy];
//   
//    LogInfo(@"array: %p", array);
//    
//    LogInfo(@"cppyArray: %p", copyArray);
//    
//    //
//    for (NSString *str in array) {
//        LogInfo(@"copy前str: %p", str);
//    }
//    
//    //
//    for (NSString *str in copyArray) {
//        LogInfo(@"copy后str: %p", str);
//    }
//}


#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _demoLists.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    //cell.backgroundColor = [UIColor magentaColor];
    cell.textLabel.text = _demoLists[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.listView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *targetViewController = nil;
    switch (indexPath.row) {
        case 0:
        {
            targetViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"runtimeID"];
        }
            break;
        case 1:
        {
            targetViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HHNetWork"];
        }
            break;
        case 2:
        {
            targetViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TestWebViewID"];
        }
            break;
        case 3:
        {
            targetViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DataParserID"];
        }
            break;
        case 4:
        {
            targetViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"sqliteViewControllerID"];
        }
            break;
        case 5:
        {
            targetViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CoreDataVC"];
        }
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:targetViewController animated:YES];

}



@end
