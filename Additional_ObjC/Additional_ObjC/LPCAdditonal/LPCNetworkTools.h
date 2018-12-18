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

/** 上传图片 --> 适用于上传多张照片，但是服务器名称是用一个名称的（可以是带"【】"的） */
- (void)upLoadImageArray:(NSString *)url parameters:(id)parameter imageArray:(NSArray *)uploadImages ServerName:(NSString *)name andCallBlock: (void (^) (id response, NSError *error))callBlock;

/** 上传图片 --> 适用于上传多张照片,服务器名称是不相同的 */
- (void)upLoadImageArrayS:(NSString *)url parameters:(id)parameter imageArray:(NSArray *)uploadImages ServerNameArray:(NSArray *)nameArray andCallBlock: (void (^) (id response, NSError *error))callBlock;

#pragma mark ---↓---↓---↓--- 写接口的封装 ---↓---↓---↓---
//MARK:商城导航接口
- (void)requestCloudMallHomePageCategories:(NSString *)dataCategories andCallBack:(void(^)(id response , NSError *error))callBack;

//MARK:商城首页接口
- (void)requestCloudMallHomePageData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack;

//MARK:登陆接口
- (void)requestLoginURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack;

//MARK:注册
- (void)requestRegisterURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack;

//MARK:判断手机号是否注册
- (void)requestChargephoneURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack;

//MARK:验证码
- (void)requestMessagecodeURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack;

/** 发现 - 获取资讯 */
- (void)requestMsggetURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack;

/** 收益券详情 */
- (void)requestVolumesinfoURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack;

/** 收益券详情列表 */
- (void)requestVolumesURLData:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack;

/** 公共的请求接口 */
- (void)requestCommonsURL:(NSString *)url Data:(NSString *)data andCallBack:(void(^)(id response , NSError *error))callBack;

/** 上传多张照片,服务器名称是不相同的 - 字典传 */
- (void)upLoad:(NSString *)url parameters:(id)parameter UploadImagesDict:(NSMutableDictionary *)uploadImagesDict ServerNameArray:(NSArray *)nameArray andCallBlock: (void (^) (id response, NSError *error))callBlock;

/** 适用于上传多张照片,服务器名称是可以是相同的 - 字典传 */
- (void)upLoad02:(NSString *)url parameters02:(id)parameter UploadImagesDict02:(NSMutableDictionary *)uploadImagesDict ServerNameArray02:(NSArray *)nameArray andCallBlock02: (void (^) (id response, NSError *error))callBlock;

/** 查询物流 */
- (void)requestCheckLogistics:(NSString *)comStr nu:(NSString *)numStr andCallBack:(void(^)(id response , NSError *error))callBack;

/** 欢迎页接口 */
- (void)requestCommonsURL:(NSString *)url andCallBack:(void(^)(id response , NSError *error))callBack;

/** 支付接口 */
//- (void)requestBoingPaySDKToken:(NSString *)payToken controller:(UIViewController *)controller options:(NSString *)options paymentResult:(void(^)(NSString *resultCode,NSString *resultMsg))paymentResult;



@end
