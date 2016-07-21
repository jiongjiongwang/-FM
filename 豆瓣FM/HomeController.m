//
//  HomeController.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/14.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "HomeController.h"
#import "SongModel.h"


#import "AlumView.h"
#import "HeadImageView.h"
#import <UIImageView+WebCache.h>




#import <MediaPlayer/MediaPlayer.h>


@interface HomeController ()

//歌曲信息
@property (nonatomic,strong)SongModel *songDataModel;


//专辑封面View
@property (nonatomic,weak)AlumView *alumView;


//歌曲名
@property (nonatomic,weak)UILabel *songNameLabel;

//演唱者名
@property (nonatomic,weak)UILabel *singerNameLabel;

//定义一个MPMoviePlayerController类型的变量
@property (nonatomic,strong)MPMoviePlayerController *audioPlayer;



//声明一个定时器，用于随时获取当前歌曲的播放时间
@property (nonatomic,strong)NSTimer *timer;


@end

@implementation HomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title  = @"华语歌曲";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化界面(界面上的控件做一次初始化)
    [self setUpUI];
    
    
    
    //初始化数据
    [self setUpDataWithChannelID:@"9"];
    
   
    
}

//初始化数据+刷新数据
-(void)setUpDataWithChannelID:(NSString *)channelID
{
    [SongModel getSongDataWithChannelID:channelID Sucess:^(NSArray<SongModel *> *songDataArray) {
        
        SongModel *model = songDataArray[0];
        
        _songDataModel = model;
        
        //基本信息
        NSLog(@"歌曲图片地址为:%@",model.picture);
        
        
        [self.alumView.headImageView sd_setImageWithURL:[NSURL URLWithString:model.picture] placeholderImage:[UIImage imageNamed:@"AlumImage"]];
        
        
        
        
        NSLog(@"歌曲名为:%@",model.title);
        
        self.songNameLabel.text = model.title;
        
        NSLog(@"歌手名:%@",model.artist);
        
        self.singerNameLabel.text = model.artist;
        
        NSLog(@"歌曲链接地址:%@",model.url);
        
        
        [self.audioPlayer stop];
        
        //获取歌曲文件
        self.audioPlayer.contentURL=[NSURL URLWithString:model.url];
        
        //播放歌曲
        [self.audioPlayer play];
        
        
        //先停掉定时器
        [self.timer invalidate];
        
        
        //初始化定时器
        [self setUpTimer];
        
        
        //扩展信息
        NSLog(@"专辑名:%@",model.albumtitle);
        NSLog(@"专辑发行时间%@",model.public_time);
        NSLog(@"歌手名:%@",model.singers[0].name);
        NSLog(@"歌手的图片地址:%@",model.singers[0].avatar);
        
        
    } Error:^{
        
        NSLog(@"网络异常，歌曲获取失败");
        
    }];
}

/**
 *  初始化界面
 */
-(void)setUpUI
{
    //(1)专辑封面图
    AlumView *alumView = [[AlumView alloc] init];
    
    
    self.alumView = alumView;
    
    alumView.backgroundColor = [UIColor whiteColor];
    
    
    //定义block内容
    alumView.isPlayBlock = ^(BOOL isPlay){
        
        if (isPlay)
        {
            [_audioPlayer play];
        }
        else
        {
            [_audioPlayer pause];
        }
    };
    
    
    [self.view addSubview:alumView];
    
   
    
    
    
    //设置专辑封面的约束
    [alumView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view).offset(160);
        make.centerX.equalTo(self.view.centerX);
        make.left.equalTo(self.view).offset(80);
        make.width.equalTo(alumView.height);
    }];
    
    
    
    
    
    //(2)歌曲名
    UILabel *songNameLabel = [[UILabel alloc] init];
    self.songNameLabel = songNameLabel;
    
    [songNameLabel setFont:[UIFont systemFontOfSize:18]];
    
    [songNameLabel setTextColor:[UIColor blackColor]];
    
    
    
    [self.view addSubview:songNameLabel];
    
    [songNameLabel makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(alumView.bottom).offset(40);
        
    }];
    
    
    
    
    
    
    //(3)演唱者名
    UILabel *singerNameLabel = [[UILabel alloc] init];
    self.singerNameLabel = singerNameLabel;
    
    [singerNameLabel setFont:[UIFont systemFontOfSize:15]];
    [singerNameLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:singerNameLabel];
    
    [singerNameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.centerX);
        make.top.equalTo(songNameLabel.bottom).offset(10);
    }];
    
    
    
    
    //(4)audioPlayer
    MPMoviePlayerController *audioPlayer = [[MPMoviePlayerController alloc] init];
    
    self.audioPlayer = audioPlayer;
    
    
    
    
}

//初始化定时器
-(void)setUpTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(UpdateSongInfo) userInfo:nil repeats:YES];
    
}

//随时更新歌曲当前信息
-(void)UpdateSongInfo
{
    //(1)获取播放器当前的播放时间
    NSTimeInterval currentTime = self.audioPlayer.currentPlaybackTime;
    
    NSLog(@"当前播放时间:%f",currentTime);
    
    //当时间大于0时
    if (currentTime > 0.0)
    {
         //(2)获取当前歌曲的播放总时间
        NSTimeInterval totalTime = self.audioPlayer.duration;
        
        NSLog(@"歌曲总时间:%f",totalTime);
        
        //(3)获取歌曲播放的百分比
        float rotation = currentTime/totalTime;
        
        NSLog(@"百分比%f",rotation);
        
        self.alumView.rotation = rotation;
        
    }
    
}





-(void)dealloc
{
    NSLog(@"VC销毁");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
