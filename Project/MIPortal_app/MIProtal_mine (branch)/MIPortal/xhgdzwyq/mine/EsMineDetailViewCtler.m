/*--------------------------------------------
 *Name：EsMineDetailViewCtler.h
 *Desc：我的界面详情模块
 *Date：2014/06/06
 *Auth：shanhq
 *--------------------------------------------*/

#import "EsMineDetailViewCtler.h"
#import "CSMineHeadView.h"
#import "ODRefreshControl.h"
#import "CSMineHeadView.h"
#import "SVProgressHUD.h"
#import "EsLoadingMoreCell.h"
#import "EsMineListNetAgent.h"
#import "EsNewsCell.h"
#import "EsNewsDetailViewController.h"
#import "EsMineContentViewCtrler.h"

@interface EsMineDetailViewCtler ()
{
    UITableView*    _contentTable;
    EsMineListNetAgent*     _netAgent;
    NSDictionary* params;
    NSString *method;
}
@property (nonatomic, strong) CSMineHeadView *CSView;

@end

@implementation EsMineDetailViewCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setBackButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    
    CGFloat spitW = 10;
    CGFloat cx = spitW,cy = 20;
    CGFloat uWidth = mainSize.width-spitW*2,uHeight = 45;
    
    // 头部自定义view
    {
        __weak typeof(self) wself = self;
        CSMineHeadView *view = [[CSMineHeadView alloc]initWithLeftButtonSelectBlock:^{
            CLog(@"%s", __func__);
            [wself BtnTouchCallBak];
            
        }];
        [self.view addSubview:view];
        self.CSView = view;
        cy = CGRectGetMaxY(view.frame)+10;
    }
    
    switch (self.selectTag) {
        case 0:
            
            //个人详细信息
        {
            self.title = @"个人信息";
            
            NSArray *labelArr = @[@"所属部门：", @"手机号：", @"邮箱：", @"微信号：", @"工作地点："];
            NSMutableArray *fieldArr = [NSMutableArray array];
            [fieldArr addObjectsFromArray:@[[[[[Global sharedSingleton]userVerify]user]department],
                                            [[[[Global sharedSingleton]userVerify]user]phone],
                                            [[[[Global sharedSingleton]userVerify]user]email],
                                            [[[[Global sharedSingleton]userVerify]user]weixinNum],
                                            [[[[Global sharedSingleton]userVerify]user]workplace],
                                            ]];
            for (NSString *string in labelArr) {
                
                UILabel *label = [UILabel new];
                
                label.font = [UIFont boldSystemFontOfSize:16];
                label.text = [NSString stringWithFormat:@"  %@  %@", string,
                              [fieldArr objectAtIndex:[labelArr indexOfObject:string]]];
                label.textColor = kUIColorFromRGB(0x333333);
                label.frame = CGRectMake(cx, cy, uWidth, uHeight);
                label.backgroundColor = kUIColorFromRGB(0xeeeeee);
                [self.view addSubview:label];
                cy = CGRectGetMaxY(label.frame)+10;
            }
        }
            break;
            
        case 1:
        {
            self.title = @"我的项目";
            
        }
            break;
        
        case 2:
            
            //我的说说
        {
            self.title = @"我的说说";
            {
                //说说列表
                UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, cy, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - cy)];
                tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                tableView.delegate     = (id<UITableViewDelegate>)self;
                tableView.dataSource   = (id<UITableViewDataSource>)self;
                tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                tableView.backgroundColor = [UIColor clearColor];
                [self.view addSubview:tableView];
                _contentTable = tableView;
                
                //下拉刷新
                ODRefreshControl* refreshView = [[ODRefreshControl alloc] initInScrollView:tableView];
                [refreshView addTarget:self action:@selector(onRefreshAction:) forControlEvents:UIControlEventValueChanged];
            }
            
            // 网络请求初始化
            {
                
                _netAgent = [EsMineListNetAgent new];
                _netAgent.loadingType = NewsTableLoadingTypeRefresh;
                self.currentPage = 1;
                self.pageSize = @"20";
                method = @"getNewsListByUser";
                [self getNetworkList];
            }
        }
            break;
            
        case 3:
            
            //工作日志
        {
            self.title = @"工作汇报";
            {
                //上报列表
                UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, cy, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - cy)];
                tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                tableView.delegate     = (id<UITableViewDelegate>)self;
                tableView.dataSource   = (id<UITableViewDataSource>)self;
                tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                tableView.backgroundColor = [UIColor clearColor];
                [self.view addSubview:tableView];
                _contentTable = tableView;
                
                //下拉刷新
                ODRefreshControl* refreshView = [[ODRefreshControl alloc] initInScrollView:tableView];
                [refreshView addTarget:self action:@selector(onRefreshAction:) forControlEvents:UIControlEventValueChanged];
            }
            
            // 网络请求初始化
            {
                
                _netAgent = [EsMineListNetAgent new];
                _netAgent.loadingType = NewsTableLoadingTypeRefresh;
                self.currentPage = 1;
                self.pageSize = @"40";
                method = @"getReport";
                [self getNetworkList];
            }
        }
            break;
            
        default:
            break;
    }//switch
    
    // 注册通知
    {
        [[NSNotificationCenter defaultCenter] addObserver:_contentTable
                                                 selector:@selector(reloadData)
                                                     name:kMsgNewsListRefresh
                                                   object:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 网络请求
- (void)getNetworkList
{
    
    NSString* token = @"";
    if ([Global sharedSingleton].userVerify.user.token)
    {
        token = [Global sharedSingleton].userVerify.user.token;
    }
    params = @{@"token" : token,
               @"currentPage" :[NSString stringWithFormat:@"%d", self.currentPage],
               @"pageSize" : self.pageSize};
    __weak typeof(_contentTable) wtable = _contentTable;
    [_netAgent setParams:params andSetMethod:method completion:^{
        [wtable reloadData];
    }];
}

#pragma mark - 背景图片更换
-(void)BtnTouchCallBak
{
    //NSArray *
    UIActionSheet *actionSheet = nil;
    //检测是否有摄像头
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]
                       initWithTitle:nil
                       delegate:(id<UIActionSheetDelegate>)self
                       cancelButtonTitle:@"取消"
                       destructiveButtonTitle:nil
                       otherButtonTitles:@"从相册选择", @"拍照",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    }else
    {
        actionSheet = [[UIActionSheet alloc]
                       initWithTitle:nil
                       delegate:(id<UIActionSheetDelegate>)self
                       cancelButtonTitle:@"取消"
                       destructiveButtonTitle:nil
                       otherButtonTitles:@"从相册选择",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    }
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {//从相册选择
        UIImagePickerController *pickCtler = [[UIImagePickerController alloc]init];
        pickCtler.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickCtler.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self;
        [self presentModalViewController:pickCtler animated:YES];
    }
    else if(buttonIndex == 1 && actionSheet.numberOfButtons > 2)
    {//拍照
        UIImagePickerController *pickCtler = [[UIImagePickerController alloc]init];
        pickCtler.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickCtler.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self;
        [self presentModalViewController:pickCtler animated:YES];
    }
}

#pragma mark - UIImagePickerControllerDelegate
//获取图像
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获得编辑过的图片
    UIImage* image = [info objectForKey: @"UIImagePickerControllerOriginalImage"];
    
    NSData *data = UIImageJPEGRepresentation(image, 100);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:@"MineHeadBgView"];
    [defaults synchronize];
    [self.CSView.leftButton setImage:image forState:UIControlStateNormal]; // 更换背景图
    
    [picker dismissModalViewControllerAnimated:YES];
}

