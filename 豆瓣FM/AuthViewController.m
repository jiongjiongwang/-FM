//
//  AuthViewController.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/27.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "AuthViewController.h"

@interface AuthViewController ()<UIWebViewDelegate>

//定义一个webView
@property (nonatomic,weak)UIWebView *webView;


@end

@implementation AuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //布局界面
    [self setUpUI];
    
}


//主界面为webView
-(void)loadView
{
    self.view = [[UIWebView alloc] init];
    
}



//布局界面
-(void)setUpUI
{
    //主界面为白色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加取消按钮和自动登录按钮
    //取消
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    
    //自动登录
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"自动登录" style:UIBarButtonItemStylePlain target:self action:@selector(autoLoginClick)];
    
    self.title = @"微博登录";
    
    
    //声明一个webView
    UIWebView *webView = (UIWebView *)self.view;
    
    self.webView = webView;
    
    
    webView.delegate = self;
    
    //(1)根据appkey和appSecret拼接相关的请求信息
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",APPkey,APPREDIRECT_URI];
    
    //(2)string-->urlString
    NSURL *url = [NSURL URLWithString:urlString];
    
    //(3)url--->request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
}


//取消按钮
-(void)cancelClick
{
    //界面消失
    [self dismissViewControllerAnimated:YES completion:nil];
}


//自动登录
-(void)autoLoginClick
{
    
    //自动填充，自动填入你的微博用户名和密码
    NSString *jsString = [NSString stringWithFormat:@"document.getElementById('userId').value='%@',document.getElementById('passwd').value='%@'",weiboName,weiboPassWord];
    
    //js注入
    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
