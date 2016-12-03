//
//  AutoLayoutViewController.m
//  Watch_Time
//
//  Created by mac on 16/9/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AutoLayoutViewController.h"
#import "AutoView.h"

@interface AutoLayoutViewController ()
@property (nonatomic,strong)UIView * autoView;
@end

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"演示例子";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    /*
     view1: 要约束的控件（autoView）
     attr1: 约束的类型（常量），就是要做怎么样的约束，大家可以进去看看都有什么常量（这里是NSLayoutAttributeLeft）
     relation: 与参照控件之间的关系（常量），包括等于、大于等于、小于等于（NSLayoutRelationEqual 是指等于）
     view2: 参照的控件（self.view）
     attr2: 约束的类型（常量），就是要做怎么样的约束，大家可以进去看看都有什么常量（这里是NSLayoutAttributeLeft）（NSLayoutAttributeLeft）
     multiplier: 乘数，就是多少倍（1.0）
     c: 常量，做好了上述的约束之后会加上这个常量（100）
     
     obj1.property1 =（obj2.property2 * multiplier）+ constant value
    
     */
    
    
    _autoView = [[AutoView alloc]init];
    _autoView.backgroundColor = [UIColor yellowColor];
    
     // 1.要先禁止 autoresizing 功能，防止 AutoresizingMask 转换成 Constraints，避免造成冲突，需要设置 view 的下面属性为 NO：
    _autoView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // 2.一定要写在约束之前，否则会崩溃
    [self.view addSubview:_autoView];
    
    
    // 3.对于left top相对于父视图，所以toItem是要添加的父view上（约束源）
    // autoView距离左边的距离 = (self.view * 0 ) + 10;
    // 添加 left 约束
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_autoView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
    
    // 添加 top 约束
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_autoView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:74];
    
    // 4.对于width height，相对于自己，所以toItme是nil
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:_autoView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:150];
   
    
    // 添加 height 约束
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:_autoView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:150];
    
    // 5.添加方法1
//    [_autoView addConstraint:widthConstraint];
//    [_autoView addConstraint:heightConstraint];
//    [self.view addConstraint:leftConstraint];
//    [self.view addConstraint:topConstraint];
    
    // 5.添加方法1
    [self.view addConstraints:@[leftConstraint,topConstraint,widthConstraint,heightConstraint]];
    
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
