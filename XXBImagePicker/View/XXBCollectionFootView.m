//
//  XXBCollectionFootView.m
//  2015_02_03_XXBImagePicker
//
//  Created by 杨小兵 on 15/6/29.
//  Copyright (c) 2015年 xiaoxiaobing. All rights reserved.
//

#import "XXBCollectionFootView.h"

@interface XXBCollectionFootView()
@property(nonatomic , weak)UILabel *countNumberLabel;
@end
@implementation XXBCollectionFootView

- (void)setNumber:(NSInteger)number
{
    _number = number;
    NSString *string;
    switch (self.chooseMediaType) {
        case XXBMediaTypePhotos:
        {
            string = [NSString stringWithFormat:@"照片总数：%@",@(number)];
            break;
        }
        case XXBMediaTypeVideos:
        {
            string = [NSString stringWithFormat:@"视频总数：%@",@(number)];
            break;
        }
        case XXBMediaTypeAll:
        {
            string = [NSString stringWithFormat:@"多媒体总数：%@",@(number)];
            break;
        }
        default:
            break;
    }
    self.countNumberLabel.text = string;
}

- (UILabel *)countNumberLabel
{
    if(_countNumberLabel == nil)
    {
        UILabel *countNumberLabel = [[UILabel alloc] initWithFrame:self.bounds];
        countNumberLabel.autoresizingMask = (1 << 6) - 1;
        countNumberLabel.textColor = [UIColor grayColor];
        countNumberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:countNumberLabel];
        _countNumberLabel = countNumberLabel;
    }
    return _countNumberLabel;
}
@end
