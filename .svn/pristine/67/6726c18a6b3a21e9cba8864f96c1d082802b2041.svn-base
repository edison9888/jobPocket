//
//  CTPCheckUpdateVCtler.m
//  CTPocketv3
//
//  Created by lyh on 13-4-17.
//
//

#import "CTPCheckUpdateVCtler.h"
#import "AppDelegate.h"
#import "ToastAlertView.h"

@interface CTPCheckUpdateVCtler ()
{
    UILabel *newVLabel;
    UIButton *updateBtn;
}

@end

@implementation CTPCheckUpdateVCtler

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
    
    self.title = @"版本更新";
    
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    // 当前版本
    {
        UILabel *oldVLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, 16)];
        oldVLabel.backgroundColor = [UIColor clearColor];
        oldVLabel.font = [UIFont systemFontOfSize:13.0f];
        oldVLabel.textColor = [UIColor blackColor];
        oldVLabel.textAlignment = UITextAlignmentCenter;
        oldVLabel.text = [NSString stringWithFormat:@"当前版本：%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        [self.view addSubview:oldVLabel];
    }
    
    // 新版本
    {
        newVLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 86, self.view.bounds.size.width-40, 16)];
        newVLabel.backgroundColor = [UIColor clearColor];
        newVLabel.font = [UIFont systemFontOfSize:13.0f];
        newVLabel.textColor = [UIColor blackColor];
        newVLabel.textAlignment = UITextAlignmentLeft;/*UITextAlignmentCenter;*/
        [self.view addSubview:newVLabel];
    }
    
    // 更新按钮
    {
        updateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        updateBtn.frame = CGRectMake(32, 86+16+30, 256, 42);
        [updateBtn setBackgroundImage:[UIImage imageNamed:@"updateBtn"] forState:UIControlStateNormal];
        [updateBtn setBackgroundImage:[UIImage imageNamed:@"updateBtn_hl"] forState:UIControlStateHighlighted];
        [updateBtn setBackgroundImage:[UIImage imageNamed:@"updateBtn_disable"] forState:UIControlStateDisabled];
        [updateBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [updateBtn setTitle:@"马上升级" forState:UIControlStateNormal];
        [updateBtn addTarget:self action:@selector(onUpdateAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:updateBtn];
        updateBtn.enabled = NO;
    }
    
    [MyAppDelegate.appStoreEngine getJSONWithId:@"513836029"
                                    onSucceeded:^(NSDictionary *dict) {
                                        
                                        NSString *oldV = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
                                        NSString *newV = [[[dict objectForKey:@"results"] objectAtIndex:0] objectForKey:@"version"];
                                        DDLogInfo(@"当前版本:%@\nAppStore版本:%@", oldV, newV);
                                        if ([oldV compare:newV options:NSNumericSearch] == NSOrderedAscending)
                                        {
                                            //描述信息
                                            NSString *releaseNotes = [[[dict objectForKey:@"results"] objectAtIndex:0] objectForKey:@"releaseNotes"];
                                            NSString *infoStr = [NSString stringWithFormat:@"发现版本%@更新：\n%@\n立即升级，享受更便捷的营业厅服务~ ",newV,releaseNotes];
//                                            newVLabel.text = [NSString  stringWithFormat:@"有新版本%@可用", newV];
                                            newVLabel.text = infoStr ;
                                            newVLabel.numberOfLines = 0;
                                            [newVLabel sizeToFit];
                                            
                                            updateBtn.frame = CGRectMake(32, CGRectGetMaxY(newVLabel.frame)+30, 256, 42);
                                            updateBtn.enabled = YES;
                                        }
                                        else
                                        {
                                            newVLabel.textAlignment = UITextAlignmentCenter ;
                                            newVLabel.text = @"已经是最新版本啦";
                                            updateBtn.enabled = NO;
                                        }
                                        
                                    } onError:^(NSError *engineError) {
                                        
                                        ToastAlertView *alert = [ToastAlertView new];
                                        [alert showAlertMsg:@"系统繁忙，请稍后再试"];
                                        
                                    }];
}

#pragma mark - self func

- (void)onUpdateAction
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/zhong-guo-dian-xin-zhang-shang/id513836029?mt=8&uo=4"]];
}

#pragma mark - Nav

- (void)onLeftBtnAction:(id)sender
{
    if (self.isDismissMVC && [self respondsToSelector:@selector(dismissModalViewControllerAnimated:)])
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
