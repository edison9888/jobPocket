//
//  CTExchangeSucessVCtler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-3-14.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTExchangeSucessVCtler.h"
#import "CTPointExchangeRecordVCtler.h"
#import "CTPointQueryVCtler.h"
#import "CTShakeNumberVCtler.h"
#import "CTHelperMap.h"
#import "CTRedeemVCtler.h"
#import "AppDelegate.h"
#import "CTPreferentialVCtler.h"

NSString * const QryPointNotificaion ;

@interface CTExchangeSucessVCtler ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) NSMutableArray *dataArray ;
@property (nonatomic, strong) UIView *headerView;

@end

@implementation CTExchangeSucessVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        NSDictionary *dict1 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"ExchageSuceess_goOn_icon.png",@"icon",
                               @"继续兑换",@"title",
                               @"LeXiang3G_RArrow",@"arrow",
                               nil];
        NSDictionary *dict2 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"ExchageSuceess_record_icon.png",@"icon",
                               @"积分兑换记录",@"title",
                               @"LeXiang3G_RArrow",@"arrow",
                               nil];
        NSDictionary *dict3 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"ExchangeSucess_check_icon.png",@"icon",
                               @"积分查询",@"title",
                               @"LeXiang3G_RArrow",@"arrow",
                               nil];
        NSDictionary *dict4 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"ExchangeSucess_prefernce_icon.png",@"icon",
                               @"优惠活动",@"title",
                               @"LeXiang3G_RArrow",@"arrow",
                               nil];
        NSDictionary *dict5 = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"ExchangeSucess_shake_icon.png",@"icon",
                               @"摇个靓号",@"title",
                               @"LeXiang3G_RArrow",@"arrow",
                               
                               nil];
        
        self.dataArray = [NSMutableArray arrayWithObjects:dict1,dict2,dict3,dict4,dict5, nil];
    }
    return self;
}

#pragma mark - control

- (UITableView *) tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth ;
        _tableView.separatorStyle = UITableViewCellAccessoryNone ;
        _tableView.delegate = (id<UITableViewDelegate>)self;
        _tableView.dataSource = (id<UITableViewDataSource>)self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1];
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 150)];
        _headerView.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1];
        
        float yPos = 0;
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(44, 25, _headerView.frame.size.width, 18)];
            label.backgroundColor = [UIColor clearColor];
            label.text = @"尊敬的用户 : ";
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14];
            label.tag = 1;
            [_headerView addSubview:label];
            
            NSString *name = [NSString stringWithFormat:@"您已成功兑换 : %@x%@",self.infoDict[@"CommodityName"],
                              self.infoDict[@"commodityCount"]];
            
            yPos = CGRectGetMaxY(label.frame) + 15;
            UILabel *infolabel = [[UILabel alloc] initWithFrame:CGRectMake(44,yPos, _headerView.frame.size.width-44*2, 18)];
            infolabel.backgroundColor = [UIColor clearColor];
            infolabel.textColor = [UIColor blackColor];
            infolabel.text = name;
            infolabel.tag = 2;
            infolabel.numberOfLines = 0;
            infolabel.font = [UIFont systemFontOfSize:14];
            [_headerView addSubview:infolabel];
            [infolabel sizeToFit];
            
            yPos = CGRectGetMaxY(infolabel.frame);
            UILabel *pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(44, yPos, _headerView.frame.size.width-44*2, 18)];
            pricelabel.backgroundColor = [UIColor clearColor];
            pricelabel.textColor = [UIColor blackColor];
            pricelabel.text =  [NSString stringWithFormat:@"总价 : %@积分",self.infoDict[@"totalPoints"]];
            pricelabel.tag = 3;
            pricelabel.font = [UIFont systemFontOfSize:14];
            [_headerView addSubview:pricelabel];
            
            UIImageView *divide = [[UIImageView alloc] initWithFrame:CGRectMake(32,149, _headerView.frame.size.width-64, 1)];
            divide.backgroundColor = [UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1];
            [_headerView addSubview:divide];
        }
    }
    
    return _headerView ;
}

#pragma mark - fun

