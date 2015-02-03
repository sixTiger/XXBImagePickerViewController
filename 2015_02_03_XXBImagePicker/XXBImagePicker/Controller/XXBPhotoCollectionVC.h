//
//  XXBPhotoCollectionVC.h
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@property(nonatomic , weak)id<XXBPhotoCollectionVCDelegate> photoCollectionDelegate;
@end
