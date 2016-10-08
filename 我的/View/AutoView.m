//
//  AutoView.m
//  Watch_Time
//
//  Created by mac on 16/9/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AutoView.h"

@implementation AutoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)autoLayoutView
{
    /* （1）WithItem：被约束对象
       （2）第一个attribute：被约束对象的关系   
       （3）relatedBy:约束描述  
       （4）toItem:约束源   
       （5）第二个attribute：约束源的关系  
       （6）multiplier：约束系数
       （7）constant：约束常数
     Constraints are of the form "view1.attr1 = view2.attr2 * multiplier + constant" 
     
     
     
     + (instancetype)constraintWithItem:(id)view1
     attribute:(NSLayoutAttribute)attr1
     relatedBy:(NSLayoutRelation)relation
     toItem:(id)view2
     attribute:(NSLayoutAttribute)attr2
     multiplier:(CGFloat)multiplier
     constant:(CGFloat)c
     
     
     [NSLayoutConstraint
     constraintWithItem:self.view1
     attribute:NSLayoutAttributeWidth
     relatedBy:NSLayoutRelationEqual
     toItem:self.view2
     attribute:NSLayoutAttributeWidth
     multiplier:0.5
     constant:0.0]];
    等价于==>
     view1.width = view2.width * 0.5 + 0.0
     
     */
    
    _testView = [[UIView alloc]init];
    _testView.backgroundColor = [UIColor yellowColor];
    NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:self attribute:(NSLayoutAttributeLeft) relatedBy:0 toItem:_testView attribute:0 multiplier:1.0f constant:10];
    NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:self attribute:(NSLayoutAttributeTop) relatedBy:0 toItem:_testView attribute:0 multiplier:1.0f constant:10];
    NSLayoutConstraint * wight = [NSLayoutConstraint constraintWithItem:self attribute:(NSLayoutAttributeWidth) relatedBy:0 toItem:_testView attribute:0 multiplier:1.0f constant:10];
    NSLayoutConstraint * height = [NSLayoutConstraint constraintWithItem:self attribute:(NSLayoutAttributeHeight) relatedBy:0 toItem:_testView attribute:0 multiplier:1.0f constant:10];
    [self addConstraints:@[left,top,wight,height]];
    [self addSubview:_testView];
}

@end
