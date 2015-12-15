//
//  XXBPhotoCollectionViewCell.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoCollectionViewCell.h"
#import "XXBPhotoAlasetModel.h"
#import "XXBBadgeValueBtn.h"

@interface XXBPhotoCollectionViewCell ()
/**
 *  显示照片的缩略图
 */
@property(nonatomic , weak)UIImageView *photoView;
/**
 *  选中的时候的蒙版
 */
@property(nonatomic , weak)UIImageView          *selectCover;
@property(nonatomic , weak)UIButton             *coverButton;
@property(nonatomic , weak)XXBBadgeValueBtn     *bageButton;
@property(nonatomic , weak) UILabel             *messageLabel;
@property(nonatomic , weak) UIView              *videoBgView;
@end

@implementation XXBPhotoCollectionViewCell


- (void)setPhotoAlasetModel:(XXBPhotoAlasetModel *)photoAlasetModel
{
    _photoAlasetModel = photoAlasetModel;
    self.selectCover.hidden= !_photoAlasetModel.select;
    self.bageButton.badgeValue =_photoAlasetModel.index;
    self.coverButton.selected = _photoAlasetModel.select;
    ALAsset *photoAlaset = _photoAlasetModel.photoAlaset;
    if (!self.photoAlasetModel.showPage)
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
        NSNumber *time = [photoAlaset valueForProperty:ALAssetPropertyDuration];
        self.messageLabel.text = [self timeFromeNumber:time];
    }
    else
    {
        /**
         *  照片
         */
        if ([[photoAlaset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
         {
             
         }
        
        [_messageLabel removeFromSuperview];
        _messageLabel = nil;
    }
    /**
     *  设置缩略图
     */
    if (_photoAlasetModel.photoAlaset)
    {
        self.photoView.contentMode = UIViewContentModeScaleToFill;
        self.photoView.image =[UIImage imageWithCGImage:photoAlaset.thumbnail];
    }
    else
    {
        self.photoView.contentMode = UIViewContentModeCenter;
        self.photoView.image = [UIImage imageNamed:@"XXBImagePicker.bundle/XXBPageNumber"];
    }
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
        CGFloat margin = 4.0;
        CGFloat width = 20;
        UIButton *coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        coverButton.frame = CGRectMake(self.bounds.size.width - width - margin,  margin , width , width);
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
    if (_bageButton == nil && self.photoAlasetModel.showPage)
    {
        XXBBadgeValueBtn *bageButton = [[XXBBadgeValueBtn alloc] init];
        [self.selectCover addSubview:bageButton];
        bageButton.frame = CGRectMake(0, 0, 10, 10);
        _bageButton = bageButton;
    }
    return _bageButton;
}
- (NSString *)timeFromeNumber:(NSNumber *)number
{
    int times[3];
    memset(times, 0, sizeof(times));
    int second = number.intValue;
    int i = 0;
    while (i < 2)
    {
        int time = second % 60;
        second /= 60;
        times[i] = time;
        i ++;
    }
    times[i] = second;
    NSString * time = @"";
    while (i > 0)
    {
        if (i >= 2 && times[i] <= 0 && time.length <= 0) {
            i-- ;
            continue;
        }
        time = [NSString stringWithFormat:@"%@%02d:",time,times[i]];
        i--;
    }
    time = [NSString stringWithFormat:@"%@%02d",time,times[i]];
    return time;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil)
    {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        messageLabel.font = [UIFont systemFontOfSize:12];
        messageLabel.textColor = [UIColor whiteColor];
        [self.videoBgView addSubview:messageLabel];
        messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *rightMessageLabel = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.videoBgView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-3];
        NSLayoutConstraint *bottomMessageLabel = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem: self.videoBgView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
         NSLayoutConstraint *topMessageLabel = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem: self.videoBgView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        
        [self.videoBgView addConstraints:@[rightMessageLabel, bottomMessageLabel,topMessageLabel]];
        _messageLabel = messageLabel;
    }
    return _messageLabel;
}

- (UIView *)videoBgView
{
    if (_videoBgView == nil)
    {
        
        UIView *videoBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        videoBgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        [self.contentView addSubview:videoBgView];
        videoBgView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *lefttVideoBgView = [NSLayoutConstraint constraintWithItem:videoBgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
        NSLayoutConstraint *rightVideoBgView = [NSLayoutConstraint constraintWithItem:videoBgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
        NSLayoutConstraint *bottomVideoBgView = [NSLayoutConstraint constraintWithItem:videoBgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem: self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
        NSLayoutConstraint *heightVideoBgView = [NSLayoutConstraint constraintWithItem:videoBgView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem: nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20];
        [self.contentView addConstraints:@[lefttVideoBgView, rightVideoBgView,bottomVideoBgView,heightVideoBgView]];
        _videoBgView = videoBgView;
    }
    return _videoBgView;
}
@end
