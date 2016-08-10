//
//  CSCViewController.m
//  Watch_Time
//
//  Created by mac on 16/7/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CSCViewController.h"


#define kWScreen self.view.frame.size.width
#define kHScreen self.view.frame.size.height
#define iOS8  ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES :NO)

#define kContentSizeH 300

#define kContentSizeHForNormal 200

@interface CSCViewController ()

@end

@implementation CSCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    NSLog(@"'tap");
}


- (void)addAlertView
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

//@interface ViewController ()<UIPopoverPresentationControllerDelegate, UIAdaptivePresentationControllerDelegate>
//@end
//@implementation ViewController
//
//- (void)viewDidLoad {    [super viewDidLoad];}
//
//- (IBAction)show:(id)sender
//{    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    TestViewController *contentViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([TestViewController class])];
//    contentViewController.modalPresentationStyle. = UIModalPresentationPopover;
//    UIPopoverPresentationController *detailPopover = contentViewController.popoverPresentationController;
//    detailPopover.delegate = self;
//    detailPopover.barButtonItem = sender;
//    detailPopover.permittedArrowDirections = UIPopoverArrowDirectionAny;
//    [self presentViewController:contentViewController animated:YES completion:nil];}
//
//- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
//{    return UIModalPresentationNone;}
//
//- (UIViewController *)presentationController:(UIPresentationController *)controller viewControllerForAdaptivePresentationStyle:(UIModalPresentationStyle)style
//{    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller.presentedViewController];
//    return navController;
//}

@end
