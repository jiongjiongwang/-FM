//
//  channelModel.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/24.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "channelModel.h"

@implementation channelModel


//KVC:字典转模型
+(instancetype)channelModelWithDict:(NSDictionary *)dict
{
    channelModel *chModel = [[channelModel alloc] init];
    
    
    [chModel setValuesForKeysWithDictionary:dict];

    
    return chModel;
}

//返回网络数据数组
+(void)getChannelData:(void (^)(NSArray<channelModel *> *))successBlock Error:(void (^)())errorBlock
{
    [[NetWorkTool sharedWorkTool] GET:kChannelUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        
        //频道数组
        NSArray *channelArray = responseObject[@"channels"];
        
        //声明一个可变数组
        NSMutableArray *mArray = [NSMutableArray array];
        
        //遍历数组
        [channelArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            //利用KVC返回一个SongModel(字典转模型)
            channelModel *model = [channelModel channelModelWithDict:obj];
            
            
            [mArray addObject:model];
            
        }];
        
        
        //调用block返回网络数据
        if (successBlock)
        {
            successBlock(mArray.copy);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //调用错的block
        if (errorBlock)
        {
            errorBlock();
        }
        
    }];
}
//处理未被处理的键值
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}




@end
