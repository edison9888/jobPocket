//
//  CTMyOrderCell.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-27.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  订单Cell

#import "CTMyOrderCell.h"

@interface CTMyOrderCell ()
{
    UILabel *_orderId;
    UILabel *_orderPrice;
    UILabel *_orderCreatedDate;
    UIImageView *_orderIcon;
    UILabel *_orderName;
    UILabel *_orderStatus;
    UIButton *_myOrderBtn;
    UIButton *_rechargeBtn;
    
    UIButton *_cancelOrderBtn;
}
@property (copy, nonatomic) NSString *myOrderId;
@property (copy, nonatomic)NSDictionary *info;//added by huangfq 2014-5-28
@end

@implementation CTMyOrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        // 订单号
        _orderId = [[UILabel alloc] initWithFrame:CGRectMake(24, 14, 200, 16)];
        _orderId.backgroundColor = [UIColor clearColor];
        _orderId.font = [UIFont systemFontOfSize:13.0f];
        _orderId.textColor = [UIColor blackColor];
        [self.contentView addSubview:_orderId];
        
        // 订单金额
        _orderPrice = [[UILabel alloc] initWithFrame:CGRectMake(24, 14+20, 200, 16)];
        _orderPrice.backgroundColor = [UIColor clearColor];
        _orderPrice.font = [UIFont systemFontOfSize:13.0f];
        _orderPrice.textColor = [UIColor blackColor];
        [self.contentView addSubview:_orderPrice];
        
        // 下单时间
        _orderCreatedDate = [[UILabel alloc] initWithFrame:CGRectMake(24, 34+20, 272, 16)];
        _orderCreatedDate.backgroundColor = [UIColor clearColor];
        _orderCreatedDate.font = [UIFont systemFontOfSize:13.0f];
        _orderCreatedDate.textColor = [UIColor blackColor];
        [self.contentView addSubview:_orderCreatedDate];
        
        // 分割线1
        UIImageView *separator1 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 80, 304, 1)];
        separator1.image = [UIImage imageNamed:@"order_separator1"];
        [self.contentView addSubview:separator1];
        
        // 图片
        _orderIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 88, 60, 60)];
        [self.contentView addSubview:_orderIcon];
        
        // 物品名
        _orderName = [[UILabel alloc] initWithFrame:CGRectMake(87, 88, 200, 60)];
        _orderName.backgroundColor = [UIColor clearColor];
        _orderName.font = [UIFont systemFontOfSize:13.0f];
        _orderName.textColor = [UIColor blackColor];
        _orderName.numberOfLines = 2;
        [self.contentView addSubview:_orderName];
        
        // 分割线2
        UIImageView *separator2 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 156, 304, 1)];
        separator2.image = [UIImage imageNamed:@"order_separator1"];
        [self.contentView addSubview:separator2];
        
        // 订单状态
        _orderStatus = [[UILabel alloc] initWithFrame:CGRectMake(24, 170, 200, 16)];
        _orderStatus.backgroundColor = [UIColor clearColor];
        _orderStatus.font = [UIFont systemFontOfSize:13.0f];
        _orderStatus.textColor = [UIColor blackColor];
        [self.contentView addSubview:_orderStatus];
        
        // 分割线3
        UIImageView *separator3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 198, 320, 8)];
        separator3.image = [UIImage imageNamed:@"order_separator2"];
        [self.contentView addSubview:separator3];
        
        // _myOrderBtn
        _myOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //add by liuruxian 2014-03-04
        _myOrderBtn.frame = CGRectMake(225, 10, 81, 33);
        _myOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_myOrderBtn setBackgroundImage:[UIImage imageNamed:@"myOrderBtn"] forState:UIControlStateNormal];
        [_myOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:_myOrderBtn];
        
        // cancel order
        _cancelOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //add by liuruxian 2014-04-15
        _cancelOrderBtn.frame = CGRectMake(225, 10, 42, 33);
        _cancelOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_cancelOrderBtn setBackgroundImage:[UIImage imageNamed:@"myOrderBtn"] forState:UIControlStateNormal];
        [_cancelOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.contentView addSubview:_cancelOrderBtn];
        
        // _rechargeBtn
        _rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rechargeBtn.frame = CGRectMake(225, 43, 81, 33);
        [_rechargeBtn setBackgroundImage:[UIImage imageNamed:@"myOrderBtn"] forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rechargeBtn setTitle:@"卡密充值" forState:UIControlStateNormal];
        [_rechargeBtn addTarget:self action:@selector(onRechargeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_rechargeBtn];
    }
    return self;
}

