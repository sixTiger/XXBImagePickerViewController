//
//  XXBPhotoGroupTVCell.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoGroupTVCell.h"
#import "XXBPhotoGroupModle.h"

@implementation XXBPhotoGroupTVCell

+ (instancetype)photoGroupTVCellWithTableView:(UITableView *)tableView
{
    static NSString *photoGroupTabVCCellID = @"photoGroupTabVCCellID";
    XXBPhotoGroupTVCell *cell = [tableView dequeueReusableCellWithIdentifier:photoGroupTabVCCellID];
    if (cell == nil) {
        cell = [[XXBPhotoGroupTVCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:photoGroupTabVCCellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)setPhotoGroupModle:(XXBPhotoGroupModle *)photoGroupModle
{
    _photoGroupModle = photoGroupModle;
    
    self.imageView.image = photoGroupModle.photoGroupIcon;
    self.textLabel.text = photoGroupModle.photoGroupName;
    self.detailTextLabel.text = [NSString stringWithFormat:@"(%@)张照片",@(photoGroupModle.photoALAssets.count)];
}
@end
