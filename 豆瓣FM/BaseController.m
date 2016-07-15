//
//  BaseController.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/15.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //(1)设置VC上的View的一些基本属性
    [self setUpView];
    
    //(2)设置返回按钮
    [self setupLeftButtonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
/**
 *设置VC上的View的一些基本属性
 */
-(void)setUpView
{
    //背景颜色
    self.view.backgroundColor = [UIColor whiteColor];

    //设置navigationBar的颜色
    self.navigationController.navigationBar.barTintColor = kThemeColor;


}

/**
 *设置返回按钮
 */
- (void)setupLeftButtonItem
{
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    [leftBtn setImage:[UIImage imageNamed:@"JianTou"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(goingBack) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
}

#pragma mark - 点击返回到指定页面
- (void)goingBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

//  ***********************【 侧滑 】**********************
/** 中间的nav */
- (UINavigationController *)centerNavigationController
{
    
    return (UINavigationController *)self.sidePanelController.centerPanel;;
}

//跳转到指定的VC
- (void)jumpToOtherViewController:(UIViewController *)otherVC
{
    
    //显示中间的panel
    [self.sidePanelController showCenterPanelAnimated:YES];
    
    //push到指定的VC
    [[self centerNavigationController] pushViewController:otherVC animated:NO];
}

@end
