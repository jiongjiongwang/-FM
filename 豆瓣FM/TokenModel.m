//
//  TokenModel.m
//  豆瓣FM
//
//  Created by 王炯 on 16/8/5.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "TokenModel.h"

@implementation TokenModel


//字典转模型的方法
+(instancetype)TokenModelWithDict:(NSDictionary *)dict
{
    
    TokenModel *model = [[TokenModel alloc] init];
    
    
    [model setValuesForKeysWithDictionary:dict];
    
    
    return model;
}


//处理未用到的键值
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


//重写expires_in的set方法来改变过期时间属性
-(void)setExpires_in:(NSTimeInterval)expires_in
{
    _expires_in = expires_in;
    
    
    _expires_Date = [NSDate dateWithTimeIntervalSinceNow:expires_in];
    
}

//对模型中的属性变量进行归档和解档
//1-归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:@"access_token"];
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_expires_Date forKey:@"expires_Date"];
    [aCoder encodeObject:_screen_name forKey:@"screen_name"];
    [aCoder encodeObject:_avatar_large forKey:@"avatar_large"];
    
}
//2-解档
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init])
    {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_Date = [aDecoder decodeObjectForKey:@"expires_Date"];
        self.screen_name = [aDecoder decodeObjectForKey:@"screen_name"];
        self.avatar_large = [aDecoder decodeObjectForKey:@"avatar_large"];
    }
    
    return self;
}



@end
