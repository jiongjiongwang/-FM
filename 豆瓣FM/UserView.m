//
//  UserView.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/24.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "UserView.h"
#import "AuthViewModel.h"
#import <UIImageView+WebCache.h>


@interface UserView()

//(1)用户头像
@property (nonatomic,weak)HeadImageView *headImageView;

//(2)用户的用户名
@property (nonatomic,weak)UILabel *nameLabel;


@end

@implementation UserView


//在初始化构造函数中添加HeadImageView控件
-(instancetype)init
{
    if (self = [super init])
    {
        //布局界面
        [self setUpUI];
    }
    
    
    return self;
}

-(void)setUpUI
{
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    //(1)头像
    HeadImageView *headImageView = [[HeadImageView alloc] init];
    self.headImageView = headImageView;
    //headImageView.image = [UIImage imageNamed:@"name"];
    //设置头像
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[AuthViewModel sharedAuthTool].userModel.avatar_large] placeholderImage:[UIImage imageNamed:@"name"]];
    [self addSubview:headImageView];
    
    
    //(2)用户名
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    //nameLabel.text = @"用户名是啥是啥是啥hahahaha好好好好好到的";
    //设置用户名
    nameLabel.text = [AuthViewModel sharedAuthTool].userModel.screen_name;
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.numberOfLines = 0;
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    //设置nameLabel的最大显示宽度
    nameLabel.preferredMaxLayoutWidth = SCREEN_LEFT_WIDTH * 0.8;
    [self addSubview:nameLabel];
}

//重新设置子控件的布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //(1)设置头像的约束
    [self.headImageView makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.equalTo(self.leading).offset(SCREEN_LEFT_WIDTH * 0.5 *0.8);
        make.top.equalTo(self.top).offset(40);
        make.height.width.equalTo(@75);
        
    }];
    
    
    //(2)设置用户名的约束
    [self.nameLabel makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headImageView.bottom).offset(10);
        make.centerX.equalTo(self.headImageView.centerX);
    }];
    
}


@end
