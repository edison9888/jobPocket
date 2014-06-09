//
//  EsLanmuViewController.h
//  xhgdzwyq
//  栏目页面
//  Created by 温斯嘉 on 13-11-7.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EsLanmuBtn.h"
#import "EsLanmuCtrl.h"

#define LANMUVIEW_INSET_LEFT 10
#define LANMUVIEW_INSET_RIGHT   60
#define LANMUVIEW_INSET_TOP 10
#define LANMUVIEW_INSET_BOTTOM   LANMUVIEW_INSET_RIGHT
#define LANMUVIEW_BLOCK_GAP 10  //两个栏目块的间隙

@class EsNewsListViewController;

@interface EsLanmuViewController : UIViewController <UIScrollViewDelegate, EsLanmuBtnDelegate, lanmuArrayChangedDelegate, userVerifyDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

//栏目控制类对象，负责从后台获取栏目数据，栏目数据的本地缓存，……
@property(nonatomic, strong) EsLanmuCtrl *lanmuCtrler;
//栏目块控件数组
@property(nonatomic, strong) NSMutableArray *lanmuBtns;
//栏目列表页面
@property (nonatomic, strong) EsNewsListViewController *newsListViewCtrl;


@end
