//
//  CTPointSortVCtler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-3-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTPointSortVCtler.h"
#import "CTPointsToExchageVCtler.h"
#import "IgUserInfo.h"
#import "IgInfo.h"
#import "SVProgressHUD.h"

@interface CTPointSortVCtler ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *CommodityList;
@property (nonatomic, strong) NSString * Integral;

@end

@implementation CTPointSortVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pointsExchange_0-1000_icon.png",@"icon",
                               @"0-1000积分段",@"info",
                               @"LeXiang3G_RArrow",@"arrow",
                               @"0",@"MinPrice",
                               @"1000",@"MaxPrice",
                               nil];
        NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pointsExchange_1000-1500_icon.png",@"icon",
                               @"1000-1500积分段",@"info",
                               @"LeXiang3G_RArrow",@"arrow",
                               @"1000",@"MinPrice",
                               @"1500",@"MaxPrice",
                               nil];
        NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pointsExchange_1500-2000_icon.png",@"icon",
                               @"1500-2000积分段",@"info",
                               @"LeXiang3G_RArrow",@"arrow",
                               @"1500",@"MinPrice",
                               @"2000",@"MaxPrice",
                               nil];
        NSDictionary *dict4 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pointsExchange_2000-2500_icon.png",@"icon",
                               @"2000-2500积分段",@"info",
                               @"LeXiang3G_RArrow",@"arrow",
                               @"2000",@"MinPrice",
                               @"2500",@"MaxPrice",
                               nil];
        NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pointsExchange_2500-3000_icon.png",@"icon",
                               @"2500-3000积分段",@"info",
                               @"LeXiang3G_RArrow",@"arrow",
                               @"2500",@"MinPrice",
                               @"3000",@"MaxPrice",
                               nil];
        NSDictionary *dict6 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"pointsExchange_3000-3500_icon.png",@"icon",
                               @"3000-3500积分段",@"info",
                               @"LeXiang3G_RArrow",@"arrow",
                               @"3000",@"MinPrice",
                               @"3500",@"MaxPrice",
                               nil];
        
        
        self.CommodityList = [NSMutableArray arrayWithObjects:dict1,dict2,dict3,dict4,dict5,dict6, nil];
    }
    return self;
}

#pragma mark - control

- (UITableView *) tableView
{
    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];  //modified by shallow
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth ;
        _tableView.dataSource = (id<UITableViewDataSource>)self;
        _tableView.delegate = (id<UITableViewDelegate>)self;
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self tableView];
    
    NSDictionary *loginInfoDict = [Global sharedInstance].loginInfoDict;
    NSString *DeviceNo = loginInfoDict[@"UserLoginName"];
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    __weak CTPointSortVCtler *wself = self;
    [[IgUserInfo shareIgUserInfo] igUserInfoWithDeviceNo:DeviceNo finishBlock:^(NSDictionary *resultParams, NSError *error) {
        if (!error)
        {
            NSDictionary *data = resultParams[@"Data"];
            NSString *CustId = [data objectForKey:@"CustId"];
            if (CustId) {
                [[IgInfo shareIgInfo] igInfoWithDeviceNo:DeviceNo CustId:CustId finishBlock:^(NSDictionary *resultParams, NSError *error) {
                    if (error) {
                        [SVProgressHUD dismiss];
                        return;
                    }
                    [SVProgressHUD dismiss];
                    NSDictionary *data = resultParams[@"Data"];
                    NSString *Integral = data[@"Integral"];
                    wself.Integral = Integral ;
                }];
            }
            [SVProgressHUD dismiss];
        }
        else{
            [SVProgressHUD dismiss];
        }
    }];
}

#pragma mark - function


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.CommodityList.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        
        cell.backgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.backgroundView.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1];
        
        UIImage *image = [UIImage imageNamed:[[self.CommodityList objectAtIndex:indexPath.row] objectForKey:@"icon"]];
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, (60-image.size.height)/2, image.size.width, image.size.height)];
        iconImageView.image = image ;
        [cell.contentView addSubview:iconImageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(22+CGRectGetMaxX(iconImageView.frame), 0, 200, 60)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [[self.CommodityList objectAtIndex:indexPath.row] objectForKey:@"info"];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:label];
        
        image = [UIImage imageNamed:[[self.CommodityList objectAtIndex:indexPath.row] objectForKey:@"arrow"]];
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.frame.size.width-17-image.size.width, (60-image.size.height)/2, image.size.width, image.size.height)];
        arrowImageView.image = image ;
        [cell.contentView addSubview:arrowImageView];
        
        UIView *divide = [[UIView alloc] initWithFrame:CGRectMake(10,59, cell.frame.size.width-20, 1)];
        divide.backgroundColor = [UIColor colorWithRed:195/255. green:195/255. blue:195/255. alpha:1];
        [cell.contentView addSubview:divide];

    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - UITabelViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CTPointsToExchageVCtler *vc = [[CTPointsToExchageVCtler alloc] init];
    vc.infoDict = self.CommodityList[indexPath.row];
    vc.Integral = self.Integral;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
