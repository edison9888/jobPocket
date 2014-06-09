//
//  CTCustomPagesVCtler.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-4.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  自定义首页

#import "CTCustomPagesVCtler.h"
#import "CTCustomPagesCell.h"
#import "Utils.h"
#import "ABAddressBookCache.h"
#import "CTMoreVCtler.h"

#define CTCustomPagesCellHeight 49.0f

NSString* const kHasAddedABIcon2HomePageKey = @"hasAddedABIcon2HomePage";   // added by zy, 2014-04-02

@interface CTCustomPagesVCtler () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *customIconArray;
@property (strong, nonatomic) UITableView *customIconTableView;
@property (strong, nonatomic) NSMutableArray *selectdIconArray;

@end

@implementation CTCustomPagesVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"自定义首页";
        
#if 0   // modified by zy, 2014-04-02
        // added by zy, 2014-04-02
        NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
        BOOL showNewFlag = (![def objectForKey:kHasAddedABIcon2HomePageKey] && ![def objectForKey:kCTAddrBookSyncStatusKey]);
        // added by zy, 2014-04-02

        self.customIconArray = [NSArray arrayWithObjects:
                                @{@"icon":(showNewFlag?@"more_16_new":@"more_16"), @"title":@"通讯录助手"},  // added by zy, 2014-04-02
                                @{@"icon":@"custom_Icon18", @"title":@"精选靓号"},  // added by zy, 2014-02-18
                                @{@"icon":@"custom_Icon2", @"title":@"历史账单"},
                                @{@"icon":@"custom_Icon3", @"title":@"剩余流量"},
                                @{@"icon":@"custom_Icon4", @"title":@"充流量"},
                                @{@"icon":@"custom_Icon5", @"title":@"积分兑换"},
                                @{@"icon":@"custom_Icon6", @"title":@"订单查询"},
                                @{@"icon":@"custom_Icon7", @"title":@"增值业务查询"},
                                @{@"icon":@"custom_Icon8", @"title":@"业务办理"},
                                @{@"icon":@"custom_Icon9", @"title":@"单买手机"},
                                @{@"icon":@"custom_Icon13", @"title":@"用户吐槽"},
                                nil];
        
        self.selectdIconArray = [[NSMutableArray alloc] initWithArray:[Utils getCustomIconList]];
#else
        [self resetData];
#endif
        
        // added by zy, 2014-04-02
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didRefreshNewFlag)
                                                     name:CTRefreshNewFlag
                                                   object:nil];
    }
    return self;
}

// added by zy, 2014-04-02
- (void)didRefreshNewFlag
{
    [self resetData];
    [self.customIconTableView reloadData];
}

// added by zy, 2014-04-02
- (void)resetData
{
    // added by zy, 2014-04-02
    NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
    BOOL showNewFlag = (![def objectForKey:kHasAddedABIcon2HomePageKey] && ![def objectForKey:kCTAddrBookSyncStatusKey]);
    // added by zy, 2014-04-02
    
    self.customIconArray = [NSArray arrayWithObjects:
                            @{@"icon":(showNewFlag?@"more_16_new":@"more_16"), @"title":@"通讯录助手"},  // added by zy, 2014-04-02
                            @{@"icon":@"custom_Icon18", @"title":@"精选靓号"},  // added by zy, 2014-02-18
                            @{@"icon":@"custom_Icon2", @"title":@"历史账单"},
                            @{@"icon":@"custom_Icon3", @"title":@"剩余流量"},
                            @{@"icon":@"custom_Icon4", @"title":@"充流量"},
                            @{@"icon":/*@"custom_Icon5"*/@"custom_Icon17", @"title":/*@"积分兑换"*/@"积分查询"},
                            @{@"icon":@"custom_Icon6", @"title":@"订单查询"},
                            @{@"icon":@"custom_Icon7", @"title":@"增值业务查询"},
                            @{@"icon":/*@"custom_Icon8"*/@"custom_Icon1", @"title":/*@"业务办理*/@"套餐查询"},
                            @{@"icon":@"custom_Icon9", @"title":@"单买手机"},
                            @{@"icon":@"custom_Icon13", @"title":@"用户吐槽"},
                            nil];
    
    self.selectdIconArray = [[NSMutableArray alloc] initWithArray:[Utils getCustomIconList]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    self.customIconTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.customIconTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.customIconTableView.rowHeight = CTCustomPagesCellHeight;
    self.customIconTableView.delegate = self;
    self.customIconTableView.dataSource = self;
    self.customIconTableView.backgroundColor = [UIColor clearColor];
    self.customIconTableView.separatorStyle = UITableViewCellSeparatorStyleNone;    // added by zy, 2014-02-19
    [self.view addSubview:self.customIconTableView];
}

#pragma mark - Nav

- (void)onLeftBtnAction:(id)sender
{
    [Utils saveCustomIconList:self.selectdIconArray];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadCustomIconView" object:nil];
    if (self.isDismissMVC && [self respondsToSelector:@selector(dismissModalViewControllerAnimated:)])
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    BOOL isSelected = NO;
    int i = 0;
    for (NSDictionary *dict in self.selectdIconArray) {
        NSString *title = self.customIconArray[indexPath.row][@"title"];
        if ([title isEqualToString:dict[@"title"]]) {
            isSelected = YES;
            break;
        }
        i++;
    }
    if (isSelected) {
        [self.selectdIconArray removeObjectAtIndex:i];
    }
    else
    {
#if 0   // modified by zy, 2014-04-02
        [self.selectdIconArray addObject:self.customIconArray[indexPath.row]];
#else 
        NSString *title = self.customIconArray[indexPath.row][@"title"];
        if ([title isEqualToString:@"通讯录助手"]) {
            NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
            if (![def objectForKey:kHasAddedABIcon2HomePageKey]) {
                [def setBool:YES forKey:kHasAddedABIcon2HomePageKey];
                [def synchronize];
                [self resetData];
                [self.selectdIconArray addObject:self.customIconArray[indexPath.row]];
                [tableView reloadData];
            } else {
                [self.selectdIconArray addObject:self.customIconArray[indexPath.row]];
            }
        } else {
            [self.selectdIconArray addObject:self.customIconArray[indexPath.row]];
        }
#endif
    }
    [self.customIconTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"CTCustomPagesCell";
    CTCustomPagesCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[CTCustomPagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    [cell setCellInfo:self.customIconArray[indexPath.row] selectedIconsArray:self.selectdIconArray];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.customIconArray count];
}

@end
