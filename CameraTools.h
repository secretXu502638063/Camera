//
//  CameraTools.h
//  TestCarmar
//
//  Created by Dxx on 14/10/29.
//  Copyright (c) 2014年 Dxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface CameraTools : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePicker;
    UIViewController        *_presentView;
    
    
}
@property(nonatomic,retain)UIViewController *presentView;

//void(^didFinishSelected)(UIImage* seletedImage) block回调传回选择的图片。
//需要注意内存的释放。
@property(nonatomic,copy) void(^didFinishSelected)(UIImage* seletedImage);

/* loacl 参数 可选:相机,相册
 
 */
- (void)selectImageFromLoacl:(NSString*)loacl presentView:(UIViewController*)presentView;

//打开闪光灯
+ (void)openFlashlight;
//关闭闪光灯
+ (void)closeFlashlight;


@end
