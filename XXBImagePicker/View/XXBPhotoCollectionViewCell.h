//
//  XXBPhotoCollectionViewCell.h
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XXBPhotoAlasetModel;

@interface XXBPhotoCollectionViewCell : UICollectionViewCell

/**
 *  要显示的照片的ALAsset
 */
@property(nonatomic , strong)XXBPhotoAlasetModel *photoAlasetModel;

@end
