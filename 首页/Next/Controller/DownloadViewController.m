//
//  DownloadViewController.m
//  Watch_Time
//
//  Created by mac on 16/8/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DownloadViewController.h"
#import "ResourceViewController.h"

@interface DownloadViewController ()

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.title = @"资源列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc
                                               ]initWithTitle:@"push" style:(UIBarButtonItemStyleDone) target:self action:@selector(pushToVCClick:)];
}

- (void)pushToVCClick:(UIBarButtonItem *)item
{
    ResourceViewController * popVC = [[ResourceViewController alloc]init];
    
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
