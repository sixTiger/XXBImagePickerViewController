//
//  XXBBadgeValue.m
//  Pix72
//
//  Created by 杨小兵 on 15/6/2.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBBadgeValueBtn.h"
@implementation XXBBadgeValueBtn
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self setup];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    self.hidden = YES;
    self.userInteractionEnabled = NO;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.backgroundColor = [UIColor orangeColor];
    self.clipsToBounds = YES;
}
- (void)setBadgeValue:(NSInteger)badgeValue
{
    _badgeValue = badgeValue;
    if (_badgeValue >0)
    {
        
        NSString *bageString = [NSString stringWithFormat:@"%@",@(_badgeValue)];
        /**
         *  有值并且值不等于1 的情况向才进行相关设置
         */
        self.hidden = NO;
        if (_badgeValue > maxBadgeValue)
        {
            _badgeValue= maxBadgeValue;
            
            bageString = [NSString stringWithFormat:@"%@+",@(_badgeValue)];
        }
        [self setTitle:bageString forState:UIControlStateNormal];
        [self p_setupFrame];
    }
    else
    {
        /**
         *  其他情况直接隐藏
         */
        self.hidden = YES;
    }
}
- (void)p_setupFrame
{
    // 根据文字的多少动态计算frame
    [self sizeToFit];
    CGRect frame = self.frame;
    CGFloat badgeH = self.titleLabel.frame.size.height > 0 ? self.titleLabel.frame.size.height : 17;
    badgeH += 4;
    CGFloat length = 0.6;
    NSInteger temp = _badgeValue;
    if (temp == maxBadgeValue)
    {
        temp++;
    }
    while (temp)
    {
        length += 0.4;
        temp /= 10;
    }
    frame.size.height = badgeH;
    frame.size.width = length * badgeH;
    self.layer.cornerRadius = badgeH * 0.5;
    self.frame = frame;
}
@end
