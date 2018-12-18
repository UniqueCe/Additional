//
//  UIButton+LPC.h
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LPC)

/**
 创建文本按钮

 @param title 文本
 @param fontSize 字体大小
 @param normalColor 默认颜色
 @param selectedColor 选中颜色
 @return UIButton
 */
+ (instancetype)LPC_ButtonWithTitle:(NSString *)title
                           fontSize:(CGFloat)fontSize
                        normalColor:(UIColor *)normalColor
                      selectedColor:(UIColor *)selectedColor
                             Target:(id)target
                             Action:(SEL)action;

/**
 创建背景图片变换带文字的Button

 @param NormalTitle 默认文字
 @param selectTitle 选中文字
 @param BgNormalImage 默认背景图片
 @param BgSelectedImage 选中背景图片
 @param target target
 @param action 方法
 @return 背景图片变换带文字的Button
 */
+ (instancetype)LPC_ButtonWithTitle:(NSString *)NormalTitle
                        SelectTitle:(NSString *)selectTitle
                        normalImage:(NSString *)BgNormalImage
                      selectedImage:(NSString *)BgSelectedImage
                             Target:(id)target
                             Action:(SEL)action;


/**
 图片Button

 @param normalImage 默认图片
 @param selectedImage 选中图片
 @param target target
 @param action 方法
 @return 图片Button
 */
+ (instancetype)LPC_ButtonWithNormalImage:(NSString *)normalImage
                            selectedImage:(NSString *)selectedImage
                                   Target:(id)target
                                   Action:(SEL)action;



/**
 文本字体颜色变化的Button

 @param NormalTitle 默认文字
 @param selectTitle 选中文字
 @param normalColor 默认文本颜色
 @param selectedColor 选中文本颜色
 @param target target
 @param action 方法
 @return 文本字体颜色变化的Button
 */
+ (instancetype)LPC_ButtonWithTitle:(NSString *)NormalTitle
                        SelectTitle:(NSString *)selectTitle
                        normalColor:(UIColor *)normalColor
                      selectedColor:(UIColor *)selectedColor
                             Target:(id)target
                             Action:(SEL)action;





@end
