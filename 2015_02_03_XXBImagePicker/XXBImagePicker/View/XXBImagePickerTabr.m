//
//  XXBImagePickerTabr.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/4.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBImagePickerTabr.h"
#import "UIView+AutoLayout.h"

@interface XXBImagePickerTabr ()
@property(nonatomic , weak)UILabel *selectMessageLabel;
@end

@implementation XXBImagePickerTabr

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
- (void)setSelectCount:(NSInteger)selectCount
{
    _selectCount = selectCount;
    self.selectMessageLabel.text = [NSString stringWithFormat:@"%@",@(selectCount)];
}
- (UILabel *)selectMessageLabel
{
    if (_selectMessageLabel == nil)
    {
        UILabel *leftLable = [[UILabel alloc] init];
        leftLable.textColor = self.textColor;
        leftLable.text = @"已选择:";
        [self addSubview:leftLable];
        [leftLable autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeRight];
        
        UILabel *centerLable = [[UILabel alloc] init];
        centerLable.textColor = self.textColor;
        [self addSubview:centerLable];
        [centerLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:leftLable];
        [centerLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [centerLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        
        UILabel *rightLable = [[UILabel alloc] init];
        rightLable.textColor = self.textColor;
        rightLable.text = @" 张照片";
        [self addSubview:rightLable];
        [rightLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:centerLable];
        [rightLable autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [rightLable autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];

        
        _selectMessageLabel = centerLable;
    }
    return _selectMessageLabel;
}
- (UIColor *)textColor
{
    if (!_textColor) {
        _textColor = [UIColor whiteColor];
    }
    return _textColor;
}
@end
