//
//  CTCycleTableView.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 13-11-13.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTCycleTableView : UIView
{
    CGFloat     _persent;
    NSString*   _strLab;
}

-(void)setPersentVal:(NSString*)brief persent:(CGFloat)persent;

@end
