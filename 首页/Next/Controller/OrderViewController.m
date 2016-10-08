//
//  OrderViewController.m
//  Watch_Time
//
//  Created by mac on 16/9/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "OrderViewController.h"
#import "ResultViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提交订单(确认支付）";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc
                                               ]initWithTitle:@"push" style:(UIBarButtonItemStyleDone) target:self action:@selector(pushToVCClick:)];
}

- (void)pushToVCClick:(UIBarButtonItem *)item
{
    ResultViewController * popVC = [[ResultViewController alloc]init];
    
    [self.navigationController pushViewController:popVC animated:YES];
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
