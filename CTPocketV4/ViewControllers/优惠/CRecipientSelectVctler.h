//
//  CRecipientSelectVctler.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-1-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

// 靓号订单选择收件人

#import <UIKit/UIKit.h>
#import "CTBaseViewController.h"

@interface CRecipientSelectVctler : CTBaseViewController
<UITableViewDelegate,UITableViewDataSource>
{
    BOOL         ifShowingEdit;
    BOOL         isHiddenStatus;
    
    NSInteger    mSelIndex;
    UITableView* mTableView;
}

@end
