//
//  CTFlowRemainingInfoView.m
//  CTPocketV4
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTFlowRemainingInfoView.h"
#import "CTCircularProgressView.h"

@interface CTFlowRemainingInfoView()
{
    CTCircularProgressView*     _progressView;
    UILabel*                    _maxFlowLab;
    UILabel*                    _remainingFlowLab;
}

@end

@implementation CTFlowRemainingInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = NO;
        self.backgroundColor = PAGEVIEW_BG_COLOR;
        
        // 灰底
        UIImageView * bgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"syll_bg"]];
        bgview.frame = CGRectMake((CGRectGetWidth(self.frame) - CGRectGetWidth(bgview.frame))/2,
                                  0,
                                  CGRectGetWidth(bgview.frame),
                                  CGRectGetHeight(bgview.frame));
        [self addSubview:bgview];
        
        // 高亮圆环
        CTCircularProgressView* circularView = [[CTCircularProgressView alloc] initWithFrame:CGRectInset(bgview.frame, 8, 8)];
        [self addSubview:circularView];
        _progressView = circularView;
        
        // 指针
        UIImageView* pointerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"syll_pointer"]];
        pointerView.center = bgview.center;
        [self addSubview:pointerView];
        
        int originX = CGRectGetMinX(bgview.frame);
        int originY = CGRectGetMaxY(bgview.frame) - 35;
        
        NSDate* today = [NSDate date];
        NSTimeInterval endDate = 0;
        NSCalendar *gregrioan = [NSCalendar currentCalendar];
        [gregrioan rangeOfUnit:NSMonthCalendarUnit startDate:nil interval:&endDate forDate:today];
        int totalDays = ((int)endDate)/(3600*24);
        int day = totalDays/6;
        
        // 日期刻度
        for (int i = 0; i < 7; i++)
        {
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, 22, 14)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font = [UIFont systemFontOfSize:9];
            lab.textAlignment = UITextAlignmentCenter;
            lab.textColor = [UIColor grayColor];
            lab.text = [NSString stringWithFormat:@"%d日", i*day + 1];
            [self addSubview:lab];
            originX = CGRectGetMaxX(lab.frame);
            
            switch (i)
            {
                case 0:
                {
                    originX -= 6;
                    originY = CGRectGetMaxY(lab.frame) + 4;
                    lab.transform = CGAffineTransformMakeRotation(M_PI*45/180.);
                }break;
                case 1:
                {
                    originY = CGRectGetMaxY(lab.frame) - 2;
                    lab.transform = CGAffineTransformMakeRotation(M_PI*40/180.);
                }break;
                case 2:
                {
                    originY += 3;
                    originX += 4;
                    lab.transform = CGAffineTransformMakeRotation(M_PI*15/180.);
                }break;
                case 3:
                {
                    originY -= 3;
                    originX += 4;
                }break;
                case 4:
                {
                    originX += 2;
                    originY -= 12;
                    lab.transform = CGAffineTransformMakeRotation(-M_PI*15/180.);
                }break;
                case 5:
                {
                    originX -= 4;
                    originY -= CGRectGetHeight(lab.frame) + 8;
                    lab.transform = CGAffineTransformMakeRotation(-M_PI*40/180.);
                }break;
                case 6:
                {
                    lab.text = [NSString stringWithFormat:@"%d日", totalDays];
                    lab.transform = CGAffineTransformMakeRotation(-M_PI*60/180.);
                }break;
                default:
                    break;
            }
        }
        
        {
            NSDateComponents* component = [gregrioan components:NSDayCalendarUnit|NSMonthCalendarUnit fromDate:today];
            pointerView.transform = CGAffineTransformMakeRotation(-M_PI*((CGFloat)([component day] - 1)/(totalDays - 1))*108/180.);
            
            {
                // X月剩余流量
                UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake((int)CGRectGetMinX(pointerView.frame),
                                                                         (int)(pointerView.center.y - 35),
                                                                         (int)(CGRectGetWidth(pointerView.frame)),
                                                                         15)];
                lab.backgroundColor = [UIColor clearColor];
                lab.font = [UIFont systemFontOfSize:12];
                lab.textAlignment = UITextAlignmentCenter;
                lab.textColor = [UIColor darkGrayColor];
                lab.text = [NSString stringWithFormat:@"%d月剩余流量", [component month]];
                [self addSubview:lab];
            }
            
            {
                // XM
                UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake((int)(CGRectGetMinX(pointerView.frame) + 30),
                                                                         (int)(pointerView.center.y - 13),
                                                                         (int)(CGRectGetWidth(pointerView.frame) - 60),
                                                                         32)];
                lab.backgroundColor = [UIColor clearColor];
                lab.font = [UIFont systemFontOfSize:30];
                lab.minimumFontSize = 15;
                lab.adjustsFontSizeToFitWidth = YES;
                lab.textAlignment = UITextAlignmentCenter;
                lab.textColor = [UIColor blackColor];
                lab.text = @"-M";
                [self addSubview:lab];
                _remainingFlowLab = lab;
            }
            
            {
                // 截止X日
                UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake((int)CGRectGetMinX(pointerView.frame),
                                                                         (int)(pointerView.center.y + 25),
                                                                         (int)CGRectGetWidth(pointerView.frame),
                                                                         15)];
                lab.backgroundColor = [UIColor clearColor];
                lab.font = [UIFont systemFontOfSize:12];
                lab.textAlignment = UITextAlignmentCenter;
                lab.textColor = [UIColor darkGrayColor];
                lab.text = [NSString stringWithFormat:@"截止%d日", [component day]];
                [self addSubview:lab];
            }
        }
        
        {
            // 0M
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake((int)(CGRectGetMinX(pointerView.frame) - 22),
                                                                     (int)(CGRectGetMaxY(pointerView.frame) - 40),
                                                                     25,
                                                                     32)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font = [UIFont systemFontOfSize:15];
            lab.minimumFontSize = 15;
            lab.textAlignment = UITextAlignmentCenter;
            lab.textColor = [UIColor darkGrayColor];
            lab.text = @"0M";
            [self addSubview:lab];
        }
        
        {
            // XM
            UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake((int)CGRectGetMaxX(pointerView.frame),
                                                                     (int)(CGRectGetMaxY(pointerView.frame) - 40),
                                                                     (int)(CGRectGetWidth(self.frame) - CGRectGetMaxX(pointerView.frame) - 10),
                                                                     32)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font = [UIFont systemFontOfSize:15];
            lab.minimumFontSize = 15;
            lab.textAlignment = UITextAlignmentLeft;
            lab.textColor = [UIColor darkGrayColor];
            lab.text = @"-M";
            [self addSubview:lab];
            _maxFlowLab = lab;
        }
    }
    return self;
}

- (void)setFlowInfoDict:(NSDictionary *)flowInfoDict
{
    float AccAmount = 0;
    float UsedAmount = 0;
    
    if (flowInfoDict[@"AccAmount"] != [NSNull null] &&
        flowInfoDict[@"AccAmount"] != nil)
    {
        AccAmount = [flowInfoDict[@"AccAmount"] floatValue];
    }
    
    if (flowInfoDict[@"UsedAmount"] != [NSNull null] &&
        flowInfoDict[@"UsedAmount"] != nil)
    {
        UsedAmount = [flowInfoDict[@"UsedAmount"] floatValue];
    }
    
    AccAmount /= 1024.;
    UsedAmount /= 1024.;
    float leftAmount = (AccAmount - UsedAmount);
    float rate = AccAmount ? leftAmount/AccAmount : 0;
    
    _progressView.progress = rate;
    _maxFlowLab.text = [NSString stringWithFormat:@"%.fM", AccAmount];
    _remainingFlowLab.text = [NSString stringWithFormat:@"%.fM", leftAmount];
}

@end
