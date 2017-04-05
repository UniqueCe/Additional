//
//  UIScreen+LPC.m
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import "UIScreen+LPC.h"

@implementation UIScreen (LPC)

+ (CGFloat)LPC_screenWidth {
    
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)LPC_screenHeight {
    
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)LPC_scale {
    
    return [UIScreen mainScreen].scale;
}



@end
