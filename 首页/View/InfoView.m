//
//  InfoView.m
//  Watch_Time
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "InfoView.h"

@implementation InfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    _bookName = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    _bookName.backgroundColor = [UIColor yellowColor];
    _bookName.text = @"微积分解析";
    [self addSubview:_bookName];
    

    // ----
    _resource = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_bookName.frame)+10, 50, 20)];
    _resource.backgroundColor = [UIColor yellowColor];
    _resource.font = [UIFont systemFontOfSize:13.0f];
    _resource.text = @"资源量:";
    [self addSubview:_resource];
    
    _count = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_resource.frame)+10, CGRectGetMaxY(_bookName.frame)+10, 30, 20)];
    _count.backgroundColor = [UIColor yellowColor];
    _count.text = @"25";
    _count.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:_count];
    
    _author = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_count.frame)+10, CGRectGetMaxY(_bookName.frame)+10, 50, 20)];
    _author.backgroundColor = [UIColor yellowColor];
    _author.text = @"创建者:";
    _author.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:_author];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_author.frame)+10, CGRectGetMaxY(_bookName.frame)+10, 50, 20)];
    _name.backgroundColor = [UIColor yellowColor];
    _name.text = @"王雪梅";
    _name.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:_name];
    
    //---
    _price = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_resource.frame)+10, 40, 20)];
    _price.backgroundColor = [UIColor yellowColor];
    _price.font = [UIFont systemFontOfSize:13.0f];
    _price.text = @"售价:";
    [self addSubview:_price];
    
    _priceNum = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_price.frame)+10, CGRectGetMaxY(_resource.frame)+10, 30, 20)];
    _priceNum.backgroundColor = [UIColor yellowColor];
    _priceNum.text = @"$22";
    _priceNum.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:_priceNum];
}

@end