//当用户取消时，调用该方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}


#pragma mark - 下拉刷新
- (void)onRefreshAction:(ODRefreshControl* )sender
{
    __weak typeof(sender) wrefresh = sender;
    __weak typeof(_contentTable) wtable = _contentTable;
    [_netAgent refreshNewsList:^
     {
         [wrefresh endRefreshing];
         [wtable reloadData];
     } headlineCompletion:^(EsMineListNetAgent *sender)
     {
     }];
}

#pragma mark UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_netAgent.loadingType == NewsTableLoadingTypeLoadingMore)
    {
        return 2;
    }
    else if (_netAgent.loadingType == NewsTableLoadingTypeRefresh)
    {
        return 1;
    }
    else if (_netAgent.loadingType == NewsTableLoadingTypeNone)
    {
        return 1;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        
        return 40;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [(EsNewsCell* )[self tableView:tableView cellForRowAtIndexPath:indexPath] getCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_netAgent.loadingType == NewsTableLoadingTypeLoadingMore)
    {
        return [_netAgent.newsList count];
    }
    else if (_netAgent.loadingType == NewsTableLoadingTypeNone)
    {
        return [_netAgent.newsList count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identifierStr = @"cell";
    EsNewsCell* cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (!cell)
    {
        cell = [[EsNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierStr];
    }
    
    if (_netAgent.newsList.count>0) {
        
        cell.newsInfo = _netAgent.newsList[indexPath.row];
        cell.tag = indexPath.row;
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s %d", __func__, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.navigationController.topViewController isKindOfClass:[EsNewsDetailViewController class]])
    {
        // ios7在某些极端的情况下，当用两个手指快速切换栏目时，两个不同按钮的触摸事件会同时响应
        return;
    }
    
    int count = indexPath.row + _netAgent.newsHeadlines.count;
    for (int i = 0; i < indexPath.section; i++)
    {
        EsDayNews* news = _netAgent.dayNewsList[i];
        count+= news.news.count;
    }
    
//    EsNewsDetailViewController* vctler = [EsNewsDetailViewController new];  //复用说说新闻列表的详情模块
    EsMineContentViewCtrler *vctler = [EsMineContentViewCtrler new];
    vctler.netAgent = _netAgent;
    vctler.selectIdx = count;
    if (_netAgent.reportList.count>0) {
        
        vctler.newsDetail = _netAgent.reportList[indexPath.row];
    }
    [self.navigationController pushViewController:vctler animated:YES];
    NSLog(@"%s %d end", __func__, indexPath.row);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BOOL needLoadingView = NO;
    if (_netAgent.loadingType == NewsTableLoadingTypeRefresh)
    {
        needLoadingView = YES;
    }
    else if (_netAgent.loadingType == NewsTableLoadingTypeLoadingMore)
    {
        needLoadingView = YES;
        self.currentPage++;
        [self getNetworkList];
    }
    
    if (needLoadingView)
    {
        EsLoadingMoreCell * cell = [[EsLoadingMoreCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 40)];
        return cell;
    }
    else
    {
        return nil;
    }
    
    return nil;
}

@end
