//
//  ViewController.m
//  Additional_ObjC
//
//  Created by 刘培策 on 17/4/5.
//  Copyright © 2017年 UniqueCe. All rights reserved.
//

#import "ViewController.h"
#import "Addition.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [alertString showString:@"眼小不说话" Delay:1];
}


@end
