//
//  SliderViewController.m
//  Watch_Time
//
//  Created by mac on 16/7/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SliderViewController.h"

#define DCScreenW    [UIScreen mainScreen].bounds.size.width
#define DCScreenH    [UIScreen mainScreen].bounds.size.height

@interface SliderViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIButton * oldBtn; //

@property (nonatomic,strong)NSArray * VCArr; // 子视图控制器数组

@property (nonatomic,strong)UIScrollView * topBar; // 滑动条

@property (nonatomic,strong)UIScrollView * contentView; // 添加子视图
@property (nonatomic,assign)CGFloat btnW;

@property (nonatomic, weak) UIView *slider; // 滑动的线条

@end

@implementation SliderViewController


- (instancetype)initWithSubViewControllers:(NSArray *)subViewControllers
{
    if (self = [super init]) {
        _VCArr = subViewControllers;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 滑动条
    [self addTopBar];
    
    // 滑动slider
    [self addSliderView];
    
    // 添加view
    [self addViewController];
}

#pragma mark -- 添加滑动条
- (void)addTopBar
{
    if (self.VCArr.count == 0) return;
    
    NSInteger count = _VCArr.count;
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DCScreenW, 44)];
//    scrollView.backgroundColor = [UIColor yellowColor];
    self.topBar = scrollView;
    self.topBar.bounces = NO;
    [self.view addSubview:self.topBar];
    
    _btnW = DCScreenW / count;
    
    for (int i = 0; i < count; i++) {
        UIViewController * vc = self.VCArr[i];
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i*_btnW, -64, _btnW, 44)];
        btn.tag = 1000+i;
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        [btn setTitle:vc.title forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn.titleLabel setFont:[UIFont fontWithName:@"CourierNewPS-ItalicMT" size:14]];
        [self.topBar addSubview:btn];
        if (i == 0) {
            btn.selected = YES;
            //默认one文字放大
            btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
            _oldBtn = btn;
        }
    }
   // 不需要改变topBar的scrollView的contentSize
   self.topBar.contentSize = CGSizeMake(self.btnW *count, -64);
}
-(void)click:(UIButton *)sender
{
    if (sender.selected) return;
    self.oldBtn.selected = NO;
    sender.selected = YES;
    // 当前显示的区域相对frame顶点的偏移量
    self.contentView.contentOffset = CGPointMake((sender.tag-1000)*DCScreenW, 0);
    // 被选中的字体改变
    [UIView animateWithDuration:0.3 animations:^{
       sender.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
    _oldBtn.transform = CGAffineTransformIdentity;
    _oldBtn = sender;
    
//    //判断导航条是否需要移动
//    CGFloat maxX = CGRectGetMaxX(self.slider.frame); // slider最大值
      // 最大值比屏大 && 按钮的tag值 不等于
//    if(maxX >=DCScreenW  && sender.tag != self.VCArr.count + 10000 - 1)
//    {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.topBar.contentOffset = CGPointMake(maxX - DCScreenW + self.btnW, -64);
//        }];
//    }else if(maxX < DCScreenW)
//    {
//        [UIView animateWithDuration:0.3 animations:^{
//            self.topBar.contentOffset = CGPointMake(0, -64);
//        }];
//    };
}

#pragma mark -- slider
- (void)addSliderView
{
    if(self.VCArr.count == 0) return;
    UIView * slider = [[UIView alloc]initWithFrame:CGRectMake(0, 41-64, _btnW, 3)];
    slider.backgroundColor = [UIColor purpleColor];
    [self.topBar addSubview:slider];
    _slider = slider;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //
    _slider.frame = CGRectMake(scrollView.contentOffset.x/DCScreenW * _btnW, 41-64, _btnW, 3);
}

//判断是否切换导航条按钮的状态
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offx = scrollView.contentOffset.x;
    int tag = (int)(offx/DCScreenW + 0.5)+1000;
    UIButton * btn = [self.view viewWithTag:tag];
    if (tag != _oldBtn.tag) {
        [self click:btn];
    }
}

#pragma mark -- 添加ViewController
- (void)addViewController
{
   UIScrollView *contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0+44, DCScreenW, DCScreenH -44)];
     self.contentView = contentView;
    self.contentView.bounces = NO;
    contentView.delegate = self;
    contentView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:contentView];
    
    NSInteger count = _VCArr.count;
    for (int i = 0; i < count; i++) {
        UIViewController * vcc = _VCArr[i];
        [self addChildViewController:vcc];
        vcc.view.frame = CGRectMake(i*DCScreenW, 0, DCScreenW, DCScreenH);
        [contentView addSubview:vcc.view];
    }
    contentView.contentSize = CGSizeMake(count*DCScreenW, DCScreenH - 44);
    contentView.pagingEnabled = YES;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
