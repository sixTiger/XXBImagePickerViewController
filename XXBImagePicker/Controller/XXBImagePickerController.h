//
//  XXBImagePickerController.h
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXBCommonModel.h"

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
@property(nonatomic , assign)NSInteger                              photoInRow;
/**
 *  如果想在打开的时候原来选中的图片还是选中的话需要设置 selectPhotoALAssets
 *
 *  里边放的是 XXBPhotoAlasetModel 模型
 *
 *  原来选中的photo的ALAsset 默认为空
 */
@property(nonatomic , strong , readonly)NSMutableArray              *selectPhotoALAssets;
/**
 *  是否显示数字标签
 */
@property(nonatomic , assign)BOOL                                   showPage;
/**
 *  是否默认显示所有的相册
 */
@property(nonatomic , assign)BOOL                                   showAllPhoto;
/**
 *  最多可选的照片的张数
 */
@property(nonatomic , assign)NSInteger                              photoCount;
/**
 *  用来处理选中和和取消的代理方法
 */
@property(nonatomic , weak)id<XXBImagePickerControllerDelegate>     imagePickerDelegate;
@property(nonatomic , assign)XXBPhotoSortType                       photoSortType;
/**
 *  默认有选择的照片
 *
 *  @param selectPhotoALAssets 已经选种的照片
 * 
 *  如果想要支持照片默认选种 请讲allowFromPhotos 设置为 YES
 *
 *  @return 已经选中的照片
 */
+ (instancetype)initWithSelectPhotoALAssets:(NSArray *)             selectPhotoALAssets;
/**
 *  默认有选择的照片
 *
 *  @param selectPhotoALAssets 已经选种的照片
 *
 *  如果想要支持照片默认选种 请讲allowFromPhotos 设置为 YES
 *
 *  @return 已经选中的照片
 */
- (instancetype)initWithSelectPhotoALAssets:(NSArray *)             selectPhotoALAssets;

/**
 *  允许用户跨多个相册进行选择  默认是  YES 
 * 
 *  如果你设置了进入相册默认选种的照片请不要更改这个属性
 *
 */
@property(nonatomic , assign) BOOL                                  allowFromPhotos;
/**
 *  选择媒体的类型 默认是照片
 */
@property(nonatomic, assign, readonly) XXBMediaType                 chooseMediaType;
/**
 *  创建图片选择器
 *
 *  @param mediaType 选择的图片的类型
 *
 *  @return 创建好的图片选择器
 */
- (instancetype)initWithChooseMediaType:(XXBMediaType)              mediaType;
@end
