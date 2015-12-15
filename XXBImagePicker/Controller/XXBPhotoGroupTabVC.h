//
//  XXBPhotoGroupTabVC.h
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXBCommonModel.h"

@class XXBPhotoGroupTabVC;

@protocol XXBPhotoGroupTabVCDelegate <NSObject>

@optional

- (void)photoGroupTabVCCancleSelect:(XXBPhotoGroupTabVC *)photoGroupTabVC;
- (void)photoGroupTabVCDidSelectPhotos:(XXBPhotoGroupTabVC *)photoGroupTabVC;

@end


@interface XXBPhotoGroupTabVC : UIViewController

/**
 *  一行显示的照片个数
 *  默认是4个
 */
@property(nonatomic , assign)NSInteger                      photoInRow;
/**
 *  选中的相册的ALAssets
 */
@property(nonatomic , strong)NSMutableArray                 *selectPhotoALAssets;
/**
 *  相册分组的模型数组
 */
@property(nonatomic , strong)NSMutableArray                 *photoGroupArray;
/**
 *  处理照片选中的的代理
 */
@property(nonatomic , weak)id<XXBPhotoGroupTabVCDelegate>   photoGroupTabVCDelegate;
/**
 *  是否显示数字标签
 */
@property(nonatomic , assign)BOOL                           showPage;
/**
 *  最多可选的照片的张数
 */
@property(nonatomic , assign)NSInteger                      photoCount;
/**
 *  是否显示所有的照片
 */
@property(nonatomic , assign)BOOL                           showAllPhoto;
/**
 *  用户是否允许访问相册
 */
@property(nonatomic , assign)BOOL                           allowPhoto;
/**
 *  允许用户跨多个相册进行选择
 */
@property(nonatomic , assign) BOOL                          allowFromPhotos;

/**
 *  选择媒体的类型 默认是照片
 */
@property(nonatomic, assign) XXBMediaType                   chooseMediaType;
@property(nonatomic , weak)UITableView                      *tableView;
- (void)showAllPhotos;
@end
