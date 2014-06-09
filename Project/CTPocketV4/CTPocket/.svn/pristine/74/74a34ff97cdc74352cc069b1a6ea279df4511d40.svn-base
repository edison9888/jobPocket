//
//  RechargeTypeView.m
//  CTPocketV4
//
//  Created by apple on 13-10-31.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "RechargeTypeView.h"
#import <QuartzCore/QuartzCore.h>

#define kBgImageViewTag 1100
#define kRechargeBtn    1000
#define kMarkTag        1200

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface RechargeTypeView()

@property (assign, nonatomic) int barCount;

@end

@implementation RechargeTypeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.curChargeType = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reloadMsgNum:) name:RELOADMSGMSG object:nil];
    }
    return self;
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void) initView : (NSArray *) imageArray title : (NSArray *) titleArray xOriginal : (float) xOriginal msgMark : (BOOL) mark
{
    UIImage *image ;
    self.msgAry = [NSArray new];
    
    float xPos = 0;
    self.barCount = titleArray.count ;
    for (int i=0; i<titleArray.count; i++) {
        
        if (i==0) {
            image = [UIImage imageNamed:@"recharge_selected_bg.png"];
        }
        else{
            image = [UIImage imageNamed:@"recharge_unselected_bg.png"];
        }
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:
                                  CGRectMake(xPos,
                                             0,
                                             self.frame.size.width/titleArray.count,
                                             self.frame.size.height)];;
        
        imageView.backgroundColor = [UIColor clearColor];
        imageView.autoresizingMask = UIViewContentModeScaleAspectFit ;
        imageView.image = image;
        imageView.tag = kBgImageViewTag + i;
        
        if (i == 0) {
            self.curSelectedImageView  = imageView ;
        }
        
        
        [self addSubview:imageView];
        
        {
            UIImage *icon = [UIImage imageNamed:[imageArray objectAtIndex:i]];
            UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:
                                          CGRectMake(xOriginal,
                                                     (imageView.frame.size.height-15)/2,20,
                                                     15)];
            iconImageView.backgroundColor = [UIColor clearColor];
            iconImageView.autoresizingMask = UIViewContentModeScaleAspectFit ;
            iconImageView.image = icon ;
            [imageView addSubview:iconImageView];
            
            UILabel *label = [[UILabel alloc]initWithFrame:
                              CGRectMake(CGRectGetMaxX(iconImageView.frame)+8,
                                         0,
                                         60,
                                         imageView.frame.size.height)];
            
            label.text = [titleArray objectAtIndex:i];
            label.backgroundColor = [UIColor clearColor];
            label.textAlignment = UITextAlignmentLeft ;
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor blackColor];
            [imageView addSubview:label];
            
            if (mark) {
                UIImageView *markImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(label.frame)+40, (imageView.frame.size.height-14)/2, 14, 14)];
                markImageView.tag = kMarkTag ;
                markImageView.backgroundColor = [UIColor colorWithRed:(15*16)/255. green:(6*16+7)/255. blue:(5*16+1)/255. alpha:1];
                [imageView addSubview:markImageView];
                markImageView.hidden = YES ;
                markImageView.layer.cornerRadius = 7;
                
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, markImageView.frame.size.width, markImageView.frame.size.height)];
                label1.text = @"10";
                label1.tag = 0;
//                label1.hidden = YES ;
                label.backgroundColor = [UIColor clearColor];
                label1.textColor = [UIColor whiteColor];
                label1.textAlignment = UITextAlignmentCenter;
                label1.font = [UIFont systemFontOfSize:10];
                [markImageView addSubview:label1];
            }
         
        }
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(rechargeTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = kRechargeBtn + i ;
        btn.frame = imageView.frame ;
        [self addSubview:btn];
        
        xPos = CGRectGetMaxX(imageView.frame);
    }
}

#pragma mark - rechargeType

- (void) rechargeTypeAction : (id) sender
{
    UIButton *btn = (UIButton *)sender ;
    int index = btn.tag - kRechargeBtn ;
    
    if (self.curChargeType == index) {
        return;
    }
    
    self.curChargeType = index ;
    for (int i =0; i<3; i++) {
        if (self.curChargeType == i) {
            if (i==0) {
                UIImageView *imageView = (UIImageView *)[self viewWithTag:kBgImageViewTag+i];
                imageView.image = [UIImage imageNamed:@"recharge_selected_bg.png"];
                self.curSelectedImageView = imageView ;
            }

            if (self.curChargeType>0 && self.curChargeType<2) {
                UIImageView *imageView = (UIImageView *)[self viewWithTag:kBgImageViewTag+i];
                imageView.image = [UIImage imageNamed:@"recharge_middle_icon.png"];
                self.curSelectedImageView = imageView ;
            }
            if (self.curChargeType == 2) {
                UIImageView *imageView = (UIImageView *)[self viewWithTag:kBgImageViewTag+i];
                imageView.image = [UIImage imageNamed:@"recharge_selected_right"];
                self.curSelectedImageView = imageView ;
            }
           
        }else{
            UIImageView *imageView = (UIImageView *)[self viewWithTag:kBgImageViewTag+i];
            imageView.image = [UIImage imageNamed:@"recharge_unselected_bg.png"];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rechargeType:)]) {
        [self.delegate rechargeType:self.curChargeType];
    }
}

//设置选中的按钮
- (void) selectedChargeType : (int) type
{
    self.curChargeType = type ;
    
    for (int i =0; i<self.barCount; i++) {
        if (self.curChargeType == i) {
            UIImageView *imageView = (UIImageView *)[self viewWithTag:kBgImageViewTag+i];
            imageView.image = [UIImage imageNamed:@"recharge_selected_bg.png"];
            self.curSelectedImageView = imageView ;
        }else{
            UIImageView *imageView = (UIImageView *)[self viewWithTag:kBgImageViewTag+i];
            imageView.image = [UIImage imageNamed:@"recharge_unselected_bg.png"];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rechargeType:)]) {
        [self.delegate rechargeType:self.curChargeType];
    }
}

//设置消息的条数
- (void) deleteMsgNum
{
    int num = (int)self.msgAry[self.curChargeType];
    num -- ;
    
    UILabel *lab =(UILabel *)[(UIImageView *)[self.curSelectedImageView viewWithTag:kMarkTag]viewWithTag:0];
    UIImageView *imageView = (UIImageView *)[self.curSelectedImageView viewWithTag:kMarkTag] ;
    
    if (num == 0) {
        lab.text = [NSString stringWithFormat:@"%d",num];
        imageView.hidden = NO;
    }else{
        lab.text = [NSString stringWithFormat:@"%d",num];
        imageView.hidden = YES;
    }
}

//通知时间设置参数
- (void) setMsg : (NSDictionary *)dictionary
{
    int viewIndex = [[dictionary objectForKey:@"viewIndex"]intValue];
    int msgNum = [[dictionary objectForKey:@"msgNum"]intValue];
    
    UIImageView *curImageView = (UIImageView *)[self viewWithTag:kBgImageViewTag+viewIndex];
    UIImageView *mark = (UIImageView *)[curImageView viewWithTag:kMarkTag];
    mark.hidden = NO ;
    UILabel *lab = (UILabel *)[mark viewWithTag:0];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = [NSString stringWithFormat:@"%d",msgNum];
    
    if (msgNum == 0) {
        mark.hidden= YES;
    }
}

- (void) reloadMsgNum  : (NSNotification *) obj
{
    NSDictionary *dictionary = [obj object];
    [self setMsg:dictionary];
}

@end
