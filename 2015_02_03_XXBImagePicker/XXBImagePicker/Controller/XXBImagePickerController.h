//
//  XXBImagePickerController.h
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XXBImagePickerController;

@protocol XXBImagePickerControllerDelegate <NSObject>

@optional

- (void)imagePickerControllerCancleselect:(XXBImagePickerController *)imagePickController;
- (void)imagePickerController:(XXBImagePickerController *)imagePickController didselectPhotos:(NSArray *)selectPhotos;

@end

@interface XXBImagePickerController : UINavigationController

/**
 *  竖屏状态下默认照片个数
 *  默认是4个
 */
@property(nonatomic , assign)NSInteger photoInRow;
/**
 *  如果想在打开的时候原来选中的图片还是选中的话需要设置 selectPhotoALAssets
 *
 *  里边放的是 XXBPhotoAlasetModle 模型
 *
 *  原来选中的photo的ALAsset 默认为空
 */
@property(nonatomic , strong)NSMutableArray *selectPhotoALAssets;
/**
 *  用来处理选中和和取消的代理方法
 */
@property(nonatomic , weak)id<XXBImagePickerControllerDelegate> imagePickerDelegate;

@end
