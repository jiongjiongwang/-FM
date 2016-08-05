//
//  NetWorkTool.m
//  网易新闻
//
//  Created by 王炯 on 16/6/28.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "NetWorkTool.h"

@implementation NetWorkTool


+(instancetype)sharedWorkTool
{
    
    
    static NetWorkTool *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        
         instance = [[NetWorkTool alloc] initWithSessionConfiguration:config];
        
        //2.可接受格式
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
        
        //3.请求格式（默认：二进制）
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        
        
       //设置一下timeout时间
        //config.timeoutIntervalForRequest = 15;
    });
    
    
    return instance;
}

//发送POST请求
-(void)POSTWebData:(NSString *)urlString
        parameters:(id)parameters
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure
{
    
    NSLog(@"POSTWebData中urlString = %@",urlString);
    NSLog(@"POSTWebData中的%@",parameters);
    /*
    NSString *urlStrings = @"http://iosapi.itcast.cn/matchDoctors.json.php";
    NSDictionary *paramDic = @{@"ci1_id":@1,
                               @"ci2_id":@3,
                               @"ci3_id":@3,
                               @"diagnosis_type":@0,
                               @"page_size":@15,
                               @"is_confirmed":@1,
                               @"user_id":@1000089,
                               @"page":@1,
                               @"has_diagnosis":@2
                               };
     */
    
    
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
        NSLog(@"POST请求发送成功");
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        failure(error);
        
        NSLog(@"%@",error);
        
        NSLog(@"POST请求发送失败");
        
        
    }];
}


//发送GET请求
-(void)GETWebData:(NSString *)urlString
       parameters:(id)parameters
          success:(void (^)(id responseObject))success
          failure:(void (^)(NSError *error))failure
{
    [self GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        
        failure(error);
        
    }];
}


//在类中声明一个指定方法请求accessToken获取授权
-(void)POSTAccessTokenWithCode:(NSString *)code
                       success:(void (^)(id responseObject))success
                       failure:(void (^)(NSError *error))failure
{
    
    
    NSLog(@"POSTAccessTokenWithCode传入的code=%@",code);
    
    
    //1-urlString
    NSString *urlString = @"https://api.weibo.com/oauth2/access_token";
    
    //2-parameter
    NSDictionary *parameter = @{@"client_id":APPkey,
                                @"client_secret":APPsecret,
                                @"grant_type":@"authorization_code",
                                @"code":code,
                                @"redirect_uri":APPREDIRECT_URI};
    
    //3-发送POST请求
    [self POSTWebData:urlString parameters:parameter success:success failure:failure];
    
}

//在扩展中声明一个指定方法根据token获取用户的基本信息
-(void)GETUserInfo:(TokenModel *)model
           success:(void (^)(id responseObject))success
           failure:(void (^)(NSError *error))failure
{

    //1-urlString
    NSString *urlString = @"https://api.weibo.com/2/users/show.json";
    
    //2-判断model
    if (model.access_token != nil && model.uid != nil)
    {
        
        
        NSDictionary *param = @{@"access_token":model.access_token,
                                @"uid":model.uid};
        
        //发送GET请求
        [self GETWebData:urlString parameters:param success:success failure:failure];
    }
    else
    {
        return;
    }
}



@end
