//
//  XXBPhotoGroupModle.h
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XXBPhotoGroupModle : NSObject
/**
 *  相册的组名
 */
@property(nonatomic , copy)NSString *photoGroupName;
/**
 *  相册的缩略图
 */
@property(nonatomic , strong)UIImage *photoGroupIcon;
/**
 *  相册组里边图片的ALAsset
 */
@property(nonatomic , strong)NSMutableArray *photoALAssets;

@end
