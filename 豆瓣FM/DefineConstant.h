//
//  DefineConstant.h
//  FastMedical
//
//  Created by 李通 on 16/7/6.
//  Copyright © 2016年 chivalrous. All rights reserved.
//

#ifndef DefineConstant_h
#define DefineConstant_h


// LeftVC 偏移距离
#define kLeftOffsetPadding (SCREEN_WIDTH*0.2)




//判断手机型号
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//weakSelf
#define WEAKSELF __weak typeof(self) weakSelf = self;

//网络不佳
#define kNetWorkFailureStatus @"当前网络不佳，请检查网络"

//主题颜色
#define kThemeColor [UIColor colorWithRed:24/255.0 green:188/255.0 blue:187/255.0 alpha:1]


//**************************************************************
///AppDelegate
#define MLAppDelegate  (AppDelegate *)[UIApplication sharedApplication].delegate

#define MLDefaults (NSUserDefaults *)[NSUserDefaults standardUserDefaults]

///屏幕宽高
#define SCREEN_LEFT_WIDTH ([UIScreen mainScreen].bounds.size.width*0.8)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define kProportion   SCREEN_WIDTH/320 // 5 ok
#define kProportion6  SCREEN_WIDTH/375
#define kProportion6P SCREEN_WIDTH/414

///颜色
#define RANDOMCOLOR [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBHexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0] //RGBHexColor(0xefefef)

#define CLEAR_COLOR [UIColor clearColor]
#define DEEPBLUE_COLOR RGBHexColor(0x44b2f0)
#define BLUE_COLOR RGBHexColor(0x23a7f1)
#define WHITE_COLOR RGBHexColor(0xffffff)
#define LIGHTBLUE_COLOR RGBHexColor(0xa8c7e0)
#define GRAY_COLOR RGBHexColor(0xf6f8fa)
#define ORANGE_COLOR RGBHexColor(0xf39800)
#define RED_COLOR RGBHexColor(0xf0311d)
#define DEEPBLACK_COLOR RGBHexColor(0x252525)
#define LIGHTBLACK_COLOR RGBHexColor(0x333333)
#define LIGHTBLACK_COLOR666 RGBHexColor(0x666666)
#define LIGHTBLACK_COLOR999 RGBHexColor(0x999999)

//字体
#define BOLDFONT(F) [UIFont boldSystemFontOfSize:F]
#define FONT(F)     [UIFont systemFontOfSize:F]

///打印Frame
#define LogFrame(frame) loggerImpt(@"frame[X=%.1f,Y=%.1f,W=%.1f,H=%.1f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
///打印Point
#define LogPoint(point) loggerImpt(@"Point[X=%.1f,Y=%.1f]",point.x,point.y);

///配置步骤二(1-4)
#define XCODE_COLORS_ESCAPE @"\033["
#define XCODE_COLORS_RESET_FG XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET XCODE_COLORS_ESCAPE @";" // Clear any foreground or background color

//配置步骤三
///黑色 正常信息
#define loggerInfo(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__);
///蓝色 重要信息
#define loggerImpt(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__);
///橙色 警告信息
#define loggerWarn(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,127,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__);
///红色 错误信息
#define loggerError(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" @"(%d)"  frmt XCODE_COLORS_RESET),__LINE__, ##__VA_ARGS__);


///系统版本号
#define iOS_SYSTEM   [[[UIDevice currentDevice] systemName] doubleValue]



//微博接入相关
#define APPkey @"3367173614"
#define APPsecret @"69843d1efabf2074f7ad2c53db30896b"

//回调页
#define APPREDIRECT_URI @"http://www.baidu.com"
//登录微博的微博账号和密码
//账号
#define weiboName @"wjsnh@yahoo.cn"
//密码
#define weiboPassWord  @"999999"




#endif /* DefineConstant_h */

