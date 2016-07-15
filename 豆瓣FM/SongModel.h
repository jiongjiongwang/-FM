//
//  SongModel.h
//  豆瓣FM
//
//  Created by 王炯 on 16/7/15.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingerModel.h"

@interface SongModel : NSObject

//主界面:歌曲基本信息
//1-歌曲图片
@property (nonatomic,copy)NSString *picture;

//2-歌曲名
@property (nonatomic,copy)NSString *title;

//3-歌唱者
@property (nonatomic,copy)NSString *artist;

//4-歌曲连接地址
@property (nonatomic,copy)NSString *url;


//其他界面:歌曲其他信息
//5-歌曲专辑名
@property (nonatomic,copy)NSString *albumtitle;

//6-歌曲发行时间
@property (nonatomic,copy)NSString *public_time;

//7-歌手图片地址(在数组内)
@property (nonatomic,copy)NSArray<SingerModel *> *singers;


//KVC:字典转模型
+(instancetype)SongModelWithDict:(NSDictionary *)dict;

//返回网络数据数组
+(void)getSongDataWithChannelID:(NSString *)indexStr  Sucess:(void (^)(NSArray<SongModel *> *))successBlock Error:(void (^)())errorBlock;


@end
