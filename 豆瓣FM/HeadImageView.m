//
//  HeadImageView.m
//  FastDoctor
//
//  Created by 程建良 on 16/7/7.
//  Copyright © 2016年 sc. All rights reserved.
//

#import "HeadImageView.h"

@implementation HeadImageView

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat heghit = self.frame.size.height;
    self.layer.cornerRadius =MIN(heghit/2, width/2);
    self.layer.masksToBounds = YES;
}

@end
