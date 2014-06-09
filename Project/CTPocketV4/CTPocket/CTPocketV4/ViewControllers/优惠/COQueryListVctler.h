//
//  COQueryListVctler.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-1-21.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTBaseViewController.h"

////////////////////////////////////////////////////////////
typedef enum _CQQVCStatus{
    CQQ_Status_ByNetInfo = 1,   // 入网
    CQQ_Status_ByUseInfo,       // 用户
}CQQVCStatus;


@interface COQueryListVctler : UITableViewController
{
    NSMutableArray* orderItemList;
}
@property(nonatomic)BOOL needChange;
@property(nonatomic)CQQVCStatus QStatusType;
@property(nonatomic,strong)NSString*  namestr;
@property(nonatomic,strong)NSString*  codestr;

@end
