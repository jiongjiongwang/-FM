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
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        
        //3.请求格式（默认：二进制）
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        
        
       //设置一下timeout时间
        config.timeoutIntervalForRequest = 15;
    });
    
    
    return instance;
}


@end
