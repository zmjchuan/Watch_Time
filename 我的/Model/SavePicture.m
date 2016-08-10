//
//  SavePicture.m
//  LoveMe
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 chuan. All rights reserved.
//

#import "SavePicture.h"

@implementation SavePicture

// 将图片保存到本地
+ (void)SaveImageToLocal:(UIImage *)image keys:(NSString *)key
{
    NSUserDefaults * preference = [NSUserDefaults standardUserDefaults];
    [preference setObject:UIImagePNGRepresentation(image) forKey:key];
}

// 本地是否有相关图片
+ (BOOL)LocalHaveImage:(NSString *)key
{
    NSUserDefaults * preference = [NSUserDefaults standardUserDefaults];
    NSData * imageData = [preference objectForKey:key];
    if (imageData) {
        return YES;
    }
    return NO;
}
// 从本地获取图片
+ (UIImage *)GetImageFromLocel:(NSString *)key
{
    NSUserDefaults * prefrence = [NSUserDefaults standardUserDefaults];
    NSData * imageData = [prefrence objectForKey:key];
    UIImage * image;
    if (imageData) {
        image = [UIImage imageWithData:imageData];
    } else {
        NSLog(@"没有从本地获得图片");
    }
    return image;
}

// 保存天数
+ (void)SaveDay:(NSString *)string keys:(NSString *)key
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:string forKey:key];
}

// 从本地获取天数
+ (NSString *)GetDaysFromLocel:(NSString *)key
{
    NSUserDefaults * prefrence = [NSUserDefaults standardUserDefaults];
    NSString  * dayString = [prefrence objectForKey:key];
    return dayString;
}
@end
