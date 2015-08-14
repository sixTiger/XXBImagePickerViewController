//
//  XXBImagePickerTabr.h
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/4.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  XXBImagePickerTabrDelegate<NSObject>

- (void)imagePickerTabrFinishClick;
@end

@interface XXBImagePickerTabr : UIView
@property(nonatomic , weak)id<XXBImagePickerTabrDelegate> delegate;
@property(nonatomic , assign)NSInteger selectCount;
@end
