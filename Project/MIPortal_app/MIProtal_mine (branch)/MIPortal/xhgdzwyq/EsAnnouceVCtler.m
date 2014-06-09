//
//  EsAnnouceVCtler.m
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsAnnouceVCtler.h"

static NSString* __statementText = @"       MI+客户端是广东亿迅科技有限公司移动互联网产品部内部使用版本。面向全体 移动互联网产品部的伙伴，以VOMI、My Team、Scrum、Voice of the Custom的 几大模块形式，提炼当下移动互联网行业的最新资讯要闻，热点消息，客户对产 品的反馈等，同时打造移动终端的项目管理实时管理直通车。支持支持Android 等智能操作系统的手机客户端。";

@interface EsAnnouceVCtler ()

@end

@implementation EsAnnouceVCtler

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
    [self setBackButton];
    self.title = @"免责声明";
    
    {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 44, CGRectGetWidth(self.view.frame) - 60, CGRectGetHeight(self.view.frame) - 44)];
        lab.font     = [UIFont systemFontOfSize:13];
        lab.textColor = RGB(0x78, 0x78, 0x78, 1);
        lab.textAlignment = UITextAlignmentLeft;
        lab.numberOfLines = 0;
        lab.backgroundColor = [UIColor clearColor];
        lab.lineBreakMode = NSLineBreakByCharWrapping;
        lab.text    = __statementText;
        [lab sizeToFit];
        [self.view addSubview:lab];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
