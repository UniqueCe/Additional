//
//  commonTool.h
//  NewGoldUnion
//
//  Created by lzhl_iOS on 2017/6/8.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface commonTool : NSObject

/** 判断手机号 */
+ (BOOL)checkPhoneNum:(NSString *)phoneNum;

/** 判断字符串 */
+ (BOOL)checkNullString:(NSString *)str;

/** 验证身份证 */
+ (BOOL)checkIdentityCard: (NSString *)identityCard;

/** 判断银行账号是否输入正确 */
+ (BOOL) checkCardNo:(NSString*) cardNo;

/** NSDate 与 NSString 转化 */
+ (NSDate *)dateFromString:(NSString *)dateString;

+ (NSString *)stringFromDate:(NSDate *)date;

/** 计算两个日期的时间差 */
+ (NSInteger)getDaysFrom:(NSDate *)serverDate
                      To:(NSDate *)endDate;

+ (NSInteger)getWeekday:(NSDate *)date;

/** 计算缓存大小 */
+ (NSString *)getCacheSize;

/** 单个文件大小 */
+ (long long)fileSizeAtPath:(NSString*)filePath;

/** 返回自适应高度的文本 */
+ (CGSize)sizeWithString:(NSString *)string
                fontSize:(CGFloat)font
                  maxWid:(CGFloat)maxWidth;

/** 返回自适应宽度的文本 */
+ (CGSize)sizeWithString:(NSString *)string
                fontSize:(CGFloat)font
                  maxHei:(CGFloat)maxHeight;

/** 判断字符串中包含数字和字母 */
+ (NSInteger)checkIsHaveNumAndLetter:(NSString*)password;

/** 字符串转成Json */
+ (NSString *)JsonModel:(NSDictionary *)dictModel;

/** 数组转json 不带空格和\n */
+ (NSString *)ObjectTojsonString:(id)object;

/**
 比较两个版本号的大小
 
 @param v1 第一个版本号
 @param v2 第二个版本号
 @return 版本号相等,返回0; v1小于v2,返回-1; 否则返回1.
 
 v1小于v2,返回-1, 不是最新版本 、版本号相等,返回0 、v1大于v2,返回1, 是最新版本
 */
+ (NSInteger)compareVersion:(NSString *)v1
                         to:(NSString *)v2;

/** JSON字符串转化为字典 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/** 纯色的图片 */
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;

@end






