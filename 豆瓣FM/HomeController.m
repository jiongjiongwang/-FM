//
//  HomeController.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/14.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "HomeController.h"
#import "SongModel.h"


@interface HomeController ()

//歌曲信息
@property (nonatomic,strong)SongModel *songDataModel;


@end

@implementation HomeController




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title  = @"华语歌曲";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [SongModel getSongDataWithChannelID:@"1" Sucess:^(NSArray<SongModel *> *songDataArray) {
        
        SongModel *model = songDataArray[0];
        
        self.songDataModel = model;
        
        //基本信息
        NSLog(@"歌曲图片地址为:%@",model.picture);
        NSLog(@"歌曲名为:%@",model.title);
        NSLog(@"歌手名:%@",model.artist);
        NSLog(@"歌曲链接地址:%@",model.url);
        
        //扩展信息
        NSLog(@"专辑名:%@",model.albumtitle);
        NSLog(@"专辑发行时间%@",model.public_time);
        NSLog(@"歌手名:%@",model.singers[0].name);
        NSLog(@"歌手的图片地址:%@",model.singers[0].avatar);
        
        
    } Error:^{
        
        NSLog(@"网络异常，歌曲获取失败");
        
    }];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
