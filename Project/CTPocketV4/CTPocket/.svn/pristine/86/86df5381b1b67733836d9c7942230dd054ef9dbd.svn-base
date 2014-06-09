//
//  CTAddrBookRollbackVCtler.h
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBaseViewController.h"
#import "AddressBookHelper.h"
#import "ABAddressBookCache.h"

typedef enum CTRollbackInfoViewType_{
    CTRollbackInfoViewTypeTipMsg = 0,
    CTRollbackInfoViewTypeLogMsg = 1,
}CTRollbackInfoViewType;

@interface CTAddrBookRollbackVCtler : CTBaseViewController

@property (nonatomic, strong) AddressBookHelper*    addrbookHelper;
@property (nonatomic, strong) NSString*             tipMessage;
@property (nonatomic, assign) CTRollbackInfoViewType viewType;
@property (nonatomic, assign) CTAddrBookSyncStatusRef  syncStatus;

- (void)resetUI;
- (void)rollback;

@end
