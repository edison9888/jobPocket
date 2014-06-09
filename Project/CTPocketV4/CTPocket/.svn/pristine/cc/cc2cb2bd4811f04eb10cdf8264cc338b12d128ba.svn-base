//
//  CTQueryVCtler_LeftTableView.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-5-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "LeftTableView_CTQueryVCtler.h"
#import "RightTableView_CTQueryVCtler.h"
static NSString * listItemTitle[] = {
    @"费用查询",
    @"业务办理",
    @"积分查询",
    @"订单查询",
    @"查找附近",
};

@implementation LeftTableView_CTQueryVCtler
+(instancetype)initialWithDelegate:(id<LeftTableViewDelegate>)leftTableviewDelegate
{
    
    CGRect rect=[leftTableviewDelegate leftFrame];
    LeftTableView_CTQueryVCtler *_tableview = [[LeftTableView_CTQueryVCtler alloc] initWithFrame:rect
                                            style:UITableViewStylePlain];
    _tableview.leftTableviewDelegate=leftTableviewDelegate;
    
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.delegate=(id<UITableViewDelegate>)_tableview;
    _tableview.dataSource=(id<UITableViewDataSource>)_tableview;
    _tableview.separatorStyle = UITableViewCellSelectionStyleNone;

    return _tableview;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 52;//height ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString* cellid = @"half";
    UITableViewCell* cell   = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellid];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
        
        UILabel* labStatus = [[UILabel alloc] initWithFrame:CGRectMake(10,4,100,/*34*/52-8)];
        labStatus.tag      = 100;
        labStatus.backgroundColor = [UIColor clearColor];
        labStatus.font     = [UIFont systemFontOfSize:14];
        labStatus.textColor= [UIColor blackColor];
        [cell.contentView addSubview:labStatus];
    }
    
    UILabel* titlelab  = (UILabel*)[cell.contentView viewWithTag:100];
    titlelab.text  = listItemTitle[[indexPath row]];
    return cell; }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    int row=indexPath.row;
    RightTableView_CTQueryVCtler *rightTalbeView=[RightTableView_CTQueryVCtler initialWithIndex:row
                                                                               delegate:_leftTableviewDelegate];
    [_leftTableviewDelegate didSelectLeftRowAtIndexPath:indexPath   subTalbeView:rightTalbeView];

}
-(RightTableView_CTQueryVCtler*)rightTableView
{
    RightTableView_CTQueryVCtler *rightTalbeView=[RightTableView_CTQueryVCtler initialWithIndex:self.homeIndex
                                                                                       delegate:_leftTableviewDelegate];
    return rightTalbeView;
}

@end
