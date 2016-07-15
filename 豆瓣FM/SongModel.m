//
//  SongModel.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/15.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "SongModel.h"

@implementation SongModel

/**
 *  KVC:字典转模型
 *
 *  @param dict 字典
 *
 *  @return 模型
 */
+(instancetype)SongModelWithDict:(NSDictionary *)dict
{
    SongModel *songModel = [[SongModel alloc] init];
    
    
    [songModel setValuesForKeysWithDictionary:dict];
    
    
    
    //取dict字典的singers键值
    NSArray *singerArray = dict[@"singers"];
    
    //声明可变数组
    NSMutableArray *mArray = [NSMutableArray array];
    
    
    //遍历singerArray数组
    [singerArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        //SingerModel字典转模型
        SingerModel *singerModel = [SingerModel SingerModelWithDict:obj];
        
        [mArray addObject:singerModel];
        
    }];
    
    songModel.singers = mArray.copy;
    
    
    return songModel;
}


/**
 *
 *
 *  @param indexStr     歌曲频道
 *  @param successBlock 网络获取正确时调用的block
 *  @param errorBlock   网络获取错误时调用的block
 */
+(void)getSongDataWithChannelID:(NSString *)indexStr  Sucess:(void (^)(NSArray<SongModel *> *))successBlock Error:(void (^)())errorBlock
{
    
    
    [[NetWorkTool sharedWorkTool] GET:kSongWithChannel(indexStr) parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        
        //歌曲数组
        NSArray *songArray = responseObject[@"song"];
        
        //声明一个可变数组
        NSMutableArray *mArray = [NSMutableArray array];
        
        //遍历数组
        [songArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            //利用KVC返回一个SongModel(字典转模型)
            SongModel *model = [SongModel SongModelWithDict:obj];
            
            
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
