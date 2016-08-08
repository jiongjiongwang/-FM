//
//  AuthViewModel.m
//  豆瓣FM
//
//  Created by 王炯 on 16/8/5.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "AuthViewModel.h"
#import "NetWorkTool.h"
#import "TokenModel.h"
#import "豆瓣FM-Swift.h"




//单例工具类，用于完成网络数据获取和归档解档一些作用
@implementation AuthViewModel


//单例接入点
+(instancetype)sharedAuthTool
{
    
    static AuthViewModel *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[AuthViewModel alloc] init];

    });
    
    
    return instance;
}


//重写init方法，单例对象一初始化时就先从本地获取到有没有归档的数据存在，防止以后重复获取本地数据
-(instancetype)init
{
    if (self = [super init])
    {
        self.userModel = [self LoadViewModelData];
    }
    return self;
}


//重写accessToken的get方法，从外界获取信息更新accessToken属性值
-(NSString *)accessToken
{
    
     //当用户模型里面有accessToken时
    if (_userModel.access_token != nil)
    {
        // 看是否过期
        // 当前保存的日期与当前日期对比 如果为降序 为未过去
       if([_userModel.expires_Date compare:[NSDate date]] == NSOrderedDescending)
        {
            //表示没有过期，可以正常返回
            return _userModel.access_token;
        }
        else
        {
            //表示已经过期
            return nil;
        }
    }
    else
    {
        // 代表没有acceToken
        /*
         - 代表用户没有登录 或者没有保存数据
         */
        return nil;
    }
}


//重写isLogin的get方法
-(BOOL)isLogin
{
    
    return (self.accessToken != nil) ? YES : NO;
    
}


//根据code获取网络授权信息
-(void)GetAccessTokenWithCode:(NSString *)code Success:(void (^)(BOOL))isSuccess
{
    
     //NSLog(@"GetAccessTokenWithCode传入的code是%@",code);
    //调用Swift的WeiBoNetWorkTool类才可以正确发送POST请求
    [WeiBoNetWorkTool.sharedTools POSTAccessToken:code success:^(id  _Nullable response) {
        
        //将responseObject强制转换成字典
        NSDictionary *responseDict = (NSDictionary *)response;
        
        //字典转模型
        TokenModel *model = [TokenModel TokenModelWithDict:responseDict];
        
        
        //获取用户信息
        [self GetUserInfo:model Success:isSuccess];
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
        //请求失败时返回给Controller返回失败信息
        isSuccess(NO);
        
        NSLog(@"获取Token失败");
        
    }];
    
    //调用OC的POST方法,有问题？？？
    /*
    //使用NetWorkTool，发送POST请求
    [[NetWorkTool sharedWorkTool] POSTAccessTokenWithCode:code success:^(id responseObject) {
       
        //将responseObject强制转换成字典
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        
        //字典转模型
        TokenModel *model = [TokenModel TokenModelWithDict:responseDict];
        
        
        //获取用户信息
        [self GetUserInfo:model Success:isSuccess];
        
        
    } failure:^(NSError *error) {
        
        
        //请求失败时返回给Controller返回失败信息
        isSuccess(NO);
        
        NSLog(@"获取Token失败");
        
    }];
    */
    
    
}


//根据token获取用户的基本信息
-(void)GetUserInfo:(TokenModel *)model
           Success:(void (^)(BOOL))isSuccess
{
    //GET用户信息
    [[NetWorkTool sharedWorkTool] GETUserInfo:model success:^(id responseObject) {
        
        //将responseObject强制转换成字典
        NSDictionary *responseDict = (NSDictionary *)responseObject;
        
        
      //将用户名和用户头像地址添加到当前model下
        model.screen_name = (NSString *)responseDict[@"screen_name"];
        model.avatar_large = (NSString *)responseDict[@"avatar_large"];
        
       // NSLog(@"用户名:%@",model.screen_name);
        //NSLog(@"用户头像地址:%@",model.avatar_large);
        
        //将从网上获取到的正确的网络信息归档
        [self SaveViewModelData:model];
        
        
        //告诉controller我已经成功获取到了用户的信息了(因为isSucc默认是false)
        isSuccess(YES);
        
        
        
    } failure:^(NSError *error) {
        
        
        isSuccess(NO);
        
        NSLog(@"数据获取失败");
        
        
    }];
}

//1-归档方法
-(void)SaveViewModelData:(TokenModel *)model
{
    //在归档方法之前，先把本地的model属性更新一下
    self.userModel = model;
    
    NSLog(@"%@",NSHomeDirectory());
    
    //归档方法
    [NSKeyedArchiver archiveRootObject:model toFile:kFilePath(@"DBUser.data")];
}

//2-解档方法
-(TokenModel *)LoadViewModelData
{
    //解档方法
    TokenModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath(@"DBUser.data")];
    
    return model;
}




@end


