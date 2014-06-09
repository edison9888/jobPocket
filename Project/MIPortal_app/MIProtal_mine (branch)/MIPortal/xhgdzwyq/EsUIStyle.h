//
//  EsUIStyle.h
//  xhgdzwyq
//
//  Created by apple on 13-11-26.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum UIStyleMode__
{
    UIStyleModeDay = 0,
    UIStyleModeNight
}UIStyleMode;

@interface EsUIStyle : NSObject

@property (nonatomic, assign) int           fontSize;
@property (nonatomic, assign) UIStyleMode   mode;
@property (nonatomic, assign) CGFloat       brightness;
@property (nonatomic, assign) CGFloat       originBrightness;   // 设备原始的亮度

@end
