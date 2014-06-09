//
//  EsNewsCell.h
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EsNewsItem.h"

@interface EsNewsCell : UITableViewCell

@property (nonatomic, strong) EsNewsItem*   newsInfo;

- (CGFloat)getCellHeight;

@end
