//
//  XXBPhotoAlasetModle.h
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface XXBPhotoAlasetModle : NSObject
/**
 *  要显示的照片的ALAsset
 */
@property(nonatomic , strong)ALAsset *photoAlaset;
/**
 *  标记这张照片是否选中了
 */
@property(nonatomic , assign)BOOL select ;
/**
 *  当前的下标
 */
@property(nonatomic , assign)NSInteger index;
@end
