//
//  XXBPhotoGroupModle.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoGroupModle.h"

@implementation XXBPhotoGroupModle
- (NSMutableArray *)photoALAssets
{
    if (_photoALAssets == nil) {
        _photoALAssets = [NSMutableArray array];
    }
    return _photoALAssets;
}
@end
