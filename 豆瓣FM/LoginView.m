//
//  LoginView.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/24.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "LoginView.h"
#import "AuthViewController.h"


@interface LoginView()

//(1)头像
@property (nonatomic,weak)HeadImageView *headImageView;

//(2)登录按钮
@property (nonatomic,weak)UIButton *loginButton;

//(3)注册按钮
@property (nonatomic,weak)UIButton *registerButton;


@end


@implementation LoginView


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

//布局界面
-(void)setUpUI
{
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    //(1)头像
    HeadImageView *headImageView = [[HeadImageView alloc] init];
    self.headImageView = headImageView;
    headImageView.image = [UIImage imageNamed:@"name"];
    [self addSubview:headImageView];
    
    
    
    
    //(2)登录按钮
    UIButton *loginButton = [[UIButton alloc] init];
    self.loginButton = loginButton;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:18];
    
    //添加登录的触发事件
    [loginButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginButton];
    
    //(3)注册按钮
    UIButton *registerButton = [[UIButton alloc] init];
    self.registerButton = registerButton;
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:18];
    //添加注册的触发事件
    [registerButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerButton];
}


//重新布局界面，设置约束
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //(1)设置头像的约束
    [self.headImageView makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.equalTo(self.leading).offset(SCREEN_LEFT_WIDTH * 0.5 *0.8);
        make.top.equalTo(self.top).offset(50);
        make.height.width.equalTo(@75);
        
    }];
    
    //(2)设置登录按钮的约束
    [self.loginButton makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.headImageView.bottom).offset(10);
        make.right.equalTo(self.headImageView.centerX).offset(-20);
    }];
    
    //(3)设置注册按钮的约束
    [self.registerButton makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.headImageView.bottom).offset(10);
        make.left.equalTo(self.headImageView.centerX).offset(20);
    }];
    
}



//登录/注册按钮
-(void)clickButton:(UIButton *)btn
{
     //利用block让主VC进入AuthViewController
    if (self.enterWebBlock)
    {
        _enterWebBlock();
    }
    
    
   

}


@end
