//
//  CTTextCenterCell.m
//  CTPocketV4
//
//  Created by Y W on 14-3-29.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTTextCenterCell.h"

@implementation CTTextCenterCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.frame = self.bounds;
}

@end
