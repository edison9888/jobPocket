//
//  CTFlowRemainingVCtler.m
//  CTPocketV4
//
//  Created by apple on 13-12-5.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTFlowRemainingVCtler.h"
#import "CTFlowRemainingInfoView.h"
#import "CTFlowRemainingCell.h"

@interface CTFlowRemainingVCtler ()
{
    CTFlowRemainingInfoView*    _flowInfoView;
}

@end

@implementation CTFlowRemainingVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"剩余流量可以做什么";
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    {
        CTFlowRemainingInfoView * v = [[CTFlowRemainingInfoView alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.view.frame), 160)];
        v.flowInfoDict = self.flowInfoDict;
        [self.view addSubview:v];
        _flowInfoView = v;
    }
    
    {
        UITableView* tv = [[UITableView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - kCTFlowRemainingTableCellWidth)/2,
                                                                       CGRectGetMaxY(_flowInfoView.frame) + 10,
                                                                       kCTFlowRemainingTableCellWidth,
                                                                       CGRectGetHeight(self.view.frame) - CGRectGetMaxY(_flowInfoView.frame) - 20)
                                                      style:UITableViewStylePlain];
        tv.backgroundColor   = [UIColor clearColor];
        tv.separatorStyle   = UITableViewCellSeparatorStyleNone;
        tv.delegate         = (id<UITableViewDelegate>)self;
        tv.dataSource       = (id<UITableViewDataSource>)self;
        tv.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        tv.showsVerticalScrollIndicator = NO;
        [self.view addSubview:tv];
        
        {
            UIView * grayView        = [[UIView alloc] initWithFrame:tv.bounds];
            grayView.backgroundColor = [UIColor lightGrayColor];
            grayView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            tv.backgroundView        = grayView;
            
            UIView * maskView        = [[UIView alloc] initWithFrame:CGRectInset(grayView.frame, 1, 1)];
            maskView.backgroundColor = PAGEVIEW_BG_COLOR;
            maskView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [grayView addSubview:maskView];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 30)];
    headerview.backgroundColor = [UIColor clearColor];
    
    {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectInset(headerview.bounds, 1, 1)];
        lab.backgroundColor = self.view.backgroundColor;
        lab.font = [UIFont systemFontOfSize:12];
        lab.text = @"本月剩余流量充足，流量用不完怎么办？";
        lab.textAlignment = UITextAlignmentCenter;
        lab.textColor = [UIColor colorWithRed:111/255. green:197/255. blue:55/255. alpha:1];
        lab.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [headerview addSubview:lab];
    }

    {
        UIView * lineView        = [[UIView alloc] initWithFrame:CGRectMake(0, headerview.frame.size.height - 1, headerview.frame.size.width, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [headerview addSubview:lineView];
    }
    return headerview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifierStr = @"flow cell";
    CTFlowRemainingCell * cell = (CTFlowRemainingCell *)[tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (!cell)
    {
        cell = [[CTFlowRemainingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr];
    }
    cell.flowInfoDict = self.flowInfoDict;
    cell.tag = indexPath.row;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCTFlowRemainingTableCellHight;
}

@end
