//
//  EsNewsListViewController.h
//  xhgdzwyq
//
//  Created by Eshore on 13-11-10.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EsListPanViewController.h"
#import "EsCorporationDelegate.h"

#define NLISTVIEW_HEADBAR_HEIGHT    60
#define NLISTVIEW_BOTTOMEBAR_HEIGHT 40

@class EsListPanViewController;
@class EsLanmuViewController;
//@protocol EsChangeCategoryDelegate;

@interface EsNewsListViewController : UIViewController <EsChangeCategoryDelegate, EsCorporationDelegate>

@property (nonatomic, strong) EsListPanViewController *listPanViewController;
//栏目数量
@property (nonatomic) NSInteger categoryNum;
//当前栏目名称
@property (nonatomic, strong) NSString *szTitle;
@property (weak, nonatomic) IBOutlet UILabel *categoryTitleLabel;
//栏目编号
@property (nonatomic) NSInteger categoryIndex;
//上级页面
@property (nonatomic, weak) EsLanmuViewController *father;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;

- (IBAction)backBtn:(id)sender;

@end
