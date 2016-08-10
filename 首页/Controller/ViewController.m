//
//  ViewController.m
//  Watch_Time
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "SliderViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThiredViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "SevenViewController.h"
#import "XTPopView.h"

#import "DownloadViewController.h"
#import "PublishViewController.h"
#import "HistoryViewController.h"

@interface ViewController ()<selectIndexPathDelegate>

@property(strong,readwrite,nonatomic)UIButton *button;
@property (nonatomic, strong) UIButton *customBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    FirstViewController * first = [[FirstViewController alloc]init];
    first.title = @"推荐";
    SecondViewController * second = [[SecondViewController alloc]init];
    second.title = @"房产";
    ThiredViewController * third = [[ThiredViewController alloc]init];
    third.title = @"美女";
    FourViewController * four = [[FourViewController alloc]init];
    four.title = @"极限";
    FiveViewController * five = [[FiveViewController alloc]init];
    five.title = @"房产";
    SixViewController * six = [[SixViewController alloc]init];
    six.title = @"美女";
    SevenViewController * seven = [[SevenViewController alloc]init];
    seven.title = @"极限";
    
    NSArray * subViewController = @[first,second,third,four,five,six,seven];
    
    SliderViewController * sliderVC = [[SliderViewController alloc]initWithSubViewControllers:subViewController];
    sliderVC.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:sliderVC.view];
    [self addChildViewController:sliderVC];
  
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"LOGO" style:(UIBarButtonItemStyleDone) target:nil action:nil];
    
    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(0, 0, 40, 40);
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    self.customBtn = addBtn;
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:_customBtn];
    
    UIBarButtonItem * downLoadBtn = [[UIBarButtonItem alloc]initWithTitle:@"下载" style:(UIBarButtonItemStyleDone) target:self action:@selector(downLoadBtnClick)];
    UIBarButtonItem * historyBtn = [[UIBarButtonItem alloc]initWithTitle:@"历史" style:(UIBarButtonItemStyleDone) target:self action:@selector(historyBtnClick)];
    self.navigationItem.rightBarButtonItems = @[btn,downLoadBtn,historyBtn];
}

#pragma mark --  发布 +
-(void)addClick
{
    NSLog(@"发布");
    // PublishViewController
    CGPoint point = CGPointMake(_customBtn.center.x,_customBtn.frame.origin.y + 64);
    XTPopView *view1 = [[XTPopView alloc] initWithOrigin:point Width:130 Height:40 * 4 Type:XTTypeOfUpRight Color:[UIColor blackColor]];
    view1.dataArray = @[@"发起群聊",@"添加朋友", @"扫一扫", @"收付款"];
    view1.images = @[@"发起群聊",@"添加朋友", @"扫一扫", @"付款"];
    view1.fontSize = 13;
    view1.row_height = 40;
    view1.titleTextColor = [UIColor whiteColor];
    view1.delegate = self;
    [view1 popView];
   
}
- (void)selectIndexPathRow:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSLog(@"Click 0 ......");
        }
            break;
        case 1:
        {
            NSLog(@"Clikc 1 ......");
        }
            break;
        case 2:
        {
            NSLog(@"Clikc 2 ......");
        }
            break;
        case 3:
        {
            NSLog(@"Clikc 3 ......");
        }
            break;
        default:
            break;
    }
}

#pragma mark -- 下载
-(void)downLoadBtnClick
{
     NSLog(@"下载");
    DownloadViewController * downloadVC = [[DownloadViewController alloc]init];
    self.tabBarController.tabBar.hidden=YES;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:downloadVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

#pragma  mark -- 最近观看
-(void)historyBtnClick
{
     NSLog(@"历史");
    HistoryViewController * historyVC = [[HistoryViewController alloc]init];
    self.tabBarController.tabBar.hidden=YES;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:historyVC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
