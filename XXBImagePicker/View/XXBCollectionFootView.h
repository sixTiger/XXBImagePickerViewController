//
//  XXBCollectionFootView.h
//  2015_02_03_XXBImagePicker
//
//  Created by 杨小兵 on 15/6/29.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXBCommonModel.h"
@interface XXBCollectionFootView : UICollectionReusableView
/**
 *  要显示的数字
 */
@property(nonatomic , assign) NSInteger                     number;
/**
 *  选择媒体的类型 默认是照片
 */
@property(nonatomic, assign) XXBMediaType                   chooseMediaType;
@end
