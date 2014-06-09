//
//  MineNonLoginItemCell.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-5-29.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "MineNonLoginItemCell.h"
#import "UIColor+Category.h"
@implementation MineNonLoginItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self=[super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.contentView.backgroundColor=[UIColor clearColor];
        UIView *selectedView=[[UIView alloc] initWithFrame:self.bounds];
        selectedView.backgroundColor=[UIColor colorWithR:21 G:21 B:21 A:1];
        self.selectedBackgroundView=selectedView;
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
