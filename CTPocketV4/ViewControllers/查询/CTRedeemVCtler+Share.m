//
//  CTRedeemVCtler+Share.m
//  CTPocketV4
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTRedeemVCtler+Share.h"
#import "CustomShare.h"

@implementation CTRedeemVCtler (Share)

- (id)init
{
    self = [super init];
    if (self) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0.0, 0.0, 53.0, 30.0)];
        [btn setTitle:@"分享" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    
    return self;
}

- (void)share
{
//    UIImage *image = [CustomShare getNormalImage:self.view];
    UIImage *image = [CustomShare fullScreenshots];
    [CustomShare shareHandler:image];
    
}

@end
