//
//  LabelAndImageButton.m
//  Additional_ObjC
//
//  Created by iOS-UI on 2018/12/18.
//  Copyright © 2018 UniqueCe. All rights reserved.
//

#import "LabelAndImageButton.h"

@interface LabelAndImageButton()

@property (nonatomic, assign) CGRect currentFrame;

@end

@implementation LabelAndImageButton


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    return CGRectMake(10, 0, self.frame.size.width - 20, self.currentFrame.size.height - 20);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    return CGRectMake(-5, self.currentFrame.size.height -10, self.currentFrame.size.width+10, 20);
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    self.currentFrame=self.frame;
    
}

@end
