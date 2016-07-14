//
//  HomeController.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/14.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "HomeController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title  = @"主界面";
    
    self.view.backgroundColor = [UIColor redColor];
    
    //获取频道信息
    /*
    [[NetWorkTool sharedWorkTool] GET:kChannelUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
     
        NSDictionary *channelDict = (NSDictionary *)responseObject;
        
        NSLog(@"%@",channelDict);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
    */
    /*
    //获取某一频道的歌曲信息
    [[NetWorkTool sharedWorkTool] GET:kSongWithChannel(@"1") parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSDictionary *songDict = (NSDictionary *)responseObject;
        
        NSLog(@"%@",songDict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"歌曲获取失败");
        
    }];
    */
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
