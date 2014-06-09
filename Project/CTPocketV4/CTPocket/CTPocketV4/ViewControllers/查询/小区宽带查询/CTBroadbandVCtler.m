//
//  CTBroadbandVCtler.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-5.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  小区宽带的主controller

#import "CTBroadbandVCtler.h"

@interface CTBroadbandVCtler ()

@end

@implementation CTBroadbandVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"%s",__func__);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib. 
    [self setBackButton];
    
    NSLog(@"%s",__func__);
    self.requestProcess.tManager=self.topManager;
    self.requestProcess.cManager=self.centerManager;
    
    self.topManager.process=self.requestProcess;
    [self.topManager initial];
    
    self.centerManager.process=self.requestProcess;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
#pragma mark 隐藏键盘
-(IBAction)hideKeyWord:(UITapGestureRecognizer*)gueture
{
    [self.textField resignFirstResponder];
}
-(IBAction)search:(id)sender
{
    
}
@end
