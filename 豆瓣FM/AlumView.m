//
//  AlumView.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/21.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "AlumView.h"


#define kcornerRadius MIN(self.headImageView.bounds.size.height/2, self.headImageView.bounds.size.width/2)

@implementation AlumView

//在初始化构造函数中添加HeadImageView控件
-(instancetype)init
{
    if (self = [super init])
    {
        //添加HeadImageView控件在上面
        HeadImageView *headImageView = [[HeadImageView alloc] init];
        
        self.headImageView = headImageView;
        
        [self addSubview:headImageView];
        
    }
    
    return self;
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
        
        
        [[UIColor blueColor] setStroke];
        
        [GreenPath stroke];
    }
    
    
}



@end
