//
//  NSArray+LPC.m
//  Test
//
//  Created by 刘培策 on 16/12/13.
//  Copyright © 2016年 UniqueCe. All rights reserved.
//

#import "NSArray+LPC.h"

@implementation NSArray (LPC)

+ (NSArray *)LPC_objectListWithPlistName:(NSString *)plistName clsName:(NSString *)clsName {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:plistName withExtension:nil];
    NSArray *list = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    Class cls = NSClassFromString(clsName);
    //断言--判断clsName是否正确
    NSAssert(cls, @"加载 plist 文件时指定的 clsName - %@ 错误", clsName);
    
    for (NSDictionary *dict in list) {
        
        [arrayM addObject:[cls LPC_objectWithDict:dict]];
    }
    
    return arrayM.copy;
}

+ (instancetype)LPC_arrayWithURL:(NSURL *)url clasName:(NSString *)className{
    
    NSArray *array = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dict in array) {

        NSObject *obj = [NSObject LPC_objWithClassName:className dict:dict];
        
        [arrayM addObject:obj];
    }
    return arrayM.copy;
}

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





@implementation NSObject (LPC)

+ (instancetype)LPC_objectWithDict:(NSDictionary *)dict {
    
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

+ (instancetype)LPC_objWithClassName:(NSString *)className dict:(NSDictionary *)dict{
    
    //把传入的字符串转换成一个Class结构体
    Class clz = NSClassFromString(className);
    
    //创建一个对象
    NSObject *obj = [[clz alloc]init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}


@end
