//
//  XXBImagePickerTabr.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/4.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBImagePickerTabr.h"
#import "UIView+AutoLayout.h"
#import "XXBBadgeValueBtn.h"

@interface XXBImagePickerTabr ()
@property(nonatomic , strong)UIButton *finishButton;
@property(nonatomic , strong)XXBBadgeValueBtn *bageValueButton;
@end

@implementation XXBImagePickerTabr

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImagePickerTabr];
        self.selectCount = 0;
    }
    return self;
}
- (void)setupImagePickerTabr
{
    self.backgroundColor = [UIColor whiteColor];
    _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_finishButton];
    [_finishButton setTitle:@"完成" forState:UIControlStateNormal];
    [_finishButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_finishButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_finishButton addTarget:self action:@selector(p_finishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_finishButton autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-10];
    [_finishButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_finishButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
//    [_finishButton autoSetDimension:ALDimensionWidth toSize:64];
    
    _bageValueButton = [XXBBadgeValueBtn buttonWithType:UIButtonTypeCustom];
    [self addSubview:_bageValueButton];
    _bageValueButton.frame = CGRectMake(0, 0, 10, 10);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bageValueButton.frame = CGRectMake(self.finishButton.frame.origin.x - 26,(self.frame.size.height - 26) * 0.5, 26, 26);
}
- (void)p_finishButtonClick
{
    [self.delegate imagePickerTabrFinishClick];
}
- (void)setSelectCount:(NSInteger)selectCount
{
    _selectCount = selectCount;
    self.bageValueButton.badgeValue = [NSString stringWithFormat:@"%@",@(selectCount)];
    self.bageValueButton.frame = CGRectMake(self.finishButton.frame.origin.x - self.bageValueButton.frame.size.width, self.bageValueButton.frame.origin.y, self.bageValueButton.frame.size.width, self.bageValueButton.frame.size.height);
}
@end
