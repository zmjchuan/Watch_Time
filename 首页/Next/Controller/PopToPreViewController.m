//
//  PopToPreViewController.m
//  Watch_Time
//
//  Created by mac on 16/9/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PopToPreViewController.h"
#import "ViewController.h"

@interface PopToPreViewController ()

@end

@implementation PopToPreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资源包(购买)";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backToPreVCClickButtonItem:)];
}

- (void)backToPreVCClickButtonItem:(UIBarButtonItem *)sender
{
    for (UIViewController *temp in self.navigationController.viewControllers) {
        
        if ([temp isKindOfClass:[ViewController class]]) {
            
            [self.navigationController popToViewController:temp animated:YES];}
        
    }

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
