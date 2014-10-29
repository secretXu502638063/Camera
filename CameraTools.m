//
//  CameraTools.m
//  TestCarmar
//
//  Created by Dxx on 14/10/29.
//  Copyright (c) 2014年 Dxx. All rights reserved.
//

#import "CameraTools.h"

@implementation CameraTools
static AVCaptureSession*_session = nil ;

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
    
    [_session release];
    [super dealloc];
}

- (void)selectImageFromLoacl:(NSString*)loacl presentView:(UIViewController*)presentView
{
    
    //拍照
    if ([loacl isEqualToString:@"相机"]) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertView *hasNoTorchAlertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"没有相机" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [hasNoTorchAlertView show];
            [hasNoTorchAlertView release];
            
            
            return;
        }
        _imagePicker = [[UIImagePickerController alloc]init];
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES ;
        
        
        self.presentView = presentView;
        
        _imagePicker.modalPresentationStyle = UIModalPresentationCurrentContext;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [_presentView presentViewController:_imagePicker animated:YES completion:NULL];
        });
        
    }
    //相册
    else if ([loacl isEqualToString:@"相册"]) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            return;
        }
        _imagePicker = [[UIImagePickerController alloc]init];
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imagePicker.delegate = self;
        _imagePicker.allowsEditing = YES ;
        self.presentView = presentView;
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [_presentView presentViewController:_imagePicker animated:YES completion:^{
            }];
        });
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    _didFinishSelected([info objectForKey:@"UIImagePickerControllerOriginalImage"]);
    [_imagePicker dismissViewControllerAnimated:YES completion:^{
        [_imagePicker release];
        self.presentView = nil ;
        
    }];
}
- (NSUInteger)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_imagePicker dismissViewControllerAnimated:YES completion:^{
        [_imagePicker release];
        self.presentView = nil ;
    }];
}

+ (void)openFlashlight
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    ;
    
    if (!device.hasTorch) {
        
        UIAlertView *hasNoTorchAlertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"没有闪光灯" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [hasNoTorchAlertView show];
        [hasNoTorchAlertView release];
        return ;
    }
    
    if (device.torchMode == AVCaptureTorchModeOff) {
        
        _session = [[AVCaptureSession alloc]init];
        
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
        [_session addInput:input];
        
        AVCaptureVideoDataOutput * output = [[AVCaptureVideoDataOutput alloc]init];
        [_session addOutput:output];
        [_session beginConfiguration];
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
        [_session commitConfiguration];
        [_session startRunning];
        [output release];
    }
}

+ (void)closeFlashlight
{
    [_session stopRunning];
}

@end
