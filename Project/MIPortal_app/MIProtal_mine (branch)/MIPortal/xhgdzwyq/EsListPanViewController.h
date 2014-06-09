//
//  EsListPanViewController.h
//  xhgdzwyq
//
//  Created by Eshore on 13-11-13.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EsCorporationDelegate.h"

@protocol EsChangeCategoryDelegate;
//@class EsNewsTableViewController;

@interface EsListPanViewController : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) CGRect listPanFrame;
@property (weak, nonatomic) id<EsChangeCategoryDelegate> delegate;

//page的集合；
#warning wensj 有时间要改造一下，建一个pageView类，EsListPanViewController作为它的控制类，类似UITableView和UITableViewController，page集合放到pageView类中
@property (nonatomic, strong) NSMutableArray *categoryPages;

@property (nonatomic, strong) NSMutableArray *newsLists;//二位数组，第一位时栏目，第二维是栏目中列表
@property (nonatomic, strong) NSMutableDictionary *newsListCtrls;//新闻列表controller的Dictionary
@property (nonatomic, weak) id <EsCorporationDelegate> cprtDelegate;

- (void) setScrollviewContent:(NSInteger)pageNum curPage:(NSInteger)pageIndex;

@end

@protocol EsChangeCategoryDelegate <NSObject>

- (void)categoryDidChanged: (NSInteger) categoryIndex;

@end

