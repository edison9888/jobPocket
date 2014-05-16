//
//  RightTableView_CTQueryVCtler.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-5-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "RightTableView_CTQueryVCtler.h"
#import "LeftTableView_CTQueryVCtler.h"
#import "CTNavigationController.h"
#import "CTQryBalanceVCtler.h"
#import "CTPayHistoryVCtler.h"
#import "CTQrtStreamVCtler.h"
#import "CTQryPackageVctler.h"
#import "CTQryValueAddVCtler.h"
#import "CTChargeHistoryVctler.h"
#import "CTBusiProcVCtler.h"
#import "CTValueAddedVCtler.h"
#import "CTPointQueryVCtler.h"
#import "CTRedeemVCtler.h"
#import "CTPointExchangeRecordVCtler.h"
#import "CTMyOrderListVCtler.h"
#import "COQueryVctler.h"
#import "CTLoginVCtler.h"
#import "CTQryWifiVCtler.h"
#import "CTQryServiceHallVCtler.h"
#import "AppDelegate.h"
@implementation RightTableView_CTQueryVCtler

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(instancetype)initialWithIndex:(int)index delegate:(id<LeftTableViewDelegate>)rightTableViewDelegate
{
    CGRect rect=[rightTableViewDelegate rightFrame];
    
    RightTableView_CTQueryVCtler *_tablesubView = [[RightTableView_CTQueryVCtler alloc] initWithFrame:rect
                                                 style:UITableViewStylePlain];
    
    _tablesubView.backgroundColor = [UIColor clearColor];
    _tablesubView.delegate   = (id<UITableViewDelegate>)_tablesubView;;
    _tablesubView.dataSource = (id<UITableViewDataSource>)_tablesubView;
    _tablesubView.alpha         = 1;
    _tablesubView.separatorStyle = UITableViewCellSelectionStyleNone;   // added by zy, 2014-02-19
    [[NSNotificationCenter defaultCenter] addObserver:_tablesubView
                                             selector:@selector(reloadMyTableView)
                                                 name:@"刷新Tableview"
                                               object:nil];
    
    _tablesubView.leftTableviewDelegate=rightTableViewDelegate;
    _tablesubView.homeIndex=index;
    return _tablesubView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int number=1;
    switch (_homeIndex) {
        case 0:
            number = 6;
            break;
        case 1:
            if ([Global sharedInstance].isShowBusiProc)
            {
                number = [[Global sharedInstance].configArray count] + 1;
            }
            else
            {
                number = 1;
            }
            break;
        case 2:
            number = 3;
            break;
        case 3:
            number = 5;
            break;
        case 4:
            number = 2;
            break;
        default:
            break;
    }
    return number;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellid = @"subcell";
    UITableViewCell* cell   = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellid];
        cell.backgroundColor = [UIColor clearColor];
        
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
        
        UIImageView* icon = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 34, 34)];
        icon.tag          = 99;
        icon.backgroundColor = [UIColor clearColor];
        icon.userInteractionEnabled = NO;
        [cell.contentView addSubview:icon];
        
        UILabel* mtitle = [[UILabel alloc] initWithFrame:CGRectMake(50,4,220,22)];
        mtitle.tag      = 100;
        mtitle.backgroundColor = [UIColor clearColor];
        mtitle.font     = [UIFont systemFontOfSize:14];
        mtitle.textColor= [UIColor blackColor];
        [cell.contentView addSubview:mtitle];
        
        UILabel* stitle = [[UILabel alloc] initWithFrame:CGRectMake(50,26,220,22)];
        stitle.tag      = 101;
        stitle.backgroundColor = [UIColor clearColor];
        stitle.font     = [UIFont systemFontOfSize:12];
        stitle.textColor= [UIColor darkGrayColor];
        [cell.contentView addSubview:stitle];
        
        // added by zy, 2014-02-19
        {
            UIView* divl   = [[UIView alloc] initWithFrame:CGRectMake(5,51,320-88-10,1)];
            divl.backgroundColor = [UIColor colorWithRed:0xc3/255. green:0xc3/255. blue:0xc3/255. alpha:1];
            [cell.contentView addSubview:divl];
        }
        // added by zy, 2014-02-19
    }
    
    UIImageView* iconv = (UIImageView*)[cell.contentView viewWithTag:99];
    UILabel* mtitle  = (UILabel*)[cell.contentView viewWithTag:100];
    UILabel* stitle  = (UILabel*)[cell.contentView viewWithTag:101];
    
    if (_homeIndex == 0)
    {
        NSString* datastr = subListTitle01[[indexPath row]];
        NSArray*  ary     = [datastr componentsSeparatedByString:@"#"];
        iconv.image       = [UIImage imageNamed:(NSString*)[ary objectAtIndex:2]];
        mtitle.text       = (NSString*)[ary objectAtIndex:0];
        stitle.text       = (NSString*)[ary objectAtIndex:1];
    }else if(_homeIndex == 1)
    {
        if ([Global sharedInstance].isShowBusiProc)
        {
            if ((indexPath.row >= 0) && (indexPath.row < [[Global sharedInstance].configArray count]))
            {
                NSArray *configs = [Global sharedInstance].configArray;
                
                [iconv setImageWithURL:[NSURL URLWithString:[[configs objectAtIndex:indexPath.row] objectForKey:@"IconUrl"]]
                      placeholderImage:[UIImage imageNamed:@"qry_subl_07.png"]];
                mtitle.text = [[configs objectAtIndex:indexPath.row] objectForKey:@"Title"];
                stitle.text = [[configs objectAtIndex:indexPath.row] objectForKey:@"Description"];
            }
            else
            {
                iconv.image       = [UIImage imageNamed:@"qry_subl_07.png"];
                mtitle.text       = @"增值业务";
                stitle.text       = @"彩铃/189邮箱/手机报......";
            }
        }
        else
        {
            NSString* datastr = subListTitle02[[indexPath row]];
            NSArray*  ary     = [datastr componentsSeparatedByString:@"#"];
            iconv.image       = [UIImage imageNamed:(NSString*)[ary objectAtIndex:2]];
            mtitle.text       = (NSString*)[ary objectAtIndex:0];
            stitle.text       = (NSString*)[ary objectAtIndex:1];
        }
        
    }else if(_homeIndex == 2)
    {
        
        NSString* datastr = subListTitle03[[indexPath row]];
        NSArray*  ary     = [datastr componentsSeparatedByString:@"#"];
        iconv.image       = [UIImage imageNamed:(NSString*)[ary objectAtIndex:2]];
        mtitle.text       = (NSString*)[ary objectAtIndex:0];
        stitle.text       = (NSString*)[ary objectAtIndex:1];
        
    }
    else if (_homeIndex == 3)
    {
        NSString* datastr = subListTitle05[[indexPath row]];
        NSArray*  ary     = [datastr componentsSeparatedByString:@"#"];
        iconv.image       = [UIImage imageNamed:(NSString*)[ary objectAtIndex:2]];
        mtitle.text       = (NSString*)[ary objectAtIndex:0];
        stitle.text       = (NSString*)[ary objectAtIndex:1];
    }
    else if(_homeIndex == 4)
    {
        
        NSString* datastr = subListTitle04[[indexPath row]];
        NSArray*  ary     = [datastr componentsSeparatedByString:@"#"];
        iconv.image       = [UIImage imageNamed:(NSString*)[ary objectAtIndex:2]];
        mtitle.text       = (NSString*)[ary objectAtIndex:0];
        stitle.text       = (NSString*)[ary objectAtIndex:1];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CTNavigationController *navigation=[_leftTableviewDelegate leftNavigation];
    if (_homeIndex == 0)
    {
        if ([Global sharedInstance].isLogin == NO)
        {
            [self loginFirst];
            return;
        }
        
        switch ([indexPath row])
        {
            case 0:
            {
                CTQryBalanceVCtler* qvct = [[CTQryBalanceVCtler alloc] init];
                [navigation pushViewController:qvct animated:YES];
            }break;
            case 1:
            {
                CTPayHistoryVCtler* qvct = [[CTPayHistoryVCtler alloc] init];
                [navigation pushViewController:qvct animated:YES];
            }break;
            case 2:
            {
                CTQrtStreamVCtler* qvct = [[CTQrtStreamVCtler alloc] init];
                [navigation pushViewController:qvct animated:YES];
            }break;
            case 3:
            {
                CTQryPackageVctler* qvct = [[CTQryPackageVctler alloc] init];
                [navigation pushViewController:qvct animated:YES];
            }break;
            case 4:
            {
                CTQryValueAddVCtler* qvct = [[CTQryValueAddVCtler alloc] init];
                [navigation pushViewController:qvct animated:YES];
            }break;
            case 5:
            {
                CTChargeHistoryVctler* qvct = [[CTChargeHistoryVctler alloc] init];
                [navigation pushViewController:qvct animated:YES];
            }break;
            default:
                break;
        }
    }
    
    if (_homeIndex == 1)
    {
        if ([Global sharedInstance].isLogin == NO)
        {
            [self loginFirst];
            return;
        }
        
        if ([Global sharedInstance].isShowBusiProc)
        {
            if (indexPath.row != [[Global sharedInstance].configArray count])
            {
                CTBusiProcVCtler *vc = [[CTBusiProcVCtler alloc] init];
                NSString *url = [[[[Global sharedInstance].configArray objectAtIndex:indexPath.row] objectForKey:@"LinkUrl"] urlDecodedString];
                //add by liuruxian 2014-03-03
                NSString *temp = [url stringByReplacingOccurrencesOfString:@"$ticket$" withString:[Global sharedInstance].ticket];
                temp = [temp stringByReplacingOccurrencesOfString:@"$phonenumber$" withString:[Global sharedInstance].loginInfoDict[@"UserLoginName"]];
                vc.urlStr = temp;
                [navigation pushViewController:vc animated:YES];
            }
            else
            {
                CTValueAddedVCtler *vc = [[CTValueAddedVCtler alloc] init];
                [navigation pushViewController:vc animated:YES];
            }
        }
        else
        {
            CTValueAddedVCtler *vc = [[CTValueAddedVCtler alloc] init];
            [navigation pushViewController:vc animated:YES];
        }
    }
    
    if (_homeIndex == 2)
    {
        if ([Global sharedInstance].isLogin == NO)
        {
            [self loginFirst];
            return;
        }
        
        switch ([indexPath row]) {
            case 0:
            {
                CTPointQueryVCtler *vc = [[CTPointQueryVCtler alloc] init];
                [navigation pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                // modified by liuruxian, 2014-03-14
                CTRedeemVCtler *vc = [[CTRedeemVCtler alloc] init];
                [navigation pushViewController:vc animated:YES];
                
                //                    CTExchangeSucessVCtler *vc = [[CTExchangeSucessVCtler alloc] init];
                //                    [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                // modified by liuruxian 2014-03-17
                CTPointExchangeRecordVCtler *vc = [[CTPointExchangeRecordVCtler alloc] init];
                [navigation pushViewController:vc animated:YES];
                
            }
                break;
            default:
                break;
        }
    }
    
    if (_homeIndex == 3)
    {
        if ([Global sharedInstance].isLogin == NO   &&
            indexPath.row < 4)                          // modified by zy, 2014-02-24，快速订单查询无须登录
        {
            [self loginFirst];
            return;
        }
        switch ([indexPath row]) {
            case 0:
            {
                CTMyOrderListVCtler *vc = [[CTMyOrderListVCtler alloc] init];
                vc.orderType = @"0";
                [navigation pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                CTMyOrderListVCtler *vc = [[CTMyOrderListVCtler alloc] init];
                vc.orderType = @"3";
                [navigation pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                CTMyOrderListVCtler *vc = [[CTMyOrderListVCtler alloc] init];
                vc.orderType = @"4";
                [navigation pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                CTMyOrderListVCtler *vc = [[CTMyOrderListVCtler alloc] init];
                vc.orderType = @"5";
                [navigation pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                COQueryVctler *vc = [[COQueryVctler alloc] init];
                [navigation pushViewController:vc animated:YES];
            }break;
            default:
                break;
        }
    }
    
    // added by zy, 2013-11-14
    if (_homeIndex == 4)
    {
        // 查找附近
        switch (indexPath.row) {
            case 0:
            {
                CTQryWifiVCtler * vctler = [CTQryWifiVCtler new];
                [navigation pushViewController:vctler animated:YES];
            }break;
            case 1:
            {
                CTQryServiceHallVCtler * vctler = [CTQryServiceHallVCtler new];
                [navigation pushViewController:vctler animated:YES];
            }break;
            default:
                break;
        }
    }
    
    
    [_leftTableviewDelegate didSelectRightRowAtIndexPath:indexPath];
}
-(void)loginFirst
{
    if([Global sharedInstance].isLogin == NO)
    {
        CTLoginVCtler *vc = [[CTLoginVCtler alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [MyAppDelegate.tabBarController presentViewController:nav animated:YES completion:^(void){
        }];
    }
}


- (void)reloadMyTableView
{
    [self reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)reloadWithHomeIndex:(int)index
{
    _homeIndex=index;
    [self reloadData];
}
@end
