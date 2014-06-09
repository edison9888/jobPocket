//
//  MineLoginItemCell.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-5-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "MineLoginItemCell.h"
#import "UIColor+Category.h"
@interface MineLoginItemCell ()
{
    CGRect centerSrcRect;
}
@end
@implementation MineLoginItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.textLabel.textColor=[UIColor whiteColor]; 
        UIView *selectedView=[[UIView alloc] initWithFrame:self.bounds];
        selectedView.backgroundColor=[UIColor colorWithR:21 G:21 B:21 A:1];
        self.selectedBackgroundView=selectedView;
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    centerSrcRect=self.label_center.frame;
    centerSrcRect.size.width=54;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupByRow:(int)row
{
    self.view_top_separator.hidden=YES;
    switch (row) {
        case 0:
        {
            self.view_top_separator.hidden=NO;
            self.label_left.hidden=NO;
            self.label_center.hidden=NO;
            self.label_right.hidden=NO;
            self.imageview_icon.image=[UIImage imageNamed:@"my_score"];
            self.label_left.text=@"我的积分";
            
            
            [self resetPoint];
        }
            break;
        case 1:
        {
            self.imageview_icon.image=[UIImage imageNamed:@"mine_ combo_ remaining"];
            self.label_center.hidden=YES;
            self.label_right.hidden=YES;
            self.label_left.text=@"我的套餐余额";
            [self.label_left sizeToFit];
        }
            break;
        case 2:
        {
            self.imageview_icon.image=[UIImage imageNamed:@"mine_order"];
            self.label_center.hidden=YES;
            self.label_right.hidden=YES;
            self.label_left.text=@"我的订单";
            [self.label_left sizeToFit];
        }
            break; 
            
        default:
            break;
    }
}
#pragma mark 设置积分显示的效果
-(void)resetPoint
{
    self.label_center.adjustsFontSizeToFitWidth=NO;
    self.label_center.frame=centerSrcRect;
    NSString *centerText=self.label_center.text;
    int textLen=centerText.length;
    if (textLen>4) {//大于四位的数字处理
        //1 000 0000 --->8
        if (textLen>=7) {//处理一百万的数字
            NSString *subTxt=centerText=[centerText substringWithRange:NSMakeRange(0, textLen-4)];
            NSString *txt=[NSString stringWithFormat:@"%@万",subTxt];
            self.label_center.text=txt;
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue]-7.0<0)
        {
            self.label_center.numberOfLines=1;
            self.label_center.adjustsFontSizeToFitWidth = YES;
            self.label_center.minimumFontSize = 4;
        }else
        {
                    self.label_center.adjustsFontSizeToFitWidth=YES;
        }
        self.label_right.text=@"积分";
        CGRect rightRect= self.label_right.frame;
        CGRect centerFrame=self.label_center.frame;
        rightRect.origin.x=CGRectGetMaxX(centerFrame);
        self.label_right.frame=rightRect;
    }
    else   if (textLen<=4)//小于四位的数字处理
    {
        CGSize cneterTextSize= [centerText sizeWithFont:self.label_center.font];
        CGFloat centerX=CGRectGetMaxX(self.label_left.frame)+2;
        CGFloat centerY=CGRectGetMaxY(self.label_left.frame)-cneterTextSize.height;
        CGRect centerFrame=CGRectMake(centerX,centerY, cneterTextSize.width+4, cneterTextSize.height);
        self.label_center.textAlignment=NSTextAlignmentLeft;
        self.label_center.frame=centerFrame;
        
        self.label_right.text=@"积分";
        CGRect rightRect= self.label_right.frame;
        rightRect.origin.x=CGRectGetMaxX(centerFrame);
        self.label_right.frame=rightRect;
    }
}
@end
