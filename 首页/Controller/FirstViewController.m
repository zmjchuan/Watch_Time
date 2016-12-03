//
//  FirstViewController.m
//  Watch_Time
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FirstViewController.h"
#import "HttpsUtil.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
   //2
    NSMutableArray * array = [NSMutableArray array];
    [array addObject:@"3"];
//    [array addObject:nil];
    
    // 1
    NSMutableArray * arr = [[NSMutableArray alloc]initWithObjects:@"22",@"33",nil, nil];
    NSLog(@"ar%@",arr);
  
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
