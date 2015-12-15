//
//  XXBPhotoGroupTVCell.h
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/3.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XXBPhotoGroupModel;

@interface XXBPhotoGroupTVCell : UITableViewCell

@property(nonatomic , strong)XXBPhotoGroupModel *photoGroupModel;



+ (instancetype)photoGroupTVCellWithTableView:(UITableView *)tableView;
@end
