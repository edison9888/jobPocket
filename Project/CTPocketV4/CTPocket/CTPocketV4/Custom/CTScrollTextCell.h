//
//  CTScrollTextCell.h
//  CTPocketV4
//
//  Created by Y W on 14-3-19.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AutoScrollLabel.h"

@interface CTScrollTextCell : UITableViewCell

@property (nonatomic, assign, readonly) CGRect imageFrame;
@property (nonatomic, strong, readonly) AutoScrollLabel *autoLabel;

@end
