//
//  SecondCell.m
//  Watch_Time
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SecondCell.h"

@implementation SecondCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self p_setUpCell];
    }
    return self;
}

- (void)p_setUpCell
{
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, w-30, 40*2)];
    _lineView.layer.cornerRadius = 6;
    _lineView.layer.borderWidth = 0.5;
    _lineView.layer.borderColor = [UIColor colorWithRed:42.0/255.0 green:208.0/255.0 blue:207.0/255.0 alpha:1].CGColor;
    
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, w-30, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:208.0/255.0 blue:207.0/255.0 alpha:1];
    [_lineView addSubview:line];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView addSubview:_lineView];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
