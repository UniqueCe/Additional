 //
//  LPCNetworkTools.m
//  OC的网络封装
//
//  Created by 刘培策 on 16/9/21.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import "LPCNetworkTools.h"
#import <CommonCrypto/CommonDigest.h>  
//#import <BoingPaySDK/Cashier.h>


static LPCNetworkTools *tools;

@implementation LPCNetworkTools

+ (instancetype)sharedTools {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        tools = [[LPCNetworkTools alloc] init];

        tools.manager = [AFHTTPSessionManager manager];
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"text/javascript"];
        tools.responseSerializer.acceptableContentTypes = [tools.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
        /*
        [tools.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    [SVProgressHUD showInfoWithStatus:@"手机自带网络"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [SVProgressHUD showInfoWithStatus:@"WIFI连接"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    break;
                case AFNetworkReachabilityStatusUnknown:
                    [SVProgressHUD showInfoWithStatus:@"连接状态未知"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    [SVProgressHUD showInfoWithStatus:@"无连接,请检查网络!!!"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                    });
                    break;
            }
            
            //网络超时的时间设置
            //        tools.requestSerializer.timeoutInterval = 15.0f;
        }];
        */
        [tools.reachabilityManager startMonitoring];
        
    });
    
    return tools;
}

#pragma mark --> 网络请求封装
- (void)requestWithType: (RequestType)type andUrl: (NSString *)url andParams: (id)params andCallBlock: (void (^) (id response, NSError *error))callBlock {
    
    if (type == GET) {
        [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            callBlock(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            callBlock(nil, error);
        }];
        
    } else {
        
        [self POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            callBlock(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            callBlock(nil, error);
        }];
    }
}


#pragma mark --> 执行下载文件的方法,可以监控下载进度
- (void)downLoadMonitorWithURL:(NSURL *)url {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //[NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_02.mp4"]
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        CGFloat jindu = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        
        NSLog(@"下载进度%0.1f",jindu*100);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //MARK:返回路径
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        NSLog(@"error=%@",error);
        NSLog(@"filePath=%@",filePath);
    }];
    //MARK:必须要启动任务
    [downloadTask resume];
}

/** 公共的请求接口 */
- (void)requestCommonsURL:(NSString *)url Data:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack {
    
    NSDictionary *parDict = @{
                              @"data":data
                              };
    
    [self requestWithType:POST andUrl:url andParams:parDict andCallBlock:callBack];
}


#pragma mark --> 适用于上传多张照片,服务器名称是不相同的 - 字典传
- (void)upLoad:(NSString *)url parameters:(id)parameter UploadImagesDict:(NSMutableDictionary *)uploadImagesDict ServerNameArray:(NSArray *)nameArray andCallBlock: (void (^) (id response, NSError *error))callBlock {
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<nameArray.count; i++) {
            
            UIImage *uploadImage = [uploadImagesDict objectForKey:nameArray[i]];
            NSData *data = UIImageJPEGRepresentation(uploadImage,0.5f);
            NSString *curWholeFileName = [NSString stringWithFormat: @"file%d.jpg", i];
            /*
             Data: 需要上传的数据
             name: 服务器参数的名称
             fileName: 文件名称
             mimeType: 文件的类型
             */
            
            NSString *str = [NSString stringWithFormat:@"%@",nameArray[i]];
            
            [formData appendPartWithFileData:data name:str fileName:curWholeFileName mimeType:@"image/jpg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"上传进度=%f=",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *dict = [self dictionaryWithJsonString:str];
        
        callBlock(dict ,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        callBlock(nil , error);
    }];
}

#pragma mark --> 适用于上传多张照片,服务器名称是可以是相同的 - 字典传
- (void)upLoad02:(NSString *)url parameters02:(id)parameter UploadImagesDict02:(NSMutableDictionary *)uploadImagesDict ServerNameArray02:(NSArray *)nameArray andCallBlock02: (void (^) (id response, NSError *error))callBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<nameArray.count; i++) {
            
            UIImage *uploadImage = [uploadImagesDict objectForKey:nameArray[i]];
            NSData *data = UIImageJPEGRepresentation(uploadImage,0.5f);
            NSString *curWholeFileName = [NSString stringWithFormat: @"file%d.jpg", i];
            /*
             Data: 需要上传的数据
             name: 服务器参数的名称
             fileName: 文件名称
             mimeType: 文件的类型
             */
            
            NSMutableString *str = [NSMutableString stringWithFormat:@"%@",nameArray[i]];
            
            if ([str hasPrefix:@"nscp"]) {
                
                [str deleteCharactersInRange:NSMakeRange(str.length-2, 2)];
            }
    
            [formData appendPartWithFileData:data name:str fileName:curWholeFileName mimeType:@"image/jpg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"上传进度=%f=",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *dict = [self dictionaryWithJsonString:str];
        
        callBlock(dict ,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        callBlock(nil , error);
    }];
}



@end
