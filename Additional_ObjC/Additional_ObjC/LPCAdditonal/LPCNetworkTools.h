//
//  LPCNetworkTools.h
//  OC的网络封装
//
//  Created by 刘培策 on 16/9/21.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum : NSUInteger {
    GET,
    POST
} RequestType;


@interface LPCNetworkTools : AFHTTPSessionManager

@property(nonatomic,strong) AFHTTPSessionManager *manager;

+ (instancetype)sharedTools;

//MARK:下载文件
- (void)downLoadMonitorWithURL:(NSURL *)url;

/** 公共的请求接口 */
- (void)requestCommonsURL:(NSString *)url Data:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack;

/** 上传多张照片,服务器名称是不相同的 - 字典传 */
- (void)upLoad:(NSString *)url parameters:(id)parameter UploadImagesDict:(NSMutableDictionary *)uploadImagesDict ServerNameArray:(NSArray *)nameArray andCallBlock: (void (^) (id response, NSError *error))callBlock;

/** 适用于上传多张照片,服务器名称是可以是相同的 - 字典传 */
- (void)upLoad02:(NSString *)url parameters02:(id)parameter UploadImagesDict02:(NSMutableDictionary *)uploadImagesDict ServerNameArray02:(NSArray *)nameArray andCallBlock02: (void (^) (id response, NSError *error))callBlock;



@end
