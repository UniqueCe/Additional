//
//  UIColor+LPC.m
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import "UIColor+LPC.h"

@implementation UIColor (LPC)

+ (instancetype)LPC_colorWithHex:(int32_t)hex alpha:(CGFloat)alpha{
    
    //hex = 0xA3 B2 FF
    int red = hex & 0xFF0000 >> 16;
    
    int green = hex & 0x00FF00 >> 8;
    
    int blue = hex & 0x0000FF;
    
    UIColor *color = [UIColor LPC_colorWithR:red G:green B:blue alpha:alpha];
    
    return color;
}

+ (instancetype)LPC_colorWithHex:(int32_t)hex {
    
    UIColor *color = [UIColor LPC_colorWithHex:hex alpha:1];
    
    return color;
}

+ (instancetype)LPC_colorWithR:(int)red G:(int)green B:(int)blue alpha:(CGFloat)alpha{
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (instancetype)LPC_randomColor{
    
    return [UIColor LPC_colorWithR:arc4random_uniform(256) G:arc4random_uniform(256) B:arc4random_uniform(256) alpha:1];
}

/**
 字符串颜色 例#333333
 */
+ (UIColor *)colorWithHexString:(NSString *)hexStr {
    if ([hexStr hasPrefix:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
    } else if ([hexStr hasPrefix:@"0X"]) {
        hexStr = [hexStr substringFromIndex:2];
    }
    if ([hexStr length]!=6 && [hexStr length]!=3)
    {
        return nil;
    }
    
    NSUInteger digits = [hexStr length]/3;
    CGFloat maxValue = (digits==1)?15.0:255.0;
    
    CGFloat (^hexStringToFloat)(NSString *string) = ^CGFloat(NSString *string) {
        unsigned long result = 0;
        sscanf([string UTF8String], "%lx", &result);
        return result/maxValue;
    };
    
    CGFloat red = hexStringToFloat([hexStr substringWithRange:NSMakeRange(0, digits)]);
    CGFloat green = hexStringToFloat([hexStr substringWithRange:NSMakeRange(digits, digits)]);
    CGFloat blue = hexStringToFloat([hexStr substringWithRange:NSMakeRange(2*digits, digits)]);
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
