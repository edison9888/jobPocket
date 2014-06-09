//
//  BBCenterItem.h
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBCenterItem : UITableViewCell
@property(weak,nonatomic)IBOutlet UIImageView *imageView;
@property(weak,nonatomic)IBOutlet UILabel *name;
@property(weak,nonatomic)IBOutlet UILabel *region;
@property(weak,nonatomic)IBOutlet UILabel *state;
@end
