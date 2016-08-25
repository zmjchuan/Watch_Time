//
//  NextViewController.m
//  Watch_Time
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NextViewController.h"
#import "Masonry.h"

#define  kWScreen  [UIScreen mainScreen].bounds.size.width
#define  kHScreen  [UIScreen mainScreen].bounds.size.height
@interface NextViewController ()

@property (nonatomic,strong)UIView * firstView;

@property (nonatomic,strong)UIView * secondView;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 适配
    self.navigationItem.title = @"Masonry约束";
    [self p_addMasonry];
    [self p_addMansoryScrollView];
    
    // 正常的
    // [self p_scrollView];
}

- (void)p_scrollView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(10, 100, kWScreen-20, kHScreen-200)];
    view.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:view];
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(view.frame)-10, CGRectGetHeight(view.frame)-10)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(view.frame)-10, 100*10);
    [view addSubview:scrollView];
    
    int count = 10;
    
    for ( int i = 1 ; i <= count ; ++i )
    {
        UIView *subv = [UIView new];
        [scrollView addSubview:subv];
        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        
       
        subv.frame = CGRectMake(0, 100*(i-1), CGRectGetWidth(view.frame)-10, 100);
    }
    

}

#pragma mark -- masonry的适配
- (void)p_addMasonry
{
    self.firstView = [[UIView alloc]init];
    self.firstView.backgroundColor = [UIColor yellowColor];
    // 必须先添加view
    [self.view addSubview:self.firstView];
    
    /*
     - (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *make))block;
     - (NSArray *)mas_updateConstraints:(void(^)(MASConstraintMaker *make))block;
     - (NSArray *)mas_remakeConstraints:(void(^)(MASConstraintMaker *make))block;
     
     mas_makeConstraints 只负责新增约束 Autolayout不能同时存在两条针对于同一对象的约束 否则会报错
     mas_updateConstraints 针对上面的情况 会更新在block中出现的约束 不会导致出现两个相同约束的情况
     mas_remakeConstraints 则会清除之前的所有约束 仅保留最新的约束
     三种函数善加利用 就可以应对各种情况了
     */
    
    //mas_makeConstraints就是Masonry的autolayout添加函数 将所需的约束添加到block中行了
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // 1.self.fisteView的frame 在 父视图（superView）self.view中心
        make.center.equalTo(self.view);
        
        //将size设置成(300,300)
        make.size.mas_equalTo(CGSizeMake(300, 300));
        // 直接设置高度
        // make.height.mas_equalTo(@150);
    }];
    
    self.secondView = [[UIView alloc]init];
    self.secondView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.secondView];
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 1.size
        make.size.mas_equalTo(CGSizeMake(10, 10));
       
        // 2.距离上面view
        // -----没有缝隙
        // make.top.mas_equalTo(self.firstView.mas_bottom);
        
        // -----为10
         make.top.mas_equalTo(self.firstView.mas_bottom).with.offset(10);
        
        // 3.左侧相同
        make.left.mas_equalTo(self.firstView.mas_left);
    }];
    
    /*
     让一个view略小于其superView(边距为10)
     make.edges.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
     ==>等价于
     make.top.equalTo(sv).with.offset(10);
     make.left.equalTo(sv).with.offset(10);
     make.bottom.equalTo(sv).with.offset(-10);
     make.right.equalTo(sv).with.offset(-10);
     ==>也等价于make.top.left.bottom.and.right.equalTo(sv).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
     */
}

// 在UIScrollView顺序排列一些view并自动计算contentSize
- (void)p_addMansoryScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentOffset = CGPointMake(0, -64);
    [self.firstView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 内边距top left bottom right
        make.edges.equalTo(self.firstView).with.insets(UIEdgeInsetsMake(5,5,5,5));
    }];
    
    UIView *container = [UIView new];
    container.backgroundColor = [UIColor blackColor];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
       
    }];
    int count = 10;
    UIView *lastView = nil;
    for ( int i = 1 ; i <= count ; ++i )
    {
        UIView *subv = [UIView new];
        [container addSubview:subv];
        subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        
        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(container);
            make.height.mas_equalTo(@(20*i));
            
            // 刚来时lastView=nil，第一次调到else
            if ( lastView )
            {
                make.top.mas_equalTo(lastView.mas_bottom);
            }
            else
            {
                make.top.mas_equalTo(container.mas_top);
            }
        }];
        
        lastView = subv;
    }
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
