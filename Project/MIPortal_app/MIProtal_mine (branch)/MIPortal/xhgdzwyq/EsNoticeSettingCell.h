//
//  EsNoticeSettingCell.h
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EsNewsColumn.h"

#define kNoticeSettingCellHeight    44

@interface EsNoticeSettingCell : UITableViewCell
{
    UILabel*    _titleLab;
    UIButton*   _switchBtn;
}

@property (nonatomic, strong) EsNewsColumn* columnInfo;

@end
