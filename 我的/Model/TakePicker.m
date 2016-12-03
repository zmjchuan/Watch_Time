//
//  TakePicker.m
//  LoveMe
//
//  Created by lanou3g on 15/11/27.
//  Copyright © 2015年 chuan. All rights reserved.
//

#import "TakePicker.h"

#define AppRootView  ([[[[[UIApplication sharedApplication] delegate] window] rootViewController] view])

#define AppRootViewController  ([[[[UIApplication sharedApplication] delegate] window] rootViewController])

#define iOS8  ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES :NO)

@interface TakePicker ()

@end

@implementation TakePicker

   static  id  takePicker = nil;
+ (TakePicker *)shareModel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        takePicker = [[TakePicker alloc]init];
    });
    return takePicker;
}


+ (void)sharePickerBlock:(SendPicture)block
{
    TakePicker * take = [TakePicker shareModel];
    take.sendPicture = block;
    
    
        UIActionSheet * sheet;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            sheet  = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:take cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
        }
        else {
            sheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:take cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",nil, nil];
        }
    
        [sheet showInView:AppRootView];
 
}


#pragma mark - action sheet delegte
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                //来源:相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                //来源:相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                return;
        }
    }
    else {
        if (buttonIndex == 2) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [AppRootViewController presentViewController:imagePickerController animated:YES completion:NULL];
    
}


#pragma mark - image picker delegte

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    TakePicker * takeP = [TakePicker shareModel];
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [takeP sendPicture](image);
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [AppRootViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
