//
//  CTPackageItem.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 13-11-5.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTPackageItem.h"
#import <QuartzCore/QuartzCore.h>

@interface CTPackageItem()
{
    UIImageView*    _iconView;  // added by zy, 2014-04-04
}

@end

@implementation CTPackageItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // div line
        int originX = 15;   // added by zy, 2014-04-04
        UIImageView* licon = [[UIImageView alloc] initWithFrame:CGRectMake(15,9,8,14)];
        licon.image = [UIImage imageNamed:@"qry_valadd_licon1.png"];    // modified by zy, 2014-04-04
        licon.frame = CGRectMake(originX, 5, 15, 15);    // added by zy, 2014-04-04
        [self addSubview:licon];
        _iconView = licon;
        originX = CGRectGetMaxX(licon.frame) + 5;

        
        UILabel * namelab      = [[UILabel alloc] initWithFrame:CGRectMake(originX/*30*/,0, CGRectGetWidth(frame) - 30,16)];
        namelab.tag            = 1;
        namelab.backgroundColor= [UIColor clearColor];
        namelab.font           = [UIFont systemFontOfSize:11];
        namelab.textColor      = [UIColor darkTextColor];//(106, 106, 106, 1);
        namelab.textAlignment  = UITextAlignmentLeft;
        [self addSubview:namelab];

        UILabel * usedlab      = [[UILabel alloc] initWithFrame:CGRectMake(originX/*30*/,16, CGRectGetWidth(frame) - 30,16)];
        usedlab.tag            = 2;
        usedlab.backgroundColor= [UIColor clearColor];
        usedlab.font           = [UIFont systemFontOfSize:11];
        usedlab.textColor      = [UIColor colorWithRed:106/255.0
                                                    green:106/255.0
                                                     blue:106/255.0
                                                    alpha:1];//(106, 106, 106, 1);
        usedlab.textAlignment  = UITextAlignmentLeft;
        [self addSubview:usedlab];

        
        UIView * processViewbg        = [[UIView alloc] initWithFrame:CGRectMake(15,32,CGRectGetWidth(frame) - 30, 5)];
        processViewbg.tag             = 3;
        processViewbg.clipsToBounds   = YES;
        processViewbg.layer.cornerRadius = 3;
        processViewbg.backgroundColor = [UIColor colorWithRed:214/255.0
                                                      green:214/255.0
                                                       blue:214/255.0
                                                      alpha:1];
        [self addSubview:processViewbg];
        
        UIView * processView        = [[UIView alloc] initWithFrame:CGRectMake(15,32,4,5)];
        processView.tag             = 4;
        processView.clipsToBounds   = YES;
        processView.layer.cornerRadius = 3;
        processView.backgroundColor = [UIColor colorWithRed:39/255.0
                                                      green:169/255.0
                                                       blue:37/255.0
                                                      alpha:1];
        [self addSubview:processView];
    }
    return self;
}

-(void)setData:(NSDictionary*)dict
{
    NSString* name       = [dict objectForKey:@"AccuRscName"];
    NSNumber* total      = [dict objectForKey:@"AccAmount"];
    NSNumber* left       = [dict objectForKey:@"BalanceAmount"];
    NSNumber* unitType   = [dict objectForKey:@"UnitTypeId"];

    
    NSString* unitStr    = @"";
    NSString* totalstr   = @"";
    NSString* leftstr    = @"";
    switch ([unitType intValue]) {
        case 0:
        {
            unitStr = @"分";
            if ([total intValue] > 100) {
                CGFloat yuan_t = [total intValue]/100.0;
                CGFloat yuan_l = [left  intValue]/100.0;
                totalstr = [NSString stringWithFormat:@"%0.1f",yuan_t];
                leftstr  = [NSString stringWithFormat:@"%0.1f",yuan_l];
                unitStr = @"元";
            }
            
            // added by zy, 2014-04-04
            _iconView.image = [UIImage imageNamed:@"qry_valadd_licon1"];
        }break;
        case 1:
        {
            unitStr = @"分钟";
            CGFloat mtotal = [total intValue];
            CGFloat mleft  = [left intValue];
            totalstr= [NSString stringWithFormat:@"%@",total];
            leftstr = [NSString stringWithFormat:@"%@",left];
            if (mtotal > 60) {
                unitStr = @"小时";
                mtotal = [total intValue]/60.0;
                mleft  = [left intValue]/60.0;
                totalstr= [NSString stringWithFormat:@"%0.1f",mtotal];
                leftstr = [NSString stringWithFormat:@"%0.1f",mleft];
            }
            
            // added by zy, 2014-04-04
            _iconView.image = [UIImage imageNamed:@"qry_valadd_licon1"];
        } break;
        case 2:
        {
            unitStr = @"次数";
            totalstr= [NSString stringWithFormat:@"%@",total];
            leftstr = [NSString stringWithFormat:@"%@",left];
            
            // added by zy, 2014-04-04
            _iconView.image = [UIImage imageNamed:@"qry_valadd_licon3"];
        }break;
        case 3:
        {
            unitStr = @"M";
            CGFloat mtotal = [total intValue]/1024.0;
            CGFloat mleft  = [left intValue]/1024.0;
            totalstr = [NSString stringWithFormat:@"%0.1f",mtotal];
            leftstr  = [NSString stringWithFormat:@"%0.1f",mleft];
            if (mtotal > 1024) {
                mtotal = mtotal/1024.0;
                mleft  = mleft/1024.0;
                totalstr = [NSString stringWithFormat:@"%0.1f",mtotal];
                leftstr  = [NSString stringWithFormat:@"%0.1f",mleft];
                unitStr = @"G";
            }
            
            // added by zy, 2014-04-04
            _iconView.image = [UIImage imageNamed:@"qry_valadd_licon2"];
        }break;
        default:
            break;
    }
    
    UILabel * namelab = (UILabel *)[self viewWithTag:1];
    UILabel * usedlab = (UILabel *)[self viewWithTag:2];
    UIView * processbgView = (UIView  *)[self viewWithTag:3];
    UIView * processView = (UIView  *)[self viewWithTag:4];
    
    namelab.text      = name;
    CGFloat per   = ([total intValue] - [left intValue])*1.0/[total intValue];
    
    usedlab.text      = [NSString stringWithFormat:@"已使用%0.1f%@，总量%@%@，余量%@%@",per*100,@"%",totalstr,unitStr,leftstr,unitStr];
    CGFloat width = per * processbgView.frame.size.width;
    processView.frame    = CGRectMake(processView.frame.origin.x,
                                      processView.frame.origin.y,
                                      width,
                                      processView.frame.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
