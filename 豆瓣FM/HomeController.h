//
//  HomeController.h
//  豆瓣FM
//
//  Created by 王炯 on 16/7/14.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "channelModel.h"


@interface HomeController : UIViewController

//从外界获取的channelModel信息，用于设置播放的频道
@property (nonatomic,strong)channelModel *model;


@end
