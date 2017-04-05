//
//  NSArray+test.m
//  百思不得姐数据解析
//
//  Created by 刘培策 on 16/8/25.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import "NSArray+test.h"

@implementation NSArray (test)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *stringM = [NSMutableString string];
 
    [stringM appendString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [stringM appendFormat:@"\t%@\n",obj];
        
    }];
    
    [stringM appendString:@")\n"];

    return stringM;
}

@end

@implementation NSDictionary (test)

-(NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [strM appendFormat:@"\t%@ = %@;\n",key,obj];
        
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}

@end