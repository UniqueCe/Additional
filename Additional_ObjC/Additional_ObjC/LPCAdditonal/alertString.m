//
//  alertString.m
//  demo
//
//  Created by lzhl_iOS on 2017/10/16.
//  Copyright © 2017年 lianzhonghulian. All rights reserved.
//

#import "alertString.h"

@implementation alertString

static alertString* _instance = nil;

+ (instancetype) shareInstance {
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    return _instance ;
}

+ (void)showString:(NSString *)message Delay:(NSInteger)delay {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:true completion:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertVC dismissViewControllerAnimated:true completion:nil];
        });
    }];
}

@end
