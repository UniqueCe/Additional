//
//  UIView+LPC.h
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LPC)

#pragma mark - Frame
//视图原点
@property (nonatomic) CGPoint lpc_viewOrigin;
//视图尺寸
@property (nonatomic) CGSize lpc_viewSize;

#pragma mark - Frame Origin
//x
@property (nonatomic) CGFloat lpc_x;
//y
@property (nonatomic) CGFloat lpc_y;

#pragma mark - Frame Size
//width
@property (nonatomic) CGFloat lpc_width;
//height
@property (nonatomic) CGFloat lpc_height;

/**
 返回屏幕截图
 */
- (UIImage *)LPC_snapshotImage;

@end
