//
//  XXBPhotoGroupTabVC.h
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXBPhotoGroupTabVC;

@protocol XXBPhotoGroupTabVCDelegate <NSObject>

@optional

- (void)photoGroupTabVCCancleSelect:(XXBPhotoGroupTabVC *)photoGroupTabVC;
- (void)photoGroupTabVCDidSelectPhotos:(XXBPhotoGroupTabVC *)photoGroupTabVC;

@end


@interface XXBPhotoGroupTabVC : UITableViewController

/**
 *  一行显示的照片个数
 *  默认是4个
 */
@property(nonatomic , assign)NSInteger photoInRow;
/**
 *  选中的相册的ALAssets
 */
@property(nonatomic , strong)NSMutableArray 	*selectPhotoALAssets;
/**
 *  相册分组的模型数组
 */
@property(nonatomic , strong)NSMutableArray  	*photoGroupArray;
/**
 *  相册的模型数组
 */
@property(nonatomic , strong)NSMutableArray  	*photoArray;
/**
 *  处理照片选中的的代理
 */
@property(nonatomic , weak)id<XXBPhotoGroupTabVCDelegate> photoGroupTabVCDelegate;
/**
 *  是否显示数字标签
 */
@property(nonatomic , assign)BOOL showPage;
@end
