//
//  ScanView.m
//  Watch_Time
//
//  Created by mac on 16/9/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ScanView.h"

@implementation ScanView

- (instancetype)initWithFrame:(CGRect)frame setSacnView:(CGRect)scanViewFrame
{
    if (self = [super initWithFrame:frame]) {
        self.scanFrame = scanViewFrame;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self drawScanRect];
}

- (void)drawScanRect
{
    CGFloat screenW = self.frame.size.width;
    CGFloat screenH = self.frame.size.height;
    float ration;
    if (screenH < 568) {
        ration = 0.7; // 4
    } else {
        ration = 0.8;  // 5 和 6
    }
    UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"prompt@1x"]];
    image.layer.cornerRadius = 5;
    image.frame = CGRectMake(screenW/2-screenW*ration/2, 64+screenH*0.04, screenW*ration, 40);
    //    image.backgroundColor = [UIColor yellowColor];
    image.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:image];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    {
        //设置非识别区域颜色
        CGContextSetRGBFillColor(context, 0, 0, 0, 0.7);
        //填充矩形
        //扫码区域上面填充
        CGRect rect = CGRectMake(0, 0, self.frame.size.width, _scanFrame.origin.y);
        CGContextFillRect(context, rect);
        //扫码区域左边填充
        rect = CGRectMake(0, _scanFrame.origin.y,_scanFrame.origin.x,_scanFrame.size.height);
        CGContextFillRect(context, rect);
        //扫码区域右边填充
        rect = CGRectMake(_scanFrame.origin.x+_scanFrame.size.width, _scanFrame.origin.y, self.frame.size.width-(_scanFrame.origin.x+_scanFrame.size.width),_scanFrame.size.height);
        CGContextFillRect(context, rect);
        //扫码区域下面填充
        rect = CGRectMake(0, _scanFrame.origin.y+_scanFrame.size.height, self.frame.size.width,self.frame.size.height-(_scanFrame.origin.y+_scanFrame.size.height));
        CGContextFillRect(context, rect);
        //执行绘画
        CGContextStrokePath(context);
    }
    
    {
        //中间画矩形(正方形)
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:186.0/255.0 green:186.0/255.0 blue:186.0/255.0 alpha:1].CGColor);
        CGContextSetLineWidth(context, 1);
        CGContextAddRect(context, _scanFrame);
        CGContextStrokePath(context);
        
    }
    
    //相框角的宽度和高度
    int wAngle = 25;
    int hAngle = 25;
    
    //4个角的 线的宽度
    CGFloat linewidthAngle = 6;// 经验参数：6和4
    
    //画扫码矩形以及周边半透明黑色坐标参数
    CGFloat diffAngle = linewidthAngle/3;
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:102.0/255.0 green:204/255.0 blue:204/255.0 alpha:1].CGColor);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, linewidthAngle);
    CGFloat leftX = _scanFrame.origin.x - diffAngle;
    CGFloat topY = _scanFrame.origin.y - diffAngle;
    CGFloat rightX = _scanFrame.origin.x+_scanFrame.size.width + diffAngle;
    CGFloat bottomY = _scanFrame.origin.y+_scanFrame.size.height + diffAngle;
    
    //左上角水平线
    CGContextMoveToPoint(context, leftX-linewidthAngle/2, topY);
    CGContextAddLineToPoint(context, leftX + wAngle, topY);
    
    //左上角垂直线
    CGContextMoveToPoint(context, leftX, topY-linewidthAngle/2);
    CGContextAddLineToPoint(context, leftX, topY+hAngle);
    
    
    //左下角水平线
    CGContextMoveToPoint(context, leftX-linewidthAngle/2, bottomY);
    CGContextAddLineToPoint(context, leftX + wAngle, bottomY);
    
    //左下角垂直线
    CGContextMoveToPoint(context, leftX, bottomY+linewidthAngle/2);
    CGContextAddLineToPoint(context, leftX, bottomY - hAngle);
    
    
    //右上角水平线
    CGContextMoveToPoint(context, rightX+linewidthAngle/2, topY);
    CGContextAddLineToPoint(context, rightX - wAngle, topY);
    
    //右上角垂直线
    CGContextMoveToPoint(context, rightX, topY-linewidthAngle/2);
    CGContextAddLineToPoint(context, rightX, topY + hAngle);
    
    
    //右下角水平线
    CGContextMoveToPoint(context, rightX+linewidthAngle/2, bottomY);
    CGContextAddLineToPoint(context, rightX - wAngle, bottomY);
    
    //右下角垂直线
    CGContextMoveToPoint(context, rightX, bottomY+linewidthAngle/2);
    CGContextAddLineToPoint(context, rightX, bottomY - hAngle);
    
    CGContextStrokePath(context);
}

@end
