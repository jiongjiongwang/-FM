//
//  BaseController.h
//  豆瓣FM
//
//  Created by 王炯 on 16/7/15.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseController : UIViewController

//中间的navigationController
- (UINavigationController *)centerNavigationController;


/*!
 *  侧滑调转到指定控制器
 */
- (void)jumpToOtherViewController:(UIViewController *)otherVC;



@end
