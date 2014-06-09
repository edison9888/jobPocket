//
//  CTBarePhoneCell.h
//  CTPocketV4
//
//  Created by liuruxian on 13-11-25.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBaseViewController.h"

@interface CTBarePhoneCell : UITableViewCell

-(void)setInfo:(NSDictionary *)dictionary;
@property (nonatomic,assign) NSDictionary *phoneInfo;

@end
