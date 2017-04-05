//
//  UIBarButtonItem+Extension.m
//  Test
//
//  Created by 刘培策 on 16/10/6.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)setBarButtonTitle:(NSString *)title andTarget:(id)target  andAction:(SEL)action {
    
    UIBarButtonItem *barBut = [[UIBarButtonItem alloc]init];
    
    UIButton *itemBut = [[UIButton alloc]init];
    [itemBut setTitle:title forState:UIControlStateNormal];
    [itemBut setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [itemBut setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    itemBut.titleLabel.font = [UIFont systemFontOfSize:16];
    [itemBut sizeToFit];
    [itemBut addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    barBut.customView = itemBut;
    
    return barBut;
}

- (UIBarButtonItem *)setupUIBarButtonWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    
    UIImage *ima = image;
    
    ima = [ima imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *Item = [[UIBarButtonItem alloc] initWithImage:ima style:UIBarButtonItemStyleDone target:target action:action];
    
    return Item;
}

@end
