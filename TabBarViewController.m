//
//  TabBarViewController.m
//  Watch_Time
//
//  Created by mac on 16/7/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "TabBarViewController.h"
#import "ViewController.h"
#import "CSCViewController.h"
#import "UserViewController.h"

@interface TabBarViewController ()

@property (nonatomic,strong)NSMutableArray * navigationControllArray;

@end


@implementation TabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * navigationArray = @[@"ViewController",@"CSCViewController",@"UserViewController"];
    NSArray * navigationTitle = @[@"首页",@"客服",@"我的"];
  _navigationControllArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < navigationArray.count; i++) {
        
        UIViewController *viewController = [[NSClassFromString(navigationArray[i])alloc] init];
        
        UINavigationController * navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
        [navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
        //设置上标题栏的内容和颜色
        [viewController.navigationItem setTitle:navigationTitle[i]];
        //设置返回键颜色
        [navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        //设置上标题栏颜色
        [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        // tabBar默认图片
        NSString * imageName = [NSString stringWithFormat:@"tabBar%d",i];
        UIImage * image = [UIImage imageNamed:imageName];
        
        viewController.tabBarItem = [[UITabBarItem alloc]initWithTitle:navigationTitle[i] image:image tag:100+i];
//         viewController.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        // tabBar被选中的图片
        NSString * selectImageName = [NSString stringWithFormat:@"selectImage%d",i];
        UIImage * selectImage = [UIImage imageNamed:selectImageName];
        
        viewController.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        
        
        [_navigationControllArray addObject:navigationController];
    }
    self.viewControllers = _navigationControllArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
