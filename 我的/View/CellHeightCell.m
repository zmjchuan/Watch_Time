//
//  CellHeightCell.m
//  Watch_Time
//
//  Created by mac on 16/9/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "CellHeightCell.h"

@implementation CellHeightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self p_setView];
    }
    return self;
}

- (void)p_setView
{
    _textL = [[UILabel alloc]init];
    _textL.backgroundColor = [UIColor redColor];
    _textL.numberOfLines = 0;
    [self.contentView addSubview:_textL];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // frame
    _textL.frame = CGRectMake(10, 0, _w, _h);
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
