//
//  SingerModel.h
//  豆瓣FM
//
//  Created by 王炯 on 16/7/15.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingerModel : NSObject

//1-歌手名
@property (nonatomic,copy)NSString *name;

//2-歌手图片地址
@property (nonatomic,copy)NSString *avatar;


//KVC字典转模型
+(instancetype)SingerModelWithDict:(NSDictionary *)dict;


@end
