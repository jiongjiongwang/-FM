//
//  SomeNets.h
//  FastDoctor
//
//  Created by 王炯 on 16/7/6.
//  Copyright © 2016年 sc. All rights reserved.
//

#ifndef SomeNets_h
#define SomeNets_h



//获取网络上的频道信息
#define kChannelUrl @"http://www.douban.com/j/app/radio/channels"


//获取网络上某一频道的当前歌曲信息
#define kSongWithChannel(channel_id) ([NSString stringWithFormat:@"http://douban.fm/j/mine/playlist?type=n&channel=%@&from=mainsite",channel_id])



#endif /* SomeNets_h */
