//
//  XXBPhotoCollectionViewCell.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoCollectionViewCell.h"
#import "XXBPhotoAlasetModle.h"
#import "XXBBadgeValueBtn.h"

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
@property(nonatomic , weak)XXBBadgeValueBtn *bageButton;
@end

@implementation XXBPhotoCollectionViewCell


- (void)setPhotoAlasetModle:(XXBPhotoAlasetModle *)photoAlasetModle
{
    _photoAlasetModle = photoAlasetModle;
    self.selectCover.hidden= !_photoAlasetModle.select;
    self.bageButton.badgeValue = [NSString stringWithFormat:@"%@",@(_photoAlasetModle.index)];
    self.coverButton.selected = _photoAlasetModle.select;
    ALAsset *photoAlaset = _photoAlasetModle.photoAlaset;
    if (!self.photoAlasetModle.showPage)
    {
        [self.bageButton removeFromSuperview];
        _bageButton = nil;
    }
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
        selectCover.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
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
#warning 预先展示的图片可以去掉
        [coverButton setImage:[UIImage imageNamed:@"XXBImagePicker.bundle/XXBPhoto"] forState:UIControlStateNormal];
        [coverButton setImage:[UIImage imageNamed:@"XXBImagePicker.bundle/XXBPhotoSelected"] forState:UIControlStateSelected];
        coverButton.userInteractionEnabled = NO;
        _coverButton =coverButton;
    }
    return _coverButton;
}
- (XXBBadgeValueBtn *)bageButton
{
    if (_bageButton == nil && self.photoAlasetModle.showPage)
    {
        XXBBadgeValueBtn *bageButton = [[XXBBadgeValueBtn alloc] init];
        [self.selectCover addSubview:bageButton];
        bageButton.frame = CGRectMake(0, 0, 10, 10);
        _bageButton = bageButton;
    }
    return _bageButton;
}
@end
