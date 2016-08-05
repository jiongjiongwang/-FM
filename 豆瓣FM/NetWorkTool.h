//
//  NetWorkTool.h
//  网易新闻
//
//  Created by 王炯 on 16/6/28.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "AFNetworking.h"
#import "TokenModel.h"


//  创建一个AFHTTPSessionManager的单例子类，用于提供链接网络的工具
@interface NetWorkTool : AFHTTPSessionManager

+(instancetype)sharedWorkTool;


//发送GET请求
-(void)GETWebData:(NSString *)urlString
        parameters:(id)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure;



//发送POST请求
-(void)POSTWebData:(NSString *)urlString
        parameters:(id)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure;

//在类中声明一个指定方法请求accessToken获取授权
-(void)POSTAccessTokenWithCode:(NSString *)code
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure;


//在扩展中声明一个指定方法根据token获取用户的基本信息
-(void)GETUserInfo:(TokenModel *)model
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure;
@end
