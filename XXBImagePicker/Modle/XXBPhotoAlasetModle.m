//
//  XXBPhotoAlasetModle.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoAlasetModle.h"

@implementation XXBPhotoAlasetModle

- (BOOL)isEqual:(XXBPhotoAlasetModle *)other
{
//    NSLog(@"\n%@\n%@",[self.photoAlaset.defaultRepresentation url],[other.photoAlaset.defaultRepresentation url]);
    return [[self.photoAlaset.defaultRepresentation url]  isEqual:[other.photoAlaset.defaultRepresentation url]] ;
}
@end
