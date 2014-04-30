//
//  CTFlowView.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-10.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  首页流量圆环

#import "CTFlowView.h"

@implementation CTFlowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        userName = @"--";
        usedFlow = 0.0f;
        allFlow = 0.0f;
    }
    return self;
}

- (void)setUserName:(NSString *)name usedFlow:(CGFloat)flow1 allFlow:(CGFloat)flow2
{
    userName = name;
    usedFlow = flow1;
    allFlow = flow2;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    //// Color Declarations
    UIColor* color1 = [UIColor colorWithRed: 0.827 green: 0.827 blue: 0.827 alpha: 1];
    
    //// Abstracted Attributes
    NSString* text1Content = [NSString stringWithFormat:@"%@，你好！", userName];
    NSString* text3Content = [NSString stringWithFormat:@"%.0fM", allFlow];
    NSString* text5Content = [NSString stringWithFormat:@"%.0fM", usedFlow];
    NSString* text7Content = [NSString stringWithFormat:@"%.0fM", allFlow-usedFlow];
    
    
    //// Oval 1 Drawing
    UIBezierPath* oval1Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(112, 21, 96, 96)];
    [color1 setFill];
    [oval1Path fill];
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(119.5, 103.5)];
    [bezierPath addLineToPoint: CGPointMake(159.5, 68.5)];
    [bezierPath addLineToPoint: CGPointMake(195.5, 108.5)];
    [color1 setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    
    //// Oval 2 Drawing
    CGRect oval2Rect = CGRectMake(112, 21, 96, 96);
    UIBezierPath* oval2Path = [UIBezierPath bezierPath];
    [oval2Path addArcWithCenter: CGPointMake(CGRectGetMidX(oval2Rect), CGRectGetMidY(oval2Rect)) radius: CGRectGetWidth(oval2Rect) / 2 startAngle: 138 * M_PI/180 endAngle: (138 + 270 * (usedFlow / allFlow)) * M_PI/180 clockwise: YES];
    [oval2Path addLineToPoint: CGPointMake(CGRectGetMidX(oval2Rect), CGRectGetMidY(oval2Rect))];
    [oval2Path closePath];
    
    // 使用量<50%显示绿色，50%<=使用量<80%显示橘黄色，80%<=使用率显示红色
    if (usedFlow/allFlow < 0.5f)
    {
        [[UIColor colorWithRed:0.44 green:0.77 blue:0.22 alpha:1.00] setFill];
    }
    else if (usedFlow/allFlow >= 0.8f)
    {
        [[UIColor colorWithRed:0.94 green:0.40 blue:0.32 alpha:1.00] setFill];;
    }
    else
    {
        [[UIColor colorWithRed:0.96 green:0.69 blue:0.32 alpha:1.00] setFill];;
    }
    
    [oval2Path fill];
    
    
    //// Oval 3 Drawing
    UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(116, 25, 88, 88)];
    [[UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f] setFill];
    [oval3Path fill];
    
    
    //// Text 1 Drawing
    CGRect text1Rect = CGRectMake(0, 4, 320, 13);
    [[UIColor blackColor] setFill];
    [text1Content drawInRect: text1Rect withFont: [UIFont fontWithName: @"Helvetica" size: 12.5] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
    
    
    //// Text 2 Drawing
    CGRect text2Rect = CGRectMake(0, 91, 109, 16);
    [[UIColor blackColor] setFill];
    [@"0 M" drawInRect: text2Rect withFont: [UIFont fontWithName: @"Helvetica" size: 13] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentRight];
    
    
    //// Text 3 Drawing
    CGRect text3Rect = CGRectMake(211, 91, 109, 16);
    [[UIColor blackColor] setFill];
    [text3Content drawInRect: text3Rect withFont: [UIFont fontWithName: @"Helvetica" size: 13] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentLeft];
    
    
    //// Text 4 Drawing
    CGRect text4Rect = CGRectMake(130, 38, 60, 13);
    [[UIColor blackColor] setFill];
    [@"已用流量" drawInRect: text4Rect withFont: [UIFont fontWithName: @"Helvetica" size: 13] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
    
    
    //// Text 5 Drawing
    CGRect text5Rect = CGRectMake(120, 51, 80, 16);
    [[UIColor blackColor] setFill];
    [text5Content drawInRect: text5Rect withFont: [UIFont fontWithName: @"Helvetica-Bold" size: 13] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
    
    
    //// Text 6 Drawing
    CGRect text6Rect = CGRectMake(120, 72, 80, 13);
    [[UIColor blackColor] setFill];
    [@"剩余流量" drawInRect: text6Rect withFont: [UIFont fontWithName: @"Helvetica" size: 13] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
    
    
    //// Text 7 Drawing
    CGRect text7Rect = CGRectMake(130, 85, 60, 16);
    [[UIColor blackColor] setFill];
    [text7Content drawInRect: text7Rect withFont: [UIFont fontWithName: @"Helvetica-Bold" size: 13] lineBreakMode: UILineBreakModeWordWrap alignment: UITextAlignmentCenter];
}

@end
