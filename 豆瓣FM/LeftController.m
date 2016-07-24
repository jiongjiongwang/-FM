//
//  LeftController.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/14.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "LeftController.h"
#import "LoginView.h"
#import "UserView.h"
#import "channelModel.h"


@interface LeftController ()



//上面的View界面(登录界面)
@property (nonatomic,strong)LoginView *loginView;

//上面的View界面(用户界面)
@property (nonatomic,strong)UserView *userView;

//下面的界面(tableView,显示频道信息)
@property (nonatomic,strong)UITableView *channelTable;



@end

@implementation LeftController

//懒加载3个控件
//(1)登录界面
-(LoginView *)loginView
{
    if (_loginView == nil)
    {
        _loginView = [[LoginView alloc] init];
    }
    
    return _loginView;
}
//(2)用户界面
-(UserView *)userView
{
    if (_userView == nil)
    {
        _userView = [[UserView alloc] init];
    }
    
    return _userView;
}
//(3)频道列表界面
-(UITableView *)channelTable
{
    if (_channelTable == nil)
    {
        //_channelTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _channelTable = [[UITableView alloc] init];
        
        //_channelTable.dataSource = self;
        //_channelTable.delegate = self;
    }
    
    return _channelTable;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //重新设置UI
    [self setUpUI];
    
}

//重新设置UI界面
-(void)setUpUI
{
    //(1)上面的界面(根据登录信息，没有登录的时候显示的是登录界面，有登录的时候显示的用户界面)
    //如果有登录
    if (self.isLogin)
    {
        //加载用户界面
        [self changesSignView:self.userView];
        //将登录界面移除
        [self.loginView removeFromSuperview];
    }
    //如果没有登录
    else
    {
        //加载登录界面
        [self changesSignView:self.loginView];
        //将用户界面移除
        [self.userView removeFromSuperview];
    }
    
}

//封装切换登录界面的方法
- (void)changesSignView:(UIView *)view
{
    //添加上面的view
    [self.view addSubview:view];
    
    //设置上面View的约束
    [view makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.leading.trailing.equalTo(self.view);
        make.height.equalTo(@175);
        
    }];
    
    [self.view addSubview:self.channelTable];
    
    [self.channelTable mas_makeConstraints:^(MASConstraintMaker *make)
     {
         
         make.top.mas_equalTo(view.mas_bottom);
         make.left.bottom.mas_equalTo(0);
         make.width.mas_equalTo(SCREEN_LEFT_WIDTH);
     }];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
