//
//  CTLoadMoreCell.h
//  CTPocketV4
//
//  Created by apple on 13-11-12.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTLoadMoreCell : UITableViewCell

@property (strong, nonatomic) UIActivityIndicatorView *spin;
- (void)setCellHeight:(CGFloat)height;

@end
