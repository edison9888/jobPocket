//
//  EsNoticeSettingVCtler.m
//  xhgdzwyq
//
//  Created by apple on 13-11-28.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsNoticeSettingVCtler.h"
#import "EsNoticeSettingCell.h"
#import "EsNewsColumn.h"

#if (kBestappSdkOpen)
    #import "Bearing.h"
#endif

static NSString* __helpContext = @"使用方法：\n新闻提醒可针对每个栏目设置，“ON”代表接收该栏目更新内容的提醒消息，“OFF”为不提醒";

@interface EsNoticeSettingVCtler ()
{
    UITableView*    _contentTable;
}

@end

@implementation EsNoticeSettingVCtler

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
    self.title = @"重要新闻提醒设置";
    
    {
        UITableView* v = [[UITableView alloc] initWithFrame:self.view.bounds];
        v.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        v.delegate     = (id<UITableViewDelegate>)self;
        v.dataSource   = (id<UITableViewDataSource>)self;
        v.separatorStyle = UITableViewCellSeparatorStyleNone;
        v.backgroundColor = [UIColor clearColor];
        [self.view addSubview:v];
        _contentTable = v;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onLeftBtnAction:(id)sender
{
    {
        NSMutableArray* receivedArr = [NSMutableArray new];
        NSMutableArray* rejectedArr = [NSMutableArray new];
        for (EsNewsColumn* column in [Global sharedSingleton].columns)
        {
            if (column.receivedPushMsg)
            {
                [receivedArr addObject:[NSString stringWithFormat:@"%@", column.catalogId]];
            }
            else
            {
                [rejectedArr addObject:[NSString stringWithFormat:@"%@", column.catalogId]];
            }
        }
        
        {
            NSUserDefaults* def = [NSUserDefaults standardUserDefaults];
            NSString* key = [NSString stringWithFormat:@"%@_%@", [def stringForKey:kPhoneNumber], kPushMsgIDsNotReceive];
            [def setObject:[rejectedArr componentsJoinedByString:@","] forKey:key];
            [def synchronize];
        }
        
#if (kBestappSdkOpen)
        {
            // {category: "分类名", tags: ["标签名1", "标签名2", "标签名3"]}
            NSArray* tagArr = @[@{@"category" : @"栏目", @"tags" : receivedArr}];
            NSLog(@"tags: %@", tagArr);
            [Bearing setTags:tagArr];
        }
#endif
    }
    
    [super onLeftBtnAction:sender];
}

- (void)onRightBtnAction:(id)sender
{
    UIAlertView*  alert = [[UIAlertView alloc] initWithTitle:@"帮助"
                                                     message:__helpContext
                                                    delegate:nil
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil];
    [alert show];
}

#pragma mark UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kNoticeSettingCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), kNoticeSettingCellHeight)];
    v.backgroundColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? kBackgroundColor_D : kBackgroundColor_N);
    {
        UIImageView* iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Important_news_alert_before_the_color_settings"]];
        iv.frame = CGRectMake(20, (v.frame.size.height - iv.frame.size.height)/2, iv.frame.size.width, iv.frame.size.height);
        [v addSubview:iv];
    }
    {
        UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, CGRectGetWidth(v.frame) - 30, CGRectGetHeight(v.frame))];
        lab.backgroundColor = [UIColor clearColor];
        lab.text = @"提醒设置";
        lab.textAlignment = UITextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:12];
        lab.textColor = ([Global sharedSingleton].uiStyle.mode == UIStyleModeDay ? [UIColor blackColor] : RGB(0x99, 0x99, 0x99, 1));
        [v addSubview:lab];
    }
    {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CGRectGetWidth(v.frame) - 50, 0, 50, kNoticeSettingCellHeight);
        [btn setImage:[UIImage imageNamed:@"button_Help"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [v addSubview:btn];
    }
    {
        UIImageView* iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Set_thick"]];
        iv.frame = CGRectMake(15, CGRectGetHeight(v.frame) - iv.frame.size.height, CGRectGetWidth(v.frame) - 15, iv.frame.size.height);
        [v addSubview:iv];
    }
    
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kNoticeSettingCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Global sharedSingleton].columns.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifierStr = @"cell";
    EsNoticeSettingCell* cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (!cell)
    {
        cell = [[EsNoticeSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr];
    }
    [cell setColumnInfo:((EsNewsColumn *)[Global sharedSingleton].columns[indexPath.row])];
    
    return cell;
}

@end
