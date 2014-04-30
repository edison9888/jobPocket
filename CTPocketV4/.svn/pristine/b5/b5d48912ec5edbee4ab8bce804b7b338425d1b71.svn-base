//
//  CTCycleTableView.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 13-11-13.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTCycleTableView.h"

@implementation CTCycleTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        //_persent = 0.3;
        //_strLab  = @"话费已用\r30%";
    }
    return self;
}

-(void)setPersentVal:(NSString*)brief persent:(CGFloat)persent
{
    _persent = persent;
    _strLab  = [NSString stringWithString:brief];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // 
    UIColor* color1 = [UIColor colorWithRed: 0.827 green: 0.827 blue: 0.827 alpha: 1];
    [color1 setFill];
    
    // 外环
    UIBezierPath* oval1Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0,0,rect.size.width,rect.size.height)];
    [color1 setFill];
    [oval1Path fill];
        
    // 填充
    CGRect oval2Rect = CGRectMake(0,0,rect.size.width,rect.size.height);
    UIBezierPath* oval2Path = [UIBezierPath bezierPath];
    [oval2Path addArcWithCenter: CGPointMake(CGRectGetMidX(oval2Rect),
                                             CGRectGetMidY(oval2Rect))
                         radius: CGRectGetWidth(oval2Rect) / 2
                     startAngle: 138 * M_PI/180
                       endAngle: (138 + 270 * (_persent)) * M_PI/180
                      clockwise: YES];
    [oval2Path addLineToPoint: CGPointMake(CGRectGetMidX(oval2Rect), CGRectGetMidY(oval2Rect))];
    [oval2Path closePath];
    
    UIColor* color2 = [UIColor colorWithRed:111.0/255 green:197.0/255 blue:55.0/255 alpha:1];
    if (_persent < 0.5) {
        color2 = [UIColor colorWithRed:111.0/255 green:197.0/255 blue:55.0/255 alpha:1];
    }else if(_persent < 0.8){
        color2 = [UIColor colorWithRed:240.0/255
                                 green:136.0/255
                                  blue:64.0/255.9
                                 alpha:1];
    }else if(_persent <= 1){
        color2 = [UIColor redColor];
    }

    [color2    setFill];
    [oval2Path fill];
    
    // 内环
    UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(5,5,rect.size.width-10,rect.size.height-10)];
    [PAGEVIEW_BG_COLOR setFill];
    [oval3Path fill];
    
    // 文字
    CGRect textRect = CGRectMake(15,35,rect.size.width-30,rect.size.height-70);
    [[UIColor blackColor] setFill];
    [_strLab drawInRect: textRect
               withFont: [UIFont fontWithName: @"Helvetica-Bold" size: 14]
          lineBreakMode: UILineBreakModeWordWrap
              alignment: UITextAlignmentCenter];

    
}

@end
