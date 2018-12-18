//
//  menuButton.m
//  NewGoldUnion
//
//  Created by 刘培策 on 17/6/3.
//  Copyright © 2017年 lzhl_iOS_LPC. All rights reserved.
//

#import "menuButton.h"
#import "UIView+LPC.h"

@implementation menuButton

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    if (self.imageView.X < self.titleLabel.X) {
        
        self.titleLabel.X = self.imageView.X;
        
        self.imageView.X = self.titleLabel.maxX + 10;
    }
}

@end
