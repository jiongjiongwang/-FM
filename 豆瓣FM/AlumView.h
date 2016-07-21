//
//  AlumView.h
//  豆瓣FM
//
//  Created by 王炯 on 16/7/21.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadImageView.h"


@interface AlumView : UIView

@property (nonatomic,weak)HeadImageView *headImageView;

//从外界获取的歌曲播放进度来设置圆环的进度
@property (nonatomic,assign)float rotation;

//定义播放/暂停block
@property (nonatomic,copy) void(^isPlayBlock)(BOOL);

-(void)HeadImageGestureWithAddOrRemove:(BOOL) addFlag;


@end
