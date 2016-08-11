//
//  CSCViewController.m
//  Watch_Time
//
//  Created by mac on 16/7/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CSCViewController.h"
#import "Reachability.h"
#import "HttpsUtil.h"

#define kWScreen self.view.frame.size.width
#define kHScreen self.view.frame.size.height
#define iOS8  ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES :NO)

#define kContentSizeH 300

#define kContentSizeHForNormal 200

@interface CSCViewController ()
@property (nonatomic, strong)Reachability * reachability;
@end

@implementation CSCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 检测网络状态改变
    // [self p_addNetworkNotoficate];
    
    // 图片手势交互
    // [self p_addHeadView];
    
    // alert弹窗
    // [self p_addAlertView];

}

#pragma mark -------3------- 检测网络状态改变
- (void)p_addNetworkNotoficate
{
    // 监听网络
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    
    //获得Reachability对象
    self.reachability = [Reachability reachabilityForInternetConnection];
    // 开始监听网络
    [self.reachability startNotifier];
}

- (void)networkStateChange
{
    NSLog(@"网络状态改变了");
    [self checkNetworkState];
}

-(void)dealloc
{
    [self.reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 监测网络状态
- (void)checkNetworkState
{
    if ([HttpsUtil checkNetworkState] == UseWifi) {
        NSLog(@"WIFI");
    } else if ([HttpsUtil checkNetworkState] == UseNet) {
        NSLog(@"手机自带网络");
    } else {
        NSLog(@"没有网络");
    }
}



#pragma mark -------2------- 图片手势交互
- (void)p_addHeadView
{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kWScreen, kContentSizeHForNormal)];
    [self.view insertSubview:headView atIndex:0];
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dog"]];
    imageView.frame = CGRectMake(0, 0, kWScreen, kContentSizeHForNormal);
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.userInteractionEnabled = YES;
    imageView.layer.masksToBounds = YES;
    [headView addSubview:imageView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addHeadImageTap)];
    [imageView addGestureRecognizer:tap];
}

- (void)addHeadImageTap
{
    NSLog(@"tap");
}


#pragma mark -------1------- alert弹窗
- (void)p_addAlertView
{
    UIAlertController * alterCon2 = [UIAlertController alertControllerWithTitle:@"警告" message:@"你确定要这样做吗？" preferredStyle:(UIAlertControllerStyleAlert)];
    
    // 改变弹出框背景色 弹出框之外的背景色
    //    alterCon2.view.tintColor = [UIColor lightGrayColor];
    //    alterCon2.view.layer.cornerRadius = 6;
    //    [[UIView appearanceWhenContainedInInstancesOfClasses:[UIAlertController class]] setBackgroundColor:[UIColor lightGrayColor]];
    
    // 弹出数据
    [self presentViewController:alterCon2 animated:YES completion:^{
        //        sleep(1);
        //        [alterCon2 dismissViewControllerAnimated:YES completion:nil];
    }];
    
    // 取消按钮
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        
    }];
    // 确认按钮
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *action) {
        
    }];
    
    [alterCon2 addAction:cancel];
    [alterCon2 addAction:okAction];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
