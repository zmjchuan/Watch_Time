//
//  ResultViewController.m
//  Watch_Time
//
//  Created by mac on 16/9/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ResultViewController.h"
#import "DownloadViewController.h"
#import "OrderListViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"支付结果";
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonIte}
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backToPreVCClickButtonItem:)];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    UIButton * btn;
    btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(100, 200, 60, 100);
    [btn setTitle:@"查看订单详情" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)clickBtn:(UIButton *)sender
{
    OrderListViewController * listVC = [[OrderListViewController alloc]init];
    [self.navigationController pushViewController:listVC animated:YES];
}

- (void)backToPreVCClickButtonItem:(UIBarButtonItem *)sender
{
    for (UIViewController *temp in self.navigationController.viewControllers) {
        
        if ([temp isKindOfClass:[DownloadViewController class]]) {
            
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
    
    for (UIViewController *temp2 in self.navigationController.viewControllers) {
        
        if ([temp2 isKindOfClass:[OrderListViewController class]]) {
            
            [self.navigationController popToViewController:temp2 animated:YES];
        }
    }
    
//    int index = (int)[[self.navigationController viewControllers]indexOfObject:self];
//    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(index-3)] animated:YES];
    
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
