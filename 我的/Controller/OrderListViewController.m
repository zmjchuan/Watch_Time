
//
//  OrderListViewController.m
//  Watch_Time
//
//  Created by mac on 16/9/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderViewController.h"

@interface OrderListViewController ()
@property (nonatomic,strong)UIButton * btn1;
@property (nonatomic,strong)UIButton * btn2;
@end

@implementation OrderListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单列表";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _btn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _btn1.frame = CGRectMake(10, 80, 60, 40);
    
    [_btn1 setTitle:@"已支付" forState:UIControlStateNormal];
    _btn1.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_btn1];
    
    
    _btn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _btn2.frame = CGRectMake(10, 200, 60, 40);
      [_btn2 setTitle:@"待支付" forState:UIControlStateNormal];
     _btn2.backgroundColor = [UIColor redColor];
    [self.view addSubview:_btn2];
    
    [_btn2 addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)clickBtn:(UIButton *)sender
{
    OrderViewController * orderVC = [[OrderViewController alloc]init];
    [self.navigationController pushViewController:orderVC animated:YES];
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
