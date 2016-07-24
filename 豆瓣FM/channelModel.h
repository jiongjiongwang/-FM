//
//  channelModel.h
//  豆瓣FM
//
//  Created by 王炯 on 16/7/24.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface channelModel : NSObject


//有关频道的两个属性
//(1)频道名
@property (nonatomic,copy)NSString *name;

//(2)频道的channel_id
@property (nonatomic,copy)NSString *channel_id;

//KVC:字典转模型
+(instancetype)channelModelWithDict:(NSDictionary *)dict;

//返回网络数据数组
+(void)getChannelData:(void (^)(NSArray<channelModel *> *))successBlock Error:(void (^)())errorBlock;



@end
