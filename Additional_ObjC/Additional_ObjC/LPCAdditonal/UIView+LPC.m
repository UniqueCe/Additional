//
//  UIView+LPC.m
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import "UIView+LPC.h"

@implementation UIView (LPC)

#pragma mark - Frame

- (CGPoint)lpc_viewOrigin {
    
    return self.frame.origin;
}

- (void)setLpc_viewOrigin:(CGPoint)lpc_viewOrigin {
    
    CGRect newFrame = self.frame;
    
    newFrame.origin = lpc_viewOrigin;
    
    self.frame = newFrame;
}

- (CGSize)lpc_viewSize {
    
    return self.frame.size;
}

- (void)setLpc_viewSize:(CGSize)lpc_viewSize {
    
    CGRect newFrame = self.frame;
    
    newFrame.size = lpc_viewSize;
    
    self.frame = newFrame;
}

#pragma mark - Frame Origin

- (CGFloat)lpc_x {
    
    return self.frame.origin.x;
}

- (void)setLpc_x:(CGFloat)lpc_x {
    
    CGRect newFrame = self.frame;
    
    newFrame.origin.x = lpc_x;
    
    self.frame = newFrame;
}

- (CGFloat)lpc_y {
    
    return self.frame.origin.y;
}

- (void)setLpc_y:(CGFloat)lpc_y {
    
    CGRect newFrame = self.frame;
    
    newFrame.origin.y = lpc_y;
    
    self.frame = newFrame;
}

#pragma mark - Frame Size

- (CGFloat)lpc_width {
    
    return self.frame.size.width;
}

- (void)setLpc_width:(CGFloat)lpc_width {
    
    CGRect newFrame = self.frame;
    
    newFrame.size.width = lpc_width;
    
    self.frame = newFrame;
}

- (CGFloat)lpc_height {
    
    return self.frame.size.height;
}

- (void)setLpc_height:(CGFloat)lpc_height {
    
    CGRect newFrame = self.frame;
    
    newFrame.size.height = lpc_height;
    
    self.frame = newFrame;
}

#pragma mark - 返回屏幕截图
- (UIImage *)LPC_snapshotImage {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;

}

@end
