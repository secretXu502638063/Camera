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

@property(nonatomic,copy) void(^didFinishSelected)(UIImage* seletedImage);

// loacl  相机,相册
- (void)selectImageFromLoacl:(NSString*)loacl presentView:(UIViewController*)presentView;

//打开闪光灯
+ (void)openFlashlight;
//关闭闪光灯
+ (void)closeFlashlight;


@end
