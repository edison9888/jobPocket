//
//  RollbackABPerson.m
//  CTPocketV4
//
//  Created by apple on 14-3-28.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "RollbackABPerson.h"

@implementation RollbackABPerson

- (void)dealloc
{
    if (self.recordRef) {
        CFRelease(self.recordRef);
    }
}

@end
