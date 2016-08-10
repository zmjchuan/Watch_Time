//
//  TakePicker.h
//  LoveMe
//
//  Created by lanou3g on 15/11/27.
//  Copyright © 2015年 chuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SendPicture)(UIImage *image);

@interface TakePicker : NSObject <UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>


@property (nonatomic,strong)SendPicture sendPicture;

+ (TakePicker *)shareModel;

+ (void)sharePickerBlock:(SendPicture)block;

@end
