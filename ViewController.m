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

@interface ViewController ()


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
    self.title = @"首页";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
