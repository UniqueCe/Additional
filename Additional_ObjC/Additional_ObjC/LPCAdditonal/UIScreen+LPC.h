//
//  UIScreen+LPC.h
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (LPC)

/**
 屏幕宽度
 */
+ (CGFloat)LPC_screenWidth;

/**
 屏幕高度
 */
+ (CGFloat)LPC_screenHeight;

/**
 分辨率
 */
+ (CGFloat)LPC_scale;

@end
