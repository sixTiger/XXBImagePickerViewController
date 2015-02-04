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
@property(nonatomic , weak)UIButton *coverButton;
@end

@implementation XXBPhotoCollectionViewCell


- (void)setPhotoAlasetModle:(XXBPhotoAlasetModle *)photoAlasetModle
{
    _photoAlasetModle = photoAlasetModle;
    self.selectCover.hidden= !photoAlasetModle.select;
    self.coverButton.selected = photoAlasetModle.select;
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
        selectCover.backgroundColor = [UIColor whiteColor];
        selectCover.alpha = 0.4;
        _selectCover = selectCover;
    }
    return _selectCover;
}
- (UIButton *)coverButton
{
    if (_coverButton == nil)
    {
        //右上角的小图标的尺寸
        CGFloat margin = 2.0;
        CGFloat width = 27;
        UIButton *coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        coverButton.frame = CGRectMake(self.bounds.size.width - width - margin, margin , width , width);
        [self.photoView addSubview:coverButton];
        [coverButton setImage:[UIImage imageNamed:@"XXBImagePicker.bundle/XXBPhoto"] forState:UIControlStateNormal];
        [coverButton setImage:[UIImage imageNamed:@"XXBImagePicker.bundle/XXBPhotoSelected"] forState:UIControlStateSelected];
        coverButton.userInteractionEnabled = NO;
        _coverButton =coverButton;
    }
    return _coverButton;
}
@end
