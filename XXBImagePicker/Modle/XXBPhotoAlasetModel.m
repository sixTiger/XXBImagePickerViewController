//
//  XXBPhotoAlasetModel.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoAlasetModel.h"

@implementation XXBPhotoAlasetModel

- (BOOL)isEqual:(XXBPhotoAlasetModel *)other
{
    return [self.photoAlaset.description isEqualToString:other.photoAlaset.description ] ;
}
@end
