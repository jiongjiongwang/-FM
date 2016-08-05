//
//  TokenModel.h
//  豆瓣FM
//
//  Created by 王炯 on 16/8/5.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TokenModel : NSObject<NSCoding>

//用户token获取到的信息
//1-Token
@property (nonatomic,copy)NSString *access_token;

//2-uid
@property (nonatomic,copy)NSString *uid;

//3-expires_in
@property (nonatomic,assign)NSTimeInterval expires_in;

//4-获取的用户信息:用户名
@property (nonatomic,copy)NSString *screen_name;

//5-用户头像地址
@property (nonatomic,copy)NSString *avatar_large;

//6-过期时间,会随着expires_in的改变而改变
@property (nonatomic,strong)NSDate *expires_Date;


//字典转模型构造方法
+(instancetype)TokenModelWithDict:(NSDictionary *)dict;




@end
