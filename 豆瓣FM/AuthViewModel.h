//
//  AuthViewModel.h
//  豆瓣FM
//
//  Created by 王炯 on 16/8/5.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TokenModel.h"


//单例工具类，用于完成网络数据获取和归档解档一些作用
@interface AuthViewModel : NSObject


+(instancetype)sharedAuthTool;


//声明一个用户模型
@property (nonatomic,strong)TokenModel *userModel;

//设置accessToken属性(需要时刻根据外面的信息来判断其属性值)
@property (nonatomic,copy)NSString *accessToken;

 //通过accessToken属性来判断用户有没有登录
@property (nonatomic,assign)BOOL isLogin;



//根据code获取网络授权信息
-(void)GetAccessTokenWithCode:(NSString *)code Success:(void (^)(BOOL))isSuccess;


@end
