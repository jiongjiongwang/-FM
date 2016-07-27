//
//  LoginView.h
//  豆瓣FM
//
//  Created by 王炯 on 16/7/24.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

//定义一个block，让VC进入下一个界面
@property (nonatomic,copy)dispatch_block_t enterWebBlock;


@end
