//
//  HeadImageView.m
//  豆瓣FM
//
//  Created by 王炯 on 16/7/21.
//  Copyright © 2016年 王炯. All rights reserved.
//

#import "HeadImageView.h"

#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
#define kcornerRadius MIN(self.frame.size.height/2, self.frame.size.width/2)

@implementation HeadImageView


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius =kcornerRadius;
    self.layer.masksToBounds = YES;
}





@end
