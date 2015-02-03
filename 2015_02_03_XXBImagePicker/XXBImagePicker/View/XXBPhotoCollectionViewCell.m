//
//  XXBPhotoCollectionViewCell.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoCollectionViewCell.h"
#import "XXBPhotoAlasetModle.h"

@interface XXBPhotoCollectionViewCell ()
/**
 *  显示照片的缩略图
 */
@property(nonatomic , weak)UIImageView *photoView;
/**
 *  选中的时候的蒙版
 */
@property(nonatomic , weak)UIImageView *selectCover;
@end

@implementation XXBPhotoCollectionViewCell

- (void)setPhotoAlasetModle:(XXBPhotoAlasetModle *)photoAlasetModle
{
    _photoAlasetModle = photoAlasetModle;
    self.selectCover.hidden= !photoAlasetModle.select;
    ALAsset *photoAlaset = photoAlasetModle.photoAlaset;
    //媒体类型是视频
    if ([[photoAlaset valueForProperty:@"ALAssetPropertyType"] isEqualToString:ALAssetTypeVideo])
    {
        /**
         *  视频
         */
    }
    else
    {
        /**
         *  照片
         */
    }
    /**
     *  设置缩略图
     */
    self.photoView.image = [UIImage imageWithCGImage:photoAlaset.thumbnail];
}
#pragma mark - 懒加载
- (UIImageView *)photoView
{
    if (_photoView == nil) {
        
        UIImageView *photoView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:photoView];
        _photoView = photoView;
    }
    return _photoView;
}
- (UIImageView *)selectCover
{
    if (_selectCover == nil)
    {
        UIImageView *selectCover = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.photoView addSubview:selectCover];
        selectCover.backgroundColor = [UIColor orangeColor];
        _selectCover = selectCover;
    }
    return _selectCover;
}
@end
