//
//  XXBImagePickerController.h
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /**
     *  选择的顺序
     */
    XXBPhotoSortTypeSelectOrder = 0,
    /**
     *  选择的顺序 倒叙
     */
    XXBPhotoSortTypeSelectDesc = 1,
    /**
     *  系统的顺序
     */
    XXBPhotoSortTypeSystemOrder = 2,
    /**
     *  系统的顺序 倒叙
     */
    XXBPhotoSortTypeSystemDesc = 3,
} XXBPhotoSortType;
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
 *  是否显示数字标签
 */
@property(nonatomic , assign)BOOL           showPage;
/**
 *  是否默认显示所有的相册
 */
@property(nonatomic , assign)BOOL           showAllPhoto;
/**
 *  最多可选的照片的张数
 */
@property(nonatomic , assign)NSInteger      photoCount;
/**
 *  用来处理选中和和取消的代理方法
 */
@property(nonatomic , weak)id<XXBImagePickerControllerDelegate> imagePickerDelegate;
@property(nonatomic , assign)XXBPhotoSortType photoSortType;
@end
