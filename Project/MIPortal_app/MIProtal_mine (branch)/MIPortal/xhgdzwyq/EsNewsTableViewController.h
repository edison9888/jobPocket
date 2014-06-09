//
//  EsNewsTableViewController.h
//  xhgdzwyq
//
//  Created by Eshore on 13-11-17.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EsCorporationDelegate.h"

#define NTABEL_HEIGHT_NORMAL    80
#define NTABEL_HEIGHT_IMG       160

@class EsNewsListCtrl;
@class EsNewsDetailViewController;

@interface EsNewsTableViewController : UITableViewController

#warning wensj 要改
@property(nonatomic) NSInteger rowNum;
@property (nonatomic, strong) NSNumber *categoryID;
@property (nonatomic, strong) EsNewsListCtrl *newslistCtrl;

@property (nonatomic, strong) NSMutableArray *newsData;

@property (nonatomic, strong) EsNewsDetailViewController *newsDetailViewCtrl;

@property (nonatomic, weak) id <EsCorporationDelegate> cprtDelegate;

//
- (void)prepareNewsList;

@end

