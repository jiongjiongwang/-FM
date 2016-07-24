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


@interface LeftController ()<UITableViewDelegate,UITableViewDataSource>



//上面的View界面(登录界面)
@property (nonatomic,strong)LoginView *loginView;

//上面的View界面(用户界面)
@property (nonatomic,strong)UserView *userView;

//下面的界面(tableView,显示频道信息)
@property (nonatomic,strong)UITableView *channelTable;

//用一个数组记录一下获取到的频道信息
@property (nonatomic,strong)NSArray <channelModel *>*dataArray;


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
        
        _channelTable.dataSource = self;
        _channelTable.delegate = self;
        
        //注册cell
        [_channelTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"channelCell"];
    }
    
    return _channelTable;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //重新设置UI
    [self setUpUI];
    
    //从网络获取相关信息
    [self setUpChannelData];
    
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

-(void)setUpChannelData
{
    [channelModel getChannelData:^(NSArray<channelModel *> *dataArray) {
       
        self.dataArray = dataArray;
        
        /*
        NSLog(@"频道数量%lu",(unsigned long)dataArray.count);
        [dataArray enumerateObjectsUsingBlock:^(channelModel * _Nonnull obj,
        NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSLog(@"频道名:%@",obj.name);
            NSLog(@"频道的id:%@",obj.channel_id);
            
            
        }];
        */
        
    } Error:^{
        
        NSLog(@"网络异常，频道信息获取失败");
        
    }];
}

//重写dataArray的set方法，当从外面获取到数据时，刷新界面
-(void)setDataArray:(NSArray<channelModel *> *)dataArray
{
    _dataArray = dataArray;
    
    [self.channelTable reloadData];
}


//实现tableView的数据源方法
//(1)组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//(2)行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count + 1;
}
//(3)行数据
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"channelCell" forIndexPath:indexPath];
    
    
    
    //设置cell的数据
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"我的红心";
    }
    else
    {
        cell.textLabel.text = self.dataArray[indexPath.row -1].name;
    }
    
    return cell;
}

//(4)点击cell之后的触发事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        
        if (!_isLogin)
        {
            NSLog(@"你还没有登录，请登录后再听");
        }
        else
        {
            NSLog(@"你还没有收藏音乐");
        }
        
        return;
    }
    
    
    //显示中间的panel
    [self.sidePanelController showCenterPanelAnimated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //获取当前cell对应的model
    channelModel *model = self.dataArray[indexPath.row - 1];


    
    //通知主界面刷新数据(将model信息传送过去)
    [[NSNotificationCenter defaultCenter]postNotificationName:@"uploadModel" object:nil userInfo:@{@"model":model}];
}

-(void)dealloc
{
    NSLog(@"left界面销毁");
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
