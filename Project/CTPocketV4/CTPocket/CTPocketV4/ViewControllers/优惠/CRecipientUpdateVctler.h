//
//  CRecipientUpdateVctler.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-1-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

// 靓号:收件人的新增和修改

#import <UIKit/UIKit.h>
#import "CTBaseViewController.h"
#import "CRecipientEditView.h"


@interface CRecipientUpdateVctler : CTBaseViewController
<CRecipientEditViewDelegate,UITextFieldDelegate>
{
}

@property(nonatomic) NSInteger  viewForType;// 1:新增  2：修改
@property(nonatomic,strong) NSDictionary* addessDict;

-(id)initWithViewForType:(NSInteger)type address:(NSDictionary*)dict;

@end
