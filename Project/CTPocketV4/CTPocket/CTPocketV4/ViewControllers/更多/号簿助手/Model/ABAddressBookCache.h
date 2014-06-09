//
//  ABAddressBookCache.h
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#ifndef CTPocketV4_ABAddressBookCache_h
#define CTPocketV4_ABAddressBookCache_h

#define kABAddressBookCachePath(key,filename)  ([NSString stringWithFormat:@"%@/%@",\
                                                [Utils getDocumentFolderByName:[NSString stringWithFormat:@"ab/%@", (key)]],\
                                                (filename)])

typedef enum CTAddrBookSyncStatus__
{
    CTAddrBookSyncStatusNone = 0,
    CTAddrBookSyncStatusUpload,
    CTAddrBookSyncStatusDownload,
    CTAddrBookSyncStatusRollback,
}CTAddrBookSyncStatus, *CTAddrBookSyncStatusRef;

#define kCTAddrBookSyncStatusKey            @"ABSyncStatus"
#define kCTAddrBookSyncStatusTimestamp      @"ABSyncStatusTimestamp"
#define kCTAddrBookResumeLastSyncOperation  @"CTAddrBookResumeLastSyncOperation"

#endif
