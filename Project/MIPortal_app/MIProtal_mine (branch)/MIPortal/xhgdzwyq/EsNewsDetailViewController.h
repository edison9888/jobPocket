//
//  EsNewsDetailViewController.h
//  xhgdzwyq
//
//  Created by Eshore on 13-11-23.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EsCorporationDelegate.h"
#import "EsNewsListNetAgent.h"
#import "EsNewsDetailModel.h"
#import "EsMineListNetAgent.h"

@interface EsNewsDetailViewController : BaseViewCtler
//@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;
@property (weak, nonatomic) id <EsCorporationDelegate> cprtDelegate;

//- (IBAction)btnBack:(id)sender;

@property (nonatomic, strong) EsNewsListNetAgent* netAgent;
@property (nonatomic, assign) NSInteger selectIdx;
//@property (nonatomic, assign) BOOL isHeadline;

@property (nonatomic, assign) BOOL isRemotePushNews;     // 推送消息传送页面
@property (nonatomic, strong) NSDictionary* newsInfo;    // page=xqy_jm&id=1068&catalogAry=1_2_64
@property (nonatomic, strong) EsNewsDetailModel *newsDetail;

@end
