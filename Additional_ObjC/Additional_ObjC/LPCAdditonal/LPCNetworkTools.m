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

#pragma mark --> 上传图片
- (void)upLoadImageArray:(NSString *)url parameters:(id)parameter imageArray:(NSArray *)uploadImages ServerName:(NSString *)name andCallBlock: (void (^) (id response, NSError *error))callBlock {
    
    /*
     测试网络
     NSDictionary *dict = @{ @"username":@"Syl" };
     URL:@"http://120.25.226.186:32812/upload"
     */
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<uploadImages.count; i++) {

            UIImage *uploadImage = uploadImages[i];
            NSData *data = UIImageJPEGRepresentation(uploadImage,0.5f);
            NSString *curWholeFileName = [NSString stringWithFormat: @"consume_photo%d.jpg", i];
            /*
             Data: 需要上传的数据
             name: 服务器参数的名称 @"consume_photo[]"
             fileName: 文件名称
             mimeType: 文件的类型
             */
            [formData appendPartWithFileData:data name:name fileName:curWholeFileName mimeType:@"image/jpg"];
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

#pragma mark --> //MARK:上传图片 --> 适用于上传多张照片,服务器名称是不相同的
- (void)upLoadImageArrayS:(NSString *)url parameters:(id)parameter imageArray:(NSArray *)uploadImages ServerNameArray:(NSArray *)nameArray andCallBlock: (void (^) (id response, NSError *error))callBlock {
    
    /*
     测试网络
     NSDictionary *dict = @{ @"username":@"Syl" };
     URL:@"http://120.25.226.186:32812/upload"
     */
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
    [manager POST:url parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0; i<uploadImages.count; i++) {
            
            UIImage *uploadImage = uploadImages[i];
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

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


#pragma mark ---↓---↓---↓--- 写接口的封装 ---↓---↓---↓---

- (void)requestCloudMallHomePageCategories:(NSString *)dataCategories andCallBack:(void(^)(id response , NSError *error))callBack {
    
    NSDictionary *parDict = @{
                              @"data":dataCategories
                              };
    
    [self requestWithType:POST andUrl:CloudMallHomePageCategories andParams:parDict andCallBlock:callBack];
}

- (void)requestCloudMallHomePageData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack {

    NSDictionary *parDict = @{
                              @"data":data
                              };
  
    [self requestWithType:POST andUrl:CloudMallHomePage andParams:parDict andCallBlock:callBack];
}


- (void)requestLoginURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack {
    
    NSDictionary *parDict = @{
                              @"data":data
                              };
    
    [self requestWithType:POST andUrl:LoginURL andParams:parDict andCallBlock:callBack];
}

- (void)requestRegisterURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack {
    
    NSDictionary *parDict = @{
                              @"data":data
                              };
    
    [self requestWithType:POST andUrl:RegisterURL andParams:parDict andCallBlock:callBack];
}

- (void)requestChargephoneURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack {
    
    NSDictionary *parDict = @{
                              @"data":data
                              };
    
    [self requestWithType:POST andUrl:ChargephoneURL andParams:parDict andCallBlock:callBack];
}

- (void)requestMessagecodeURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack {
    
    NSDictionary *parDict = @{
                              @"data":data
                              };
    
    [self requestWithType:POST andUrl:MessagecodeURL andParams:parDict andCallBlock:callBack];
}

- (void)requestMsggetURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack {
    
    NSDictionary *parDict = @{
                              @"data":data
                              };
    
    [self requestWithType:POST andUrl:MsggetURL andParams:parDict andCallBlock:callBack];
}

- (void)requestVolumesinfoURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack {
    
    NSDictionary *parDict = @{
                              @"data":data
                              };
    
    [self requestWithType:POST andUrl:VolumesinfoURL andParams:parDict andCallBlock:callBack];
}

- (void)requestVolumesURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack {
    
    NSDictionary *parDict = @{
                              @"data":data
                              };
    
    [self requestWithType:POST andUrl:VolumesURL andParams:parDict andCallBlock:callBack];
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


#pragma mark --> 查询物流
- (void)requestCheckLogistics:(NSString *)comStr nu:(NSString *)numStr andCallBack:(void(^)(id response , NSError *error))callBack {
    
    NSDictionary *dict = @{
                           @"com":comStr,
                           @"num":numStr
                           };
    NSString *paramStr = [commonTool JsonModel:dict];
    
    //公司编号
    NSString *customer = @"029CD38D3DA36AD2E9CB8289C663AB0D";
    NSString *key = @"IpBuAyOz1844";
    NSString *MD5Str = [self md5:[NSString stringWithFormat:@"%@%@%@",paramStr,key,customer]];
    
    NSDictionary *param = @{
                            @"param":paramStr,
                            @"sign":MD5Str,
                            @"customer":customer
                            };

    [self requestWithType:POST andUrl:@"http://poll.kuaidi100.com/poll/query.do" andParams:param andCallBlock:callBack];
}


- (NSString *) md5:(NSString *) input {
    
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return  output;
}


/** 欢迎页接口 */
- (void)requestCommonsURL:(NSString *)url andCallBack:(void(^)(id response , NSError *error))callBack {
    
    [self requestWithType:POST andUrl:url andParams:nil andCallBlock:callBack];
}


/** 支付接口 */
//- (void)requestBoingPaySDKToken:(NSString *)payToken controller:(UIViewController *)controller options:(NSString *)payName paymentResult:(void(^)(NSString *resultCode,NSString *resultMsg))paymentResult {

    //payToken  唤起超级收银台支付的支付令牌
    /*
     * channel:  传递支持的支付通道的键值
     *           //目前支持以下两种支付通道
     *           PAY_CHANNEL_ALIPAY 支付宝
     *           PAY_CHANNEL_WXPAY 微信
     */
    //controller  工程结构中必须有NavigationController这个导航控制器
    //paymentResult 通过超级收银台支付后的结果回调
//    [Cashier createPayment:payToken options:@{@"channel":payName} controller:controller paymentResult:^(NSString *resultCode, NSString *resultMsg) {
//        paymentResult(resultCode,resultMsg);
//    }];
//}


@end
