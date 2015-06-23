//
//  XXBHelpTools.h
//  Pix72
//
//  Created by 杨小兵 on 15/5/27.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
/**
 *
 * 单例 宏
 *
 */
// .h文件
#define XXBHelpToolsH_single(name) + (instancetype)shared##name;

// .m文件
#define XXBHelpToolsM_single(name) \
static id _instance = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}
@interface XXBHelpTools : NSObject
XXBHelpToolsH_single(XXBHelpTools);
/**
 *  根据 asset 获取图片
 *
 *  @param asset 图片资源
 *
 *  @return 获取到的图片
 */
- (UIImage *) getUIImageFromAssets: (ALAsset *) asset;
/**
 *  根据 asset 获取图片
 *
 *  @param asset 图片资源
 *  @param size  图片的最大大小
 *
 *  @return 获取到的图片
 */
- (UIImage *)thumbnailForAsset:(ALAsset *)asset maxPixelSize:(NSUInteger)size;
@end
