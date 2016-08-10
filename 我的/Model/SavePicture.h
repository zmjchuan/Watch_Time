//
//  SavePicture.h
//  LoveMe
//
//  Created by lanou3g on 15/11/30.
//  Copyright © 2015年 chuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SavePicture : NSObject

// 将图片保存到本地
+ (void)SaveImageToLocal:(UIImage *)image keys:(NSString *)key;
// 本地是否有相关图片
+ (BOOL)LocalHaveImage:(NSString *)key;
// 从本地获取图片
+ (UIImage *)GetImageFromLocel:(NSString *)key;
// 保存天数
+ (void)SaveDay:(NSString *)string keys:(NSString *)key;
//
+ (NSString *)GetDaysFromLocel:(NSString *)key;
@end
