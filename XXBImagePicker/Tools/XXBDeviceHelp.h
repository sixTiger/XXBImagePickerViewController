//
//  XXBDeviceHelp.h
//  PIX72
//
//  Created by xiaoxiaobing on 14-12-24.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXBDeviceHelp : NSObject
/**
 *  判断是否是iphone
 *
 *  @return YES 是
 */
+ (BOOL)isIphone;
/**
 *  判断是否是ipod
 *
 *  @return YES 是
 */
+ (BOOL)isIpod;
/**
 *  判断是否是ipad
 *
 *  @return YES 是
 */
+ (BOOL)isIpad;
/**
 *  判断是否是ios7
 *
 *  @return YES 是
 */
+ (BOOL)isIos7;
/**
 *  判断是否是ios7.0
 *
 *  @return YES 是
 */

+ (BOOL)isIos7_0;
/**
 *  判断是否是ios8
 *
 *  @return YES 是
 */
+ (BOOL)isIos8;
@end