- (void)setCellInfo:(NSDictionary *)info
{
    self.info = info;//added by huangfq 2014-5-28
    
    
    self.myOrderId = info[@"OrderId"];
    
    _orderId.text = [NSString stringWithFormat:@"订单号：%@", info[@"OrderId"]];
    _orderPrice.text = [NSString stringWithFormat:@"订单金额：%@", info[@"Price"]];
    _orderCreatedDate.text = [NSString stringWithFormat:@"下单时间：%@", info[@"OrderCreatedDate"]];
    if ([info[@"Items"] isKindOfClass:[NSArray class]])
    {
        [_orderIcon setImageWithURL:[NSURL URLWithString:info[@"Items"][0][@"SalesProIconUrl"]] placeholderImage:[UIImage imageNamed:@"loadingImage1"]];
    }
    else if ([info[@"Items"] isKindOfClass:[NSDictionary class]])
    {
        [_orderIcon setImageWithURL:[NSURL URLWithString:info[@"Items"][@"SalesProIconUrl"]]
                                        placeholderImage:[UIImage imageNamed:@"loadingImage1"]];
    }
    
    if ([info[@"Items"] isKindOfClass:[NSArray class]])
    {
        _orderName.text = info[@"Items"][0][@"SalesProName"];
    }
    else if ([info[@"Items"] isKindOfClass:[NSDictionary class]])
    {
        _orderName.text = info[@"Items"][@"SalesProName"];
    }
    _orderStatus.text = [NSString stringWithFormat:@"订单状态：%@", info[@"OrderStatusDescription"]];
    
    // added by zy, 2014-02-21
    [_myOrderBtn removeTarget:self action:@selector(onPayAction) forControlEvents:UIControlEventTouchUpInside];
    [_myOrderBtn removeTarget:self action:@selector(onExpressStatusAction) forControlEvents:UIControlEventTouchUpInside];
    // added by zy, 2014-02-21
    
    if (([info[@"OrderStatusCode"] intValue] == 10100) ||
        ([info[@"OrderStatusCode"] intValue] == 10702) ||
        ([info[@"OrderStatusCode"] intValue] == 10703) ||
        ([info[@"OrderStatusCode"] intValue] == 11106) ||
        ([info[@"OrderStatusCode"] intValue] == 11109))
    {
        // 状态为 待支付 订单，需要支付
        [_myOrderBtn setTitle:@"现在支付" forState:UIControlStateNormal];
        [_myOrderBtn addTarget:self action:@selector(onPayAction) forControlEvents:UIControlEventTouchUpInside];
        _myOrderBtn.hidden = NO;
        
//        [_cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
//        [_cancelOrderBtn addTarget:self action:@selector(onCancelAction) forControlEvents:UIControlEventTouchUpInside];
//        _cancelOrderBtn.hidden = NO;
        
    }
    else if (([info[@"OrderStatusCode"] intValue] == 10101) ||
             ([info[@"OrderStatusCode"] intValue] == 10102) ||
             ([info[@"OrderStatusCode"] intValue] == 10105) ||
             ([info[@"OrderStatusCode"] intValue] == 10111) ||
             ([info[@"OrderStatusCode"] intValue] == 10120))
    {
        // 状态为 待收货 订单，需要看物流
        _myOrderBtn.frame = CGRectMake(225, 10, 81, 33);
        [_myOrderBtn setTitle:@"物流状态" forState:UIControlStateNormal];
        [_myOrderBtn addTarget:self action:@selector(onExpressStatusAction) forControlEvents:UIControlEventTouchUpInside];
        _myOrderBtn.hidden = NO;
    }
    else
    {
        _myOrderBtn.hidden = YES;
        _cancelOrderBtn.hidden = YES ;
    }
    
    // 卡密充值按钮是否显示
    NSString *SalesProdType = @"0";
    if ([info[@"Items"] isKindOfClass:[NSArray class]])
    {
        SalesProdType = info[@"Items"][1][@"SalesProdType"];
    }
    else if ([info[@"Items"] isKindOfClass:[NSDictionary class]])
    {
        SalesProdType = info[@"Items"][@"SalesProdType"];
    }
    if ((([info[@"OrderStatusCode"] intValue] == 11108) || ([info[@"OrderStatusCode"] intValue] == 11109)) &&
        ([SalesProdType isEqualToString:@"4"] || [SalesProdType isEqualToString:@"42"]))
    {
        _rechargeBtn.hidden = NO;
        if ([SalesProdType isEqualToString:@"4"])
        {
            _rechargeBtn.tag = 4;
        }
        else if ([SalesProdType isEqualToString:@"42"])
        {
            _rechargeBtn.tag = 42;
        }
    }
    else
    {
        _rechargeBtn.hidden = YES;
        _rechargeBtn.tag = 0;
    }
}

- (void)onPayAction
{
#if 0
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onPayAction" object:self.myOrderId];
#else 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onPayAction" object:nil userInfo:self.info];
#endif
}

- (void)onExpressStatusAction
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onExpressStatusAction" object:self.myOrderId];
}

- (void)onRechargeAction:(UIButton *)btn
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"卡密充值"
                                                        object:@{@"orderId": self.myOrderId, @"tag": [NSString stringWithFormat:@"%d", btn.tag]}];
}

@end
