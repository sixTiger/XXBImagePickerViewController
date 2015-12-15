//
//  XXBPhotoCollectionVC.h
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXBCommonModel.h"

@class XXBPhotoCollectionVC;

@protocol XXBPhotoCollectionVCDelegate <NSObject>

@optional

- (void)photoCollectionVCDidselectPhotos:(XXBPhotoCollectionVC *)photoCollectionVC;

@end

@interface XXBPhotoCollectionVC : UICollectionViewController

/**
 *  一行显示的照片个数
 *  默认是4个
 */
@property(nonatomic , assign)NSInteger photoInRow;
/**
 *  选中的照片的ALAsset
 */
@property(nonatomic , strong)NSMutableArray 				*selectPhotoALAssets;
/**
 *  所有照片的ALAsset
 */
@property(nonatomic , strong)NSMutableArray  				*photoALAssets;
/**
 *  是否显示数字标签
 */
@property(nonatomic , assign)BOOL                           showPage;
/**
 *  最多可选的照片的张数
 */
@property(nonatomic , assign)NSInteger                      photoCount;
/**
 *  选择媒体的类型 默认是照片
 */
@property(nonatomic, assign) XXBMediaType                   chooseMediaType;
/**
 *  处理照片选中的代理
 */
@property(nonatomic , weak)id<XXBPhotoCollectionVCDelegate> photoCollectionDelegate;
- (void)scrollToButtom;
@end
