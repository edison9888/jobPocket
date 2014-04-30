//
//  CTMessageCenterVCtler.m
//  CTPocketV4
//
//  Created by apple on 13-11-12.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTMessageCenterVCtler.h"
#import "RechargeTypeView.h"
#import "CTMessageVCtler.h"
#import "CTAnnouncementVCtler.h"
#import "CTHomeVCtler.h"
#import "CTLoginVCtler.h"
#import "AppDelegate.h"

@interface CTMessageCenterVCtler () <rechargeTypeDelegate>

@property (nonatomic, strong) RechargeTypeView *messageBar;
@property (nonatomic, assign) int selectedIndex;
@property (nonatomic, strong) CTMessageVCtler *messageVC;
@property (nonatomic, strong) CTAnnouncementVCtler *announceVC;
@property (nonatomic, strong) UIViewController *curVC;
@property (nonatomic, assign) BOOL isPush ;
@end

@implementation CTMessageCenterVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(autoJumpPage)
                                                     name:@"autoJumpPage"
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"消息中心";
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    NSArray *textAry = [NSArray arrayWithObjects:@"公告",
                        @"消息",nil];
    
    NSArray *imageAry = [NSArray arrayWithObjects:@"msgcenter_anno_icon.png",
                         @"msgcenter_msg_icon.png", nil];
    
    self.messageBar = [[RechargeTypeView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 42)];
    self.messageBar.delegate = self;
    self.messageBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.messageBar];
    [self.messageBar initView:imageAry title:textAry xOriginal:50 msgMark:YES];
    
    CTAnnouncementVCtler *announceVC = [CTAnnouncementVCtler new];
    self.announceVC = announceVC ;
    self.announceVC.view.frame = CGRectMake(0, CGRectGetHeight(self.messageBar.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetHeight(self.messageBar.frame));
    self.announceVC.parentVC = self ;
    self.announceVC.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1];
    [self.view addSubview:self.announceVC.view];
    
    if([Global sharedInstance].isLogin)
    {
        self.messageVC = [[CTMessageVCtler alloc]init];
        self.messageVC.parentVC = self ;
        self.messageVC.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1];
        self.messageVC.view.frame = CGRectMake(0, CGRectGetHeight(self.messageBar.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetHeight(self.messageBar.frame));
    }
    else{
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"viewIndex",@"0" ,@"msgNum",nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:RELOADMSGMSG object:dictionary];
    }

    self.curVC = announceVC;
}

- (void) viewDidAppear:(BOOL)animated
{
  
}

#pragma mark - msg
- (void)autoJumpPage
{
    if(self.isPush)
    {
        self.isPush = NO;
        [self.messageBar selectedChargeType:1];
    }
  
}

#pragma mark - viewSelceted Delegate

- (void) rechargeType:(int)Type
{
    if (self.curVC) {
        [self.curVC.view removeFromSuperview];
    }
    self.selectedIndex = Type;
    switch (Type) {
            
        case 0:
            if (!self.announceVC) {
                self.announceVC.view.frame = CGRectMake(0, CGRectGetHeight(self.messageBar.frame), self.view.frame.size.width, self.view.frame.size.height - 42 );
                
                self.announceVC.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1];
            }
            
            self.curVC = self.announceVC;
            [self.view addSubview:self.curVC.view];
            break;
        case 1:
            if(![Global sharedInstance].isLogin)
            {
                CTLoginVCtler *vc = [[CTLoginVCtler alloc] init];
                vc.isPush = YES ;
                self.isPush = YES;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                [MyAppDelegate.tabBarController presentViewController:nav animated:YES completion:^(void){
                }];
                [self.messageBar selectedChargeType:0];
                return;
            }
            if (!self.messageVC) {
                self.messageVC = [[CTMessageVCtler alloc]init];
                self.isPush = YES ;
                self.messageVC.view.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1];                
                self.messageVC.view.frame = CGRectMake(0, CGRectGetHeight(self.messageBar.frame), self.view.frame.size.width, self.view.frame.size.height - 42 );
                self.messageVC.parentVC = self;
            }
            
            self.curVC = self.messageVC;
            [self.view addSubview:self.curVC.view];
            break;
    }
}



- (void)onLeftBtnAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadMsg" object:nil];
    if (self.isDismissMVC && [self respondsToSelector:@selector(dismissModalViewControllerAnimated:)])
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - tableView delegate

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
