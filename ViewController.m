//
//  ViewController.m
//  Watch_Time
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"

#define watchW 200
#define per
@interface ViewController ()

@property (nonatomic,strong)UIImageView * watch;

@property (nonatomic,strong)CALayer * second;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _watch = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, watchW, watchW)];
    _watch.backgroundColor = [UIColor yellowColor];
    _watch.layer.cornerRadius = watchW/2;
    [self.view addSubview:_watch];
 
    // 添加分钟
    [self addSeconds];
    
    

    // 自动启动
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    
     [self updateTimer];
}

- (void)updateTimer
{
    // 获取当前的日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * dateComp = [calendar components:(NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:[NSDate date]];
    CGFloat seconds = dateComp.second;
    CGFloat angle = seconds*6;
    CGFloat radian = angle/180*M_PI;
    _second.transform = CATransform3DMakeRotation(radian, 0, 0, 1);
}

- (void)addSeconds
{
    _second = [CALayer layer];
    _second.position = CGPointMake(watchW/2, watchW/2);
    _second.anchorPoint = CGPointMake(0.5, 1);
    _second.bounds = CGRectMake(0, 0, 1, watchW/2-20);
    _second.backgroundColor = [UIColor redColor].CGColor;
    [_watch.layer addSublayer:_second];
}


@end
