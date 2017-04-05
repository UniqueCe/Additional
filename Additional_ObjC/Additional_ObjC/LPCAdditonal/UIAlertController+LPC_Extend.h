//
//  UIAlertController+LPC_Extend.h
//  alertView
//
//  Created by lzhl_iOS on 2017/3/24.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (LPC_Extend)

/*
 ActionStyle 默认是UIAlertActionStyleDefault
*/

//MARK:创建AlertController
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message andActionTitle:(NSString *)actionTitle handler:(void(^)(UIAlertAction *action))handler;

//MARK:创建AlertSheetController
+ (instancetype)alertSheetControllerWithTitle:(NSString *)title message:(NSString *)message andActionTitle:(NSString *)actionTitle handler:(void(^)(UIAlertAction *action))handler;


@end
