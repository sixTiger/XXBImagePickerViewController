//
//  ViewController.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "ViewController.h"
#import "XXBImagePickerController.h"

@interface ViewController ()
- (IBAction)openXXBImagePicker:(id)sender;

@end

@implementation ViewController

- (IBAction)openXXBImagePicker:(id)sender {
    XXBImagePickerController  *imagePickController = [[XXBImagePickerController alloc] init];
    [self presentViewController:imagePickController animated:YES completion:^{
        
    }];
}
@end