- (void)setInfo:(NSDictionary *)dictionary
{
    NSString *name = [NSString stringWithFormat:@"您已成功兑换 : %@x%@",dictionary[@"CommodityName"],
                                                                      dictionary[@"commodityCount"]];
    UILabel *label ;
    label = (UILabel *)[self.headerView viewWithTag:2];
    label.text = name;
    label.numberOfLines = 0;
    [label sizeToFit];
    
    label = (UILabel *)[self.headerView viewWithTag:3];
    label.text = [NSString stringWithFormat:@"总价 : %@积分",dictionary[@"totalPoints"]];
    label.numberOfLines = 0;
    [label sizeToFit];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1];
        UIImage *iconImage = [UIImage imageNamed:self.dataArray[indexPath.row][@"icon"]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50,
                                                                               (50-32)/2,
                                                                               32, 32)];
        imageView.image = iconImage;
        [cell addSubview:imageView];
        
        UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(82+12,0, CGRectGetWidth(cell.frame), 50)];
        titlelabel.backgroundColor = [UIColor clearColor];
        titlelabel.text = self.dataArray[indexPath.row][@"title"];
        titlelabel.textColor = [UIColor blackColor];
        titlelabel.font = [UIFont systemFontOfSize:14];
        [cell addSubview:titlelabel];
        
        iconImage = [UIImage imageNamed:self.dataArray[indexPath.row][@"arrow"]];
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-32-20-iconImage.size.width, (CGRectGetHeight(cell.frame)-iconImage.size.height)/2, iconImage.size.width, iconImage.size.height)];
        arrow.image = iconImage;
        [cell addSubview:arrow];
        
        //分割线
        UIImageView *divide = [[UIImageView alloc] initWithFrame:CGRectMake(32, 49, cell.frame.size.width-64, 1)];
        divide.backgroundColor = [UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1];
        [cell addSubview:divide];
        
        UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(32, 0, 1, 50)];
        left.backgroundColor = [UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1];
        [cell addSubview:left];
        
        UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-32   , 0, 1,50)];
        right.backgroundColor = [UIColor colorWithRed:216/255. green:216/255. blue:216/255. alpha:1];
        [cell addSubview:right];
   
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
#pragma mark - UITabelViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            //继续兑换
            NSArray *vcAry =  self.navigationController.viewControllers;
#ifdef DEBUG
            NSLog(@"------------------%@",[vcAry[1] class]);
#endif
            [self.navigationController popToViewController:vcAry[1] animated:YES];
        }
            break;
            
        case 1:
        {
            //积分兑换记录
            CTPointExchangeRecordVCtler *vc = [[CTPointExchangeRecordVCtler alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            //积分查询
            CTPointQueryVCtler *vc = [[CTPointQueryVCtler alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            //优惠活动
            MyAppDelegate.tabBarController.selectedIndex = 3;//跳转到navbar
            [MyAppDelegate.tabBarController.viewControllers[3] popViewControllerAnimated:YES];
            
        }
            break;
        case 4:
        {
            //摇个靓号
            if (![CTHelperMap shareHelperMap].areaInfo) {
                __weak __typeof(&*self)weakSelf = self;
                if (![CTHelperMap shareHelperMap].isSuccess) {
                    [[CTHelperMap shareHelperMap] getAreaInfo:^(CTCity *city,NSError *error)
                     {
                         CTShakeNumberVCtler *vc = [[CTShakeNumberVCtler alloc] init];
                         vc.selectedCity = [CTHelperMap shareHelperMap].areaInfo ;
                         [weakSelf.navigationController pushViewController:vc animated:YES];
                     }];
                }
                else{
                    CTShakeNumberVCtler *vc = [[CTShakeNumberVCtler alloc] init];
                    vc.selectedCity = [CTHelperMap shareHelperMap].areaInfo ;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
            } else{
                CTShakeNumberVCtler *vc = [[CTShakeNumberVCtler alloc] init];
                vc.selectedCity = [CTHelperMap shareHelperMap].areaInfo ;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
    }
}

- (void)onLeftBtnAction:(id)sender{
    NSArray *array = self.navigationController.viewControllers ;
    for (id vc in array) {
        if ([vc isKindOfClass:[CTPointQueryVCtler class]] || [vc isKindOfClass:[CTRedeemVCtler class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            break ;
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"兑换成功";
    [[NSNotificationCenter defaultCenter] postNotificationName:QryPointNotificaion object:nil];
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    [self tableView];
    [self.tableView reloadData];
    [self setInfo:self.infoDict];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
