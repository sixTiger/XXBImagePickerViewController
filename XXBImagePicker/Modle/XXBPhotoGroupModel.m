//
//  XXBPhotoGroupModel.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoGroupModel.h"

@implementation XXBPhotoGroupModel
- (void)setPhotoGroupName:(NSString *)photoGroupName
{
//    if ([photoGroupName isEqualToString:@"All Photos"])
//    {
//        _photoGroupName = @"所有照片";
//        return;
//    }
//    if([photoGroupName isEqualToString:@"Camera Roll"])
//    {
//        _photoGroupName = @"相机胶卷";
//        return;
//    }
//    if([photoGroupName isEqualToString:@"My Photo Stream"])
//    {
//        _photoGroupName = @"我的照片流";
//        return;
//    }
    _photoGroupName = [photoGroupName copy];

}
- (NSMutableArray *)photoALAssets
{
    if (_photoALAssets == nil) {
        _photoALAssets = [NSMutableArray array];
    }
    return _photoALAssets;
}
@end
