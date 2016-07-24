//
//  AlumView.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/21.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "AlumView.h"


#define kcornerRadius MIN(self.headImageView.bounds.size.height/2, self.headImageView.bounds.size.width/2)

@interface AlumView()

//添加一个暂停的图片
@property (nonatomic,weak)HeadImageView *pauseImageView;

//定义点击图片手势
@property (nonatomic,strong)UITapGestureRecognizer *tap;

//定义一个BOOL属性，用于记录当前的转态是播放还是暂停
@property (nonatomic,assign)BOOL isPlay;

@end


@implementation AlumView

//懒加载点击手势
-(UITapGestureRecognizer *)tap
{
    if (_tap == nil)
    {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PauseSong:)];
    }
    
    return _tap;
}



//在初始化构造函数中添加HeadImageView控件
-(instancetype)init
{
    if (self = [super init])
    {
        
        //添加HeadImageView控件在上面
        HeadImageView *headImageView = [[HeadImageView alloc] initWithImage:[UIImage imageNamed:@"AlumImage"]];
        
        self.headImageView = headImageView;
        
        //打开图片交互
        headImageView.userInteractionEnabled = YES;
        
        [self addSubview:headImageView];
        
        
        
        
        
        
        //添加暂停的HeadImageView控件在上面
        HeadImageView *pauseImageView = [[HeadImageView alloc] initWithImage:[UIImage imageNamed:@"Pause"]];
        
        self.pauseImageView = pauseImageView;
        
        //打开图片的交互
        pauseImageView.userInteractionEnabled = YES;
        
        //暂停图片的透明度为0.8
        [pauseImageView setAlpha:0.8];
        
        //默认是隐藏状态
        pauseImageView.hidden = YES;
        
        [self addSubview:pauseImageView];
        
        
        
        //默认播放时YES
        self.isPlay = YES;
    }
    
    return self;
}

-(void)HeadImageGestureWithAddOrRemove:(BOOL) addFlag
{
    
    if (addFlag)
    {
        //NSLog(@"HeadImage添加tap手势");
        
        //将手势加载到headImageView上
        [self.headImageView addGestureRecognizer:self.tap];
    }
    else
    {
        //NSLog(@"HeadImage移除tap手势");
        
        //将手势移除headImageView上
        [self.headImageView removeGestureRecognizer:self.tap];
    }
    
}


//自动布局子控件时设置HeadImageView的约束
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //设置约束
    [self.headImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.equalTo(self).offset(10);
        
        make.bottom.right.equalTo(self).offset(-10);
        
    }];
    
    
    //设置暂停图片的约束
    [self.pauseImageView makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.equalTo(self).offset(5);
        
        make.bottom.right.equalTo(self).offset(-5);
    }];
    
    
    //先画一个灰色的圆环
    [self setNeedsDisplay];
    
}

//从外界获取rotation之后画一个圆弧
-(void)setRotation:(float)rotation
{
    _rotation = rotation;
    
    [self setNeedsDisplay];
}


-(void)drawRect:(CGRect)rect
{
    
    CGPoint center = self.headImageView.center;
    CGFloat radius = kcornerRadius;
    
    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = M_PI *2 +startAngle;

    
    
        //先画一个灰色的圆环
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        
        [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        
        path.lineWidth = 10;
        
        [path setLineCapStyle:kCGLineCapRound];
        
        [[UIColor lightGrayColor] setStroke];
        
        [path stroke];
    
    
    
    if (_rotation > 0)
    {
        
        UIBezierPath *GreenPath = [UIBezierPath bezierPath];
        
        //画一个圆环
        CGFloat greenEndAngle = M_PI *2*_rotation +startAngle;
        
        
        
        [GreenPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:greenEndAngle clockwise:YES];
        
        GreenPath.lineWidth = 10;
        
        [GreenPath setLineCapStyle:kCGLineCapRound];
        
        
        [[UIColor orangeColor] setStroke];
        
        [GreenPath stroke];
    }
    
    
}


//点击之后歌曲暂停(或播放)
-(void)PauseSong:(UITapGestureRecognizer *)tap
{
    
    //判断当前点击时，歌曲的状态是正在播放还是正在暂停
    //当前处于播放状态
    if (tap.view == self.headImageView)
    {
        //NSLog(@"点击播放图片了---->暂停");
        //(1)将暂停图片show出来
        self.pauseImageView.hidden = NO;
        
        //(2)告知控制器audio暂停播放
        self.isPlay = NO;
    
        
        //(3)暂停图片添加手势
        [self.pauseImageView addGestureRecognizer:self.tap];
        
        //(4)移除专辑图片的手势
        [self.headImageView removeGestureRecognizer:self.tap];
    }
    //当前处于暂停状态
    else
    {
        //NSLog(@"点击暂停图片了----->重新播放");
        //(1)将暂停图片隐藏一下
        self.pauseImageView.hidden = YES;
        
        //(2)告知控制器audio继续播放
        self.isPlay = YES;
        
        //(3)暂停图片移除手势
        [self.pauseImageView removeGestureRecognizer:self.tap];
        
        //(4)专辑图片添加手势
        [self.headImageView addGestureRecognizer:self.tap];
        
    }
    
    //调用block告知控制器暂停/重新播放
    
    __weak typeof(self) weakSelf = self;
    
    if (_isPlayBlock)
    {
        _isPlayBlock(weakSelf.isPlay);
    }
}


@end
