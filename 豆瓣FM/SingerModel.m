//
//  SingerModel.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/15.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "SingerModel.h"

@implementation SingerModel

/**
 *  KVC字典转模型
 *
 *  @param dict
 *
 *  @return 
 */
+(instancetype)SingerModelWithDict:(NSDictionary *)dict
{
    SingerModel *singerModel = [[SingerModel alloc] init];
    
    
    [singerModel setValuesForKeysWithDictionary:dict];
    
    return singerModel;
}

//处理未用到的键值
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}



@end
