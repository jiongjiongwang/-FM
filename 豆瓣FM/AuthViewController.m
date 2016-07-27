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


//实现webView的代理方法
//(1)web开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"网页开始加载");
}
//(2)web结束加载
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"网页加载结束");
}
//(3)web加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"网页加载失败");
}
//(4)监听webView 将要加载的request
/*
 返回的值:
 true:继续加载
 false:停止加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    //监听webView将要加载的request
    //let urlString = request.URL?.absoluteString
    
    NSString *urlString = request.URL.absoluteString;
    
    //NSLog(@"urlString = %@",urlString);
    //逐步获取code
    if (urlString.length > 0)
    {
        NSLog(@"urlString = %@",urlString);
        
        //判断有没有回调页网址
        if ([urlString hasPrefix:APPREDIRECT_URI])
        {
            NSLog(@"urlString hasPrefix urlString = %@",urlString);
            
            //获取urlString中“?”后面的所有信息
            NSString *urlCode = request.URL.query;
            
            if (urlCode.length > 0)
            {
                NSRange range = [urlCode rangeOfString:@"code="];
                
                NSUInteger startIndex = range.location;
                
                
                NSString *code = [urlCode substringFromIndex:startIndex+range.length];
                
                NSLog(@"code = %@",code);
            }
        }
    }
    
    
    return YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
