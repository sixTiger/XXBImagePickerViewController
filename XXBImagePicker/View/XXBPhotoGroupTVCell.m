//
//  XXBPhotoGroupTVCell.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBPhotoGroupTVCell.h"
#import "XXBPhotoGroupModel.h"

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

- (void)setPhotoGroupModel:(XXBPhotoGroupModel *)photoGroupModel
{
    _photoGroupModel = photoGroupModel;
    
    self.imageView.image = photoGroupModel.photoGroupIcon;
    self.textLabel.text = photoGroupModel.photoGroupName;
    self.detailTextLabel.text = [NSString stringWithFormat:@"(%@)张照片",@(photoGroupModel.photoALAssets.count)];
}
@end
