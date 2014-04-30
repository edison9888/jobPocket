//
//  BdSpecCell.h
//  CTPocketV4
//
//  Created by Y W on 14-3-20.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTSelectButton.h"

@interface BdSpecCell : UITableViewCell
@property(nonatomic,copy)NSString *defaultId;
@property (nonatomic, copy, readwrite) CTSelectButtonSelectBlock selectBlock;

+ (CGFloat)CellHeightWithConfigList:(NSArray *)configList;

- (void)setConfigList:(NSArray *)configList;


@end
