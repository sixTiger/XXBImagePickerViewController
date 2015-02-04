//
//  XXBImagePickerTabr.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/4.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBImagePickerTabr.h"

@implementation XXBImagePickerTabr

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImagePickerTabr];
    }
    return self;
}
- (void)setupImagePickerTabr
{
    self.backgroundColor = [UIColor orangeColor];
}
@end
