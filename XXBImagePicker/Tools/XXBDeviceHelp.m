//
//  XXBDeviceHelp.m
//  PIX72
//
//  Created by xiaoxiaobing on 14-12-24.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBDeviceHelp.h"
#import <UIKit/UIKit.h>
@implementation XXBDeviceHelp

/**
 *  判断是否是iphone
 *
 *  @return YES 是
 */
+ (BOOL)isIphone
{
    NSString* deviceType = [UIDevice currentDevice].model;
    return [deviceType rangeOfString:@"iPhone"].length > 0;
}
/**
 *  判断是否是ipod
 *
 *  @return YES 是
 */
+ (BOOL)isIpod
{
    NSString* deviceType = [UIDevice currentDevice].model;
    return [deviceType rangeOfString:@"iPod"].length > 0;
}

/**
 *  判断是否是ipad
 *
 *  @return YES 是
 */
+ (BOOL)isIpad
{
    NSString* deviceType = [UIDevice currentDevice].model;
    return [deviceType rangeOfString:@"iPad"].length > 0;
}
/**
 *  判断是否是ios7
 *
 *  @return YES 是
 */
+ (BOOL)isIos7
{
    return [[UIDevice currentDevice].systemVersion floatValue] >= 7.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 8.0;
}
/**
 *  判断是否是ios7.0
 *
 *  @return YES 是
 */
+ (BOOL)isIos7_0
{
    return [[UIDevice currentDevice].systemVersion floatValue] >= 7.0 && [[UIDevice currentDevice].systemVersion doubleValue] < 7.1;
}
/**
 *  判断是否是ios8
 *
 *  @return YES 是
 */
/**
 *  判断是否是ios8
 *
 *  @return YES 是
 */
+ (BOOL)isIos8
{
    return [[UIDevice currentDevice].systemVersion doubleValue] >= 8.0;
}

@end
