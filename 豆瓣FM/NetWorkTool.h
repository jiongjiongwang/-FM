//
//  NetWorkTool.h
//  网易新闻
//
//  Created by 王炯 on 16/6/28.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "AFNetworking.h"

//  创建一个AFHTTPSessionManager的单例子类，用于提供链接网络的工具
@interface NetWorkTool : AFHTTPSessionManager

+(instancetype)sharedWorkTool;

@end
