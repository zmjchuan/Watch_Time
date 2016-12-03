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
#import "NextViewController.h"
#import  <AVFoundation/AVFoundation.h>
#import "ScanViewController.h"
#import "ScanView.h"

#define kWScreen self.view.frame.size.width
#define kHScreen self.view.frame.size.height
#define iOS8  ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES :NO)

#define kContentSizeH 300

#define kContentSizeHForNormal 200

@interface CSCViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong)Reachability * reachability;


// 5
@property (nonatomic,strong)AVCaptureDevice * device;  //设备的设置属性
@property (nonatomic,strong)AVCaptureDeviceInput * deviceInput;
@property (nonatomic,strong)AVCaptureMetadataOutput * output;
@property (nonatomic,strong)AVCaptureSession * session; // 管理输入流和输出流
@property (nonatomic,strong)AVCaptureVideoPreviewLayer * previewLayer; //和AVCaptureSession配合使用

@property (nonatomic,strong)ScanView * sacnView;

@end

@implementation CSCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 检测网络状态改变
    // [self p_addNetworkNotoficate];
    
    // 图片手势交互
//     [self p_addHeadView];
    
    // alert弹窗
//     [self p_addAlertView];
    
    // 5二维码扫描
//    [self scan_firstStep];
//    [self scanViewFrame];

}
#pragma mark
#pragma mark -------5------- 全屏扫码
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 开始扫码
    [self.session startRunning];
}

- (void)scan_firstStep
{
   // 1、创建 AVMediaTypeVideo,这个方法将返回内置的摄像头,主要是用于捕获和记录
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    
    // 2.这个可以设置有效范围的，也就是限定有效扫描范围
    _output = [[AVCaptureMetadataOutput alloc]init];// 下一步的代理
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
     //扫描框图上界距离屏幕上界的距离占屏幕的比例为rateFromScreenTop
    CGRect  _mFrame = [[UIScreen mainScreen] bounds];
     float rateFromScreenTop = (_mFrame.size.height/2 - 0.3*_mFrame.size.width)/_mFrame.size.height;
     //以下设置扫描范围的在屏幕中的比例，分别是上边，右边，高度，宽度
     //设置扫描范围为摄像头预览大小的x,0.2,h,0.6, h=w 摄像头预览大小为当前_mFrame为屏幕－状态栏－标题栏navigationBar－导航栏tabBar的高度
     self.output.rectOfInterest = CGRectMake(rateFromScreenTop,0.2f,(1-2*rateFromScreenTop),0.6f);
    
    
    
    _session = [[AVCaptureSession alloc]init];
    // 捕获会话预设设置：高质量的视频音频输出
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.deviceInput])
    {
        [_session addInput:self.deviceInput];
        
    }
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    /*
      可以在这里判断 设备相机权限
     // 判断是否有相机权限
     NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
     AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
     if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
     
     UIAlertView * alert = [[UIAlertView alloc]initWithTitle:CAMERA_PERMISSIONS message:nil delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
     _isAccessCamera = NO;
     [alert show];
     return ;
     }
     */
    
     //扫码类型
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    
    // 扫描的范围
    _previewLayer.frame = [UIScreen mainScreen].bounds;
    
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
}

#pragma mark -- 扫描的范围设置
- (void)scanViewFrame
{
    CGRect _mFrame = [UIScreen mainScreen].bounds;
    self.sacnView = [[ScanView alloc]initWithFrame:self.view.bounds setSacnView:CGRectMake(0.2*_mFrame.size.width,(_mFrame.size.height-0.6*_mFrame.size.width)/2, 0.6*_mFrame.size.width,0.6*_mFrame.size.width)];
    [self.view addSubview:self.sacnView];
}


#pragma mark -- AVCaptureMetadataOutputObjectsDelegate的代理
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [_session stopRunning];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        // 当然可以在这里定义一个二维码网址类型是否和你想要的类型匹配的判断
        stringValue = metadataObject.stringValue;
        [self pushNextView:stringValue];
    }
}

- (void)pushNextView:(NSString *)string
{
    ScanViewController * scanVC = [[ScanViewController alloc]init];
    scanVC.string =string;
    [self.navigationController pushViewController:scanVC animated:YES];
}


//页面即将消失的时候关闭摄像头
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.session stopRunning];
}


#pragma mark
#pragma mark -------4------- 表格
- (void)p_addList
{
   
}

#pragma mark
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


#pragma mark
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
    NextViewController * next = [[NextViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:next animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark
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
