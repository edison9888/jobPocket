//
//  CTQueryVCtler_LeftTableView.h
//  CTPocketV4
//
//  Created by Gong Xintao on 14-5-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CTNavigationController;
@class RightTableView_CTQueryVCtler;
typedef enum SelectType_CTQueryVCtler
    { LEFT_CTQueryVCtler=1,RIGHT_CTQueryVCtler }SelectType_CTQueryVCtler;

@protocol LeftTableViewDelegate<NSObject>
-(void)tableViewDidRefresh:(UITableView*)tableView;
- (void)didSelectLeftRowAtIndexPath:(NSIndexPath *)indexPath
                       subTalbeView:(RightTableView_CTQueryVCtler*)subTalbeView;
- (void)didSelectRightRowAtIndexPath:(NSIndexPath *)indexPath;
-(CGRect)leftFrame;
-(CGRect)rightFrame;
-(CTNavigationController*)leftNavigation;
@end

@interface LeftTableView_CTQueryVCtler : UITableView
 
@property(assign,nonatomic)int homeIndex;
@property(weak,nonatomic)id<LeftTableViewDelegate> leftTableviewDelegate;
+(instancetype)initialWithDelegate:(id<LeftTableViewDelegate>)leftTableviewDelegate;
-(RightTableView_CTQueryVCtler*)rightTableView;
@end
