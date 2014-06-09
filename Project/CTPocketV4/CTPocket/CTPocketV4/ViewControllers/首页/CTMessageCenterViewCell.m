//
//  CTMessageCenterViewCell.m
//  CTPocketV4
//
//  Created by apple on 13-11-12.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTMessageCenterViewCell.h"

@interface CTMessageCenterViewCell ()
{
    
}
//@property (nonatomic, strong) NSDictionary *infoDict;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UIImageView *readMark;

//@property (nonatomic, assign) int type;

@end

@implementation CTMessageCenterViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1];
        
        UIImageView *mark = [[UIImageView alloc]initWithFrame:CGRectMake(3, 18, 9, 9)];
        mark.backgroundColor = [UIColor colorWithRed:(15*16)/255. green:(6*16+7)/255. blue:(5*16+1)/255. alpha:1];;
        [self addSubview:mark];
        self.readMark = mark;
        
        UILabel *titleLb = [[UILabel alloc]initWithFrame:CGRectMake(15, 16, self.frame.size.width - 30, 18)];
        titleLb.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
        titleLb.backgroundColor = [UIColor clearColor];
        titleLb.text = @"电信手机营业厅4.0版本闪亮登场";
        titleLb.textColor = [UIColor blackColor];
        titleLb.textAlignment = UITextAlignmentLeft ;
        self.titleLb = titleLb ;
        [self addSubview:titleLb];
        
        UILabel *contentLb = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(titleLb.frame)+8,self.frame.size.width-71,35)];
        contentLb.backgroundColor = [UIColor clearColor];
        [contentLb setNumberOfLines:0];
        contentLb.lineBreakMode = UILineBreakModeWordWrap;
        contentLb.font = [UIFont systemFontOfSize:14];
        contentLb.textAlignment = UITextAlignmentLeft ;
        contentLb.textColor = [UIColor blackColor];
        contentLb.text = @"用起来更舒心的手机营业厅来啦，新增5项全新功能，近404项界面设计优化悠悠lalalalalaal";
        self.contentLb = contentLb;
        [self addSubview:contentLb];
        
        UIImage *image = [UIImage imageNamed:@"recharge_arrow_icon.png"];
        UIImageView *arrow = [[UIImageView alloc]initWithFrame: CGRectMake(CGRectGetMaxX(contentLb.frame)+34, 40, image.size.width, image.size.height)];
        arrow.image = image ;
        [self addSubview:arrow];
        
        //分割线
        UIImageView *sepatator1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 92, self.frame.size.width, 1)];
        sepatator1.image = [UIImage imageNamed:@"custom_separator"];
        [self addSubview:sepatator1];
        
        
    }
    return self;
}
/*
 
*/
- (void) setInfo : (NSDictionary *) dictionary dataType : (int) type mark : (NSString *) isRead
{
//    NSString *IconUrl = [dictionary objectForKey:@"IconUrl"];           // 图标 URL
//    NSString *ImageUrl = [dictionary objectForKey:@"ImageUrl"];         // 图标 URL
//    NSString *LinkType = [dictionary objectForKey:@"LinkType"];         // 跳转地址
//    NSString *Link = [dictionary objectForKey:@"Link"];                 // 跳转地址
//    NSString *Title = [dictionary objectForKey:@"Title"];               // 标题
//    NSString *Introduction = [dictionary objectForKey:@"Introduction"]; // 描述
//    NSString *Order = [dictionary objectForKey:@"Order"];               // 显示顺序
//    NSString *Detail = [dictionary objectForKey:@"Detail"];             // 详细介绍
//    NSString *OtherIntro = [dictionary objectForKey:@"OtherIntro"];     // 其他介绍
//    NSString *News = [dictionary objectForKey:@"News"];                 // 最新动态
    if (type == 0) {
        self.infoDict = dictionary ;
        self.titleLb.text = [self.infoDict objectForKey:@"Title"] ;
        self.contentLb.text = [self.infoDict objectForKey:@"Detail"] ;
        
        if ([isRead intValue]==1) {
            self.readMark.hidden = YES;
        }else{
            self.readMark.hidden = NO;
        }
    }else{
        self.infoDict = dictionary ;
        self.titleLb.text = [self.infoDict objectForKey:@"Title"] ;
        self.contentLb.text = [self.infoDict objectForKey:@"Introduction"] ;
        
        if ([isRead intValue]==1) {
            self.readMark.hidden = YES;
        }else{
            self.readMark.hidden = NO;
        }
    }
    
    self.isRead = [isRead intValue];
}

- (void) setCellStatus : (NSString *) flg
{
    if ([flg intValue] == 0) {
        self.isRead = 1;
        self.readMark.hidden = YES ;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    

}

@end
