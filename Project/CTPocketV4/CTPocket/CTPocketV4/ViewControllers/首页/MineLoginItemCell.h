//
//  MineLoginItemCell.h
//  CTPocketV4
//
//  Created by Gong Xintao on 14-5-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineLoginItemCell : UITableViewCell
@property(weak,nonatomic)IBOutlet UIView *view_top_separator;
@property(weak,nonatomic)IBOutlet UIView *view_bottom_Separator;
@property(weak,nonatomic)IBOutlet UIImageView *imageview_icon;
@property(weak,nonatomic)IBOutlet UILabel *label_left;
@property(weak,nonatomic)IBOutlet UILabel *label_center;
@property(weak,nonatomic)IBOutlet UILabel *label_right;
-(void)setupByRow:(int)row;
@end
