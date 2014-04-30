//
//  CTOrderSuccessVCtler.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-26.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  增值业务办理成功

#import "CTOrderSuccessVCtler.h"

@interface CTOrderSuccessVCtler ()

@end

@implementation CTOrderSuccessVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // 标题
        self.title = @"增值业务办理成功";
        // 左按钮
        [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // 笑脸
    UIImageView *smileIcon = [[UIImageView alloc] initWithFrame:CGRectMake(136, 45, 48, 48)];
    smileIcon.image = [UIImage imageNamed:@"smile_Icon"];
    [self.view addSubview:smileIcon];
    
    // tip
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(48, 45+48+45, 224, 16)];
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.font = [UIFont systemFontOfSize:13.0f];
    tipLabel.textColor = [UIColor blackColor];
    tipLabel.numberOfLines = 0;
    NSString *actionTypeStr = @"";
    if (self.actionType == 0) {
        actionTypeStr = @"订购";
    }
    else
    {
        actionTypeStr = @"退订";
    }
    tipLabel.text = [NSString stringWithFormat:@"尊敬的用户：\n恭喜您，已成功%@%@业务，希望能为你带来舒心的体验。", actionTypeStr, self.prodName];
    [tipLabel sizeToFit];
    [self.view addSubview:tipLabel];
}

#pragma mark - nav

- (void)onLeftBtnAction:(id)sender
{
    if (self.isDismissMVC && [self respondsToSelector:@selector(dismissModalViewControllerAnimated:)])
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
