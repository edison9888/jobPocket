//
//  CTAddrBookLogVCtler.m
//  CTPocketV4
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTAddrBookLogVCtler.h"
#import "CTAddrBookLogCell.h"
#import "AddressBookLogger.h"

@interface CTAddrBookLogVCtler ()
{
    NSArray*    _logList;
}

@end

@implementation CTAddrBookLogVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        AddressBookLogger* logger = [AddressBookLogger new];
        _logList = [logger loadABLog];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setTitle:@"操作记录"];
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    {
        UIView * grayView        = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 1, CGRectGetHeight(self.view.frame))];
        grayView.backgroundColor = [UIColor colorWithRed:225/255. green:225/255. blue:225/255. alpha:1];
        grayView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:grayView];
    }
    
    {
        UITableView* tv = [[UITableView alloc] initWithFrame:self.view.bounds
                                                       style:UITableViewStylePlain];
        tv.backgroundColor   = [UIColor clearColor];
        tv.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        tv.separatorStyle   = UITableViewCellSeparatorStyleNone;
        tv.delegate         = (id<UITableViewDelegate>)self;
        tv.dataSource       = (id<UITableViewDataSource>)self;
        tv.showsVerticalScrollIndicator = NO;
        [self.view addSubview:tv];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _logList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifierStr = @"cell";
    CTAddrBookLogCell* cell = (CTAddrBookLogCell*)[tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (!cell)
    {
        cell = [[CTAddrBookLogCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr];
    }
    cell.logInfo = _logList[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCTAddrBookLogTableCellHight;
}

@end
