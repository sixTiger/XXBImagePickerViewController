//
//  XXBImagePickerTabr.m
//  2015_02_03_XXBImagePicker
//
//  Created by Jinhong on 15/2/4.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBImagePickerTabr.h"
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
    [_finishButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_finishButton addTarget:self action:@selector(p_finishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _finishButton.translatesAutoresizingMaskIntoConstraints = NO;

    NSLayoutConstraint *lcRightFinishButton = [NSLayoutConstraint constraintWithItem:_finishButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10];
    NSLayoutConstraint *lcTopFinishButton = [NSLayoutConstraint constraintWithItem:_finishButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem: self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *lcBottomFinishButton = [NSLayoutConstraint constraintWithItem:_finishButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem: self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self addConstraints:@[lcRightFinishButton, lcTopFinishButton,lcBottomFinishButton]];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bageValueButton.frame = CGRectMake(self.finishButton.frame.origin.x - self.bageValueButton.frame.size.width - 8 ,(self.frame.size.height - self.bageValueButton.frame.size.height) * 0.5, self.bageValueButton.frame.size.width, self.bageValueButton.frame.size.height);
}

- (void)p_finishButtonClick
{
    [self.delegate imagePickerTabrFinishClick];
}

- (void)setSelectCount:(NSInteger)selectCount
{
    _selectCount = selectCount;
    self.finishButton.enabled = _selectCount > 0;
    self.bageValueButton.badgeValue = selectCount;
    self.bageValueButton.frame = CGRectMake(self.finishButton.frame.origin.x - self.bageValueButton.frame.size.width - 8,(self.bounds.size.height - self.bageValueButton.frame.size.height) * 0.5, self.bageValueButton.frame.size.width, self.bageValueButton.frame.size.height);
}

- (XXBBadgeValueBtn *)bageValueButton
{
    if (_bageValueButton == nil) {
        XXBBadgeValueBtn *bageValueButton = [XXBBadgeValueBtn buttonWithType:UIButtonTypeCustom];
        [self addSubview:bageValueButton];
        _bageValueButton = bageValueButton;
    }
    return _bageValueButton;
}
@end
