//
//  AlixPayOrder.m
//  AliPay
//
//  Created by WenBi on 11-5-18.
//  Copyright 2011 Alipay. All rights reserved.
//

#import "AlixPayOrder.h"

#pragma mark -
#pragma mark AlixPayOrder
//#define PPP @"partner="2088101568358171"&seller_id="alipay-test09@alipay.com"&out_trade_no="7XF7Y01K0BO1Z4O"&subject="魅力香水"&body="新年特惠 adidas 阿迪达斯走珠 香体止汗走珠 多种香型可选"&total_fee="1.00"&notify_url="http%3A%2F%2Fwwww.xxx.com"&service="mobile.securitypay.pay"&_input_charset="utf8"&payment_type="1"&return_url="www.xxx.com"&it_b_pay="1d"&show_url="www.xxx.com"2014-05-22 14:55:43.280 AlipaySdkDemo[2495:60b] RAsS24WYASeiLuJ95ZaFoazI3JErOUF%2Bh6pRq%2BUqAJw0dLKU01fzy46J1LeJ0uPj%2FheUOoPOrqpS9Wo88kS9UQcXTi4mmL0022J6vC%2Fx%2FBMKSTohuheXsXoMxBoqPVkaODMzOd1MK5tJOqudPHL5cdBWvyhiS3Q%2FkdTMaHSVg%2F0%3D";


@implementation AlixPayOrder

@synthesize appName = _appName;
@synthesize bizType = _bizType;
@synthesize partner = _partner;
@synthesize seller = _seller;
@synthesize tradeNO = _tradeNO;
@synthesize productName = _productName;
@synthesize productDescription = _productDescription;
@synthesize amount = _amount;
@synthesize notifyURL = _notifyURL;

@synthesize serviceName = _serviceName;
@synthesize inputCharset = _inputCharset ;
@synthesize returnUrl = _returnUrl;
@synthesize paymentType = _paymentType ;
@synthesize itBPay = _itBPay;
@synthesize showUrl = _showUrl;
@synthesize extraParams = _extraParams;

- (void)dealloc {
	self.partner = nil;
    self.bizType = nil;
    self.appName = nil;
	self.seller = nil;
	self.tradeNO = nil;
	self.productName = nil;
	self.productDescription = nil;
	self.amount = nil;
	self.notifyURL = nil;
    self.serviceName = nil;
    self.inputCharset = nil;
    self.returnUrl = nil;
    self.paymentType = nil;
    self.itBPay = nil;
    self.showUrl = nil;
#if ! __has_feature(objc_arc)
	[self.extraParams release];
	[super dealloc];
#endif
}

- (NSString *)description {
    

	NSMutableString * discription = [NSMutableString string];
	[discription appendFormat:@"partner=\"%@\"", self.partner ? self.partner : @""];
	[discription appendFormat:@"&seller_id=\"%@\"", self.seller ? self.seller : @""];
	[discription appendFormat:@"&out_trade_no=\"%@\"", self.tradeNO ? self.tradeNO : @""];
	[discription appendFormat:@"&subject=\"%@\"", self.productName ? self.productName : @""];
	[discription appendFormat:@"&body=\"%@\"", self.productDescription ? self.productDescription : @""];
	[discription appendFormat:@"&total_fee=\"%@\"", self.amount ? self.amount : @""];
	[discription appendFormat:@"&notify_url=\"%@\"", self.notifyURL ? self.notifyURL : @""];
    
    [discription appendFormat:@"&service=\"%@\"", self.serviceName ? self.serviceName : @"mobile.securitypay.pay"];
	[discription appendFormat:@"&_input_charset=\"%@\"", self.inputCharset ? self.inputCharset : @"utf-8"];
    [discription appendFormat:@"&payment_type=\"%@\"", self.paymentType ? self.paymentType : @"1"];

    //下面的这些参数，如果没有必要（value为空），则无需添加
//	[discription appendFormat:@"&return_url=\"%@\"", self.returnUrl ? self.returnUrl : @"www.xxx.com"];
//	[discription appendFormat:@"&it_b_pay=\"%@\"", self.itBPay ? self.itBPay : @"1d"];
//	[discription appendFormat:@"&show_url=\"%@\"", self.showUrl ? self.showUrl : @"www.xxx.com"];

    
	for (NSString * key in [self.extraParams allKeys]) {
		[discription appendFormat:@"&%@=\"%@\"", key, [self.extraParams objectForKey:key]];
	}
    
	return discription;
}

@end
