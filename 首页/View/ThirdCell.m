//
//  ThirdCell.m
//  Watch_Time
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ThirdCell.h"

@implementation ThirdCell
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
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, w-30, 50)];
    
    _line = [[UILabel alloc]initWithFrame:CGRectMake(15, 70, w-30, 0.5)];
    _line.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:208.0/255.0 blue:207.0/255.0 alpha:1];
    
    _typeIMG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 40, 40)];
    _typeIMG.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:208.0/255.0 blue:207.0/255.0 alpha:1];
    [_lineView addSubview:_typeIMG];
    
    _infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_typeIMG.frame)+10, 5, 70, 40)];
    _infoLabel.textAlignment = NSTextAlignmentCenter;
    _infoLabel.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:208.0/255.0 blue:207.0/255.0 alpha:1];
    [_lineView addSubview:_infoLabel];
    
    
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectedButton.frame = CGRectMake(self.frame.size.width-30, CGRectGetMinY(_lineView.frame), 50, 50);
    [_selectedButton setImage:[UIImage imageNamed:@"chose-1x"] forState:UIControlStateNormal];
     [_selectedButton setImage:[UIImage imageNamed:@"chose2-1x"] forState:UIControlStateSelected];
    [self.contentView addSubview:_selectedButton];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView addSubview:_lineView];
    [self.contentView addSubview:_line];
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
