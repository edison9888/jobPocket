//
//  CTBarePhoneVCtler.m
//  CTPocketV4
//
//  Created by liuruxian on 13-11-25.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBarePhoneVCtler.h"
#import "CserviceOperation.h"
#import "UIView+RoundRect.h"
#import "AppDelegate.h"
#import "CTLoginVCtler.h"
#import "CTBarePhoneCell.h"
#import "CTLoadMoreCell.h"
#import "SVProgressHUD.h"
#import "CTPhoneInfoVCtler.h"
#import "SearchView.h"
#import "ToastAlertView.h"
#import "SIAlertView.h"
#import "ContractPhoneCell.h"
#import "CTLoadingCell.h"

#define kLoadMoreCellHeight 45.0f

@interface CTBarePhoneVCtler ()


@property (nonatomic, strong) UIImageView* bgImageView;
@property (nonatomic, strong) UIView* coverView;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) NSMutableArray *norArray;
@property (nonatomic, strong) NSMutableArray *searchArray;
@property (nonatomic, strong) NSString *userId;

@property (nonatomic, assign) BOOL isLoadWithFailed;
@property (nonatomic, assign) int showType;
@property (nonatomic, assign) BOOL isSearchLoadMore;  //查找状态下拉刷新完成后
@property (nonatomic, assign) BOOL isNorLoadMore;      //正常状态下拉刷新完成后
@property (nonatomic, assign) int norPageIndex;
@property (nonatomic, assign) int searchPageIndex;
@property (nonatomic, assign) BOOL isLoadFinish; //一次加载完成
@property (nonatomic, strong) NSString* keyWord;

@property (nonatomic, strong) CserviceOperation *phonesStockOpt;
@property (nonatomic, strong) CserviceOperation* bareOpt;
@property (nonatomic, strong) NSString    *stock;
@property (nonatomic, strong) NSDictionary *indexDic;
@property (nonatomic, assign) BOOL isPush;

@property (nonatomic, assign) int norPageSize;
@property (nonatomic, assign) BOOL norIsLoading;
@property (nonatomic, assign) BOOL norIsFinished;

@property (nonatomic, assign) int searchPageSize;
@property (nonatomic, assign) BOOL searchIsLoading;
@property (nonatomic, assign) BOOL  searchIsFinishing;

@property (nonatomic, strong) UIImageView *imageViewBG;
@property (nonatomic, strong) UIScrollView *scrollview;

@property (nonatomic, strong) UIView *phoneSearchView;
@property (nonatomic, strong) UIView *tabBgView;
@property (nonatomic, strong) UIButton *coverButton;
@property (nonatomic, assign) BOOL isShowSearchView;
@property (nonatomic, strong) UITextField *searchTextFiled;

@end

@implementation CTBarePhoneVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.norArray = [NSMutableArray new];
        self.searchArray = [NSMutableArray new];
        self.isNorLoadMore = NO;
        self.isSearchLoadMore = NO;
        self.isLoadFinish = NO;
        self.showType = 0;
        self.searchPageIndex = 1;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"裸机";
    [self setLeftButton:[UIImage imageNamed:@"btn_back_recharge.png"]];
    [self setRightButton:[UIImage imageNamed:@"contract_search.png"]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    float yOriginal = 0;
    yOriginal = 1;
    {
        //内容显示
        {
            {
                UIView *tabBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.view.frame)-20,iPhone5?450:360)];
                tabBgView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin ;
                [tabBgView dwMakeBottomRoundCornerWithRadius:5];
                tabBgView.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1];
                [self.view addSubview:tabBgView];
                self.tabBgView = tabBgView;
                
                UITableView *tableview         = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(tabBgView.frame)-20, CGRectGetHeight(tabBgView.frame)-20)];
                tableview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
                tableview.dataSource = (id<UITableViewDataSource>)self;
                tableview.delegate = (id<UITableViewDelegate>)self;
                tableview.separatorStyle       = UITableViewCellSeparatorStyleNone;
                tableview.backgroundColor      = [UIColor clearColor];
                
                [tabBgView addSubview:tableview];
                self.tableView            = tableview;
            }
        }
        {
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, -43, CGRectGetWidth(self.view.frame), 43)];
            bgView.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1];
            [self.view addSubview:bgView];
            self.phoneSearchView = bgView;
            {
                UIImage *image = [UIImage imageNamed:@"prettyNum_searchBar_bg.png"];
                CGRect rect = CGRectMake(24,
                                         6,
                                         221,
                                         43-12);
                UITextField *textField = [[UITextField alloc] initWithFrame:rect];
                textField.delegate = (id<UITextFieldDelegate>)self;
                textField.backgroundColor = [UIColor clearColor];
                textField.borderStyle = UITextBorderStyleNone;
                textField.background = image ;
                textField.textColor = [UIColor blackColor];
                textField.font = [UIFont systemFontOfSize:14];
                textField.clearButtonMode = UITextFieldViewModeNever;
                textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                textField.keyboardType = UIKeyboardTypeDefault;
                textField.returnKeyType = UIReturnKeySearch;
                textField.enablesReturnKeyAutomatically = YES;
                textField.autocorrectionType = UITextAutocorrectionTypeNo;
                textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                [textField dwMakeRoundCornerWithRadius:5];
                self.searchTextFiled = textField ;
                {
                    image = [UIImage imageNamed:@"SearchIcon.png"];
                    UIView *view = [[UIView alloc] initWithFrame:
                                    CGRectMake(0, 0, image.size.width + 12, textField.frame.size.height)];
                    view.backgroundColor = [UIColor clearColor];
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                    imageView.backgroundColor = [UIColor clearColor];
                    CGRect rect = imageView.frame;
                    rect.origin.x = 8;
                    rect.origin.y = ceilf((view.frame.size.height - rect.size.height) / 2);
                    imageView.frame = rect;
                    
                    [view addSubview:imageView];
                    
                    textField.leftView = view;
                    textField.leftViewMode = UITextFieldViewModeAlways;
                }
                
                {
                    image = [UIImage imageNamed:@"prettyNum_cancel_icon.png"];
                    
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.backgroundColor = [UIColor clearColor];
                    [button setImage:image forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(cancelSearchAction) forControlEvents:UIControlEventTouchUpInside];
                    button.frame = CGRectMake(0, 0, image.size.width + 12, textField.frame.size.height);
                    CGRect rect = button.frame;
                    rect.origin.x = 8;
                    rect.origin.y = ceilf((button.frame.size.height - rect.size.height) / 2);
                    button.frame = rect;
                    textField.rightView = button;
                    
                    textField.rightViewMode = UITextFieldViewModeAlways;
                }
                
                textField.placeholder = @"  请输入搜索内容";
                [bgView addSubview:textField];
                
                UIImage  *img       = [UIImage imageNamed:@"query_btn.png"];
                UIImage * himg      = [UIImage imageNamed:@"query_btn_highlight.png"];
                UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                searchBtn.frame     = CGRectMake(CGRectGetMaxX(textField.frame)+15,
                                                 (bgView.frame.size.height - img.size.height)/2,
                                                 50,img.size.height);
                [searchBtn setBackgroundImage:[img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height/2, img.size.width/2, img.size.height/2, img.size.width/2)] forState:UIControlStateNormal];
                [searchBtn setBackgroundImage:[himg resizableImageWithCapInsets:UIEdgeInsetsMake(himg.size.height/2, himg.size.width/2, himg.size.height/2, himg.size.width/2)] forState:UIControlStateHighlighted];
                [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
                [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [searchBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
                [searchBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:12 ]];
                [searchBtn addTarget:self action:@selector(favorites) forControlEvents:UIControlEventTouchUpInside];
                [bgView addSubview:searchBtn];
            }
        }
        
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button addTarget:self action:@selector(coverBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            
            button.backgroundColor = [UIColor clearColor];
            button.hidden = YES ;
            self.coverButton = button;
            button.frame = CGRectMake(0,43, self.view.frame.size.width, self.view.frame.size.height-43);
        }
    }
    self.norPageIndex = 1;
    [self qryBareList:@"" pageIndex:self.norPageIndex];
    self.norIsLoading = YES;
}

#pragma mark - fun

-(void)search
{
    [self.searchTextFiled resignFirstResponder] ;
    self.coverButton.hidden = YES;
    
    if (!self.isShowSearchView) {
        self.isShowSearchView = YES;
        
        [UIView animateWithDuration:0.35
                         animations:^(void)
         {
             
         }
                         completion:^(BOOL finished)
         {
             CGRect rect = self.phoneSearchView.frame;
             rect.origin.y = 0;
             self.phoneSearchView.frame = rect ;
             
             rect = self.tabBgView.frame;
             rect.origin.y = CGRectGetMaxY(self.phoneSearchView.frame)+ 2;
             rect.size.height -= 45;
             self.tabBgView.frame = rect ;
             [self.tabBgView dwMakeBottomRoundCornerWithRadius:5];
         }];
        
    } else {
        
        self.isShowSearchView = NO;
        
        [UIView animateWithDuration:0.35
                         animations:^(void)
         {
             
         }
                         completion:^(BOOL finished)
         {
             CGRect rect = self.phoneSearchView.frame;
             rect.origin.y = -43;
             self.phoneSearchView.frame = rect ;
             
             rect = self.tabBgView.frame;
             rect.origin.y = CGRectGetMaxY(self.phoneSearchView.frame);
             rect.size.height += 45;
             self.tabBgView.frame = rect ;
             [self.tabBgView dwMakeBottomRoundCornerWithRadius:5];
             
             if (self.showType == 1) {
                 self.showType = 0 ;
                 [self.tableView reloadData];
             }
         }];
    }
}

- (void) favorites
{
    
    [self.searchTextFiled resignFirstResponder];
    self.coverButton.hidden = YES ;
    
    //搜索消息
    self.showType = 1;
    self.searchPageSize = 10;
    self.searchPageIndex = 1;
    self.searchIsLoading = YES ;
    self.searchIsFinishing = NO;
    
    if (self.searchArray) {
        [self.searchArray removeAllObjects];
    } else {
        self.searchArray = [NSMutableArray array];
    }
    
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
    NSString *text = self.searchTextFiled.text ;
    [self qryBareList:text pageIndex:self.searchPageIndex];
}

- (void) cancelSearchAction
{
    // 取消搜索
    [self.searchTextFiled resignFirstResponder];
    self.searchTextFiled.text = @"";
    self.coverButton.hidden = YES ;
}

- (void) coverBtnAction
{
    //点击覆盖区
    [self.searchTextFiled resignFirstResponder];
    self.coverButton.hidden = YES ;
}


- (void) loadMore : (NSString *)keyWord
{
    if(self.showType == 0)  //
    {
        if(self.norIsFinished)
        {
            return;
        }
        if(!self.norIsLoading) {
            self.norIsLoading = YES;
            [self qryBareList:@"" pageIndex:self.norPageIndex];
        }
    } else {
        if(self.searchIsFinishing) {
            return ;
        }
        if(!self.searchIsLoading) {
            self.searchIsLoading = YES;
            [self qryBareList:keyWord pageIndex:self.searchPageIndex];
        }
    }
}

#pragma mark - network

- (void) qryBareList : (NSString *) keyWord pageIndex : (int) pageIndex
{
    if (self.bareOpt) {
        [self.bareOpt cancel];
        self.bareOpt = nil;
    }
    
    NSString *ShopId        = ESHORE_ShopId;
    NSString *Type          = @"1";
    NSString *PageIndex     =  [[NSString alloc] initWithFormat:@"%d",pageIndex];  //页码
    NSString *PageSize      = @"10"; //分页显示10条
    NSString *Keyword = keyWord;

    NSDictionary * params   = [NSDictionary dictionaryWithObjectsAndKeys:
                               ShopId,   @"ShopId",
                               Type,     @"Type",
                               PageIndex,@"PageIndex",
                               PageSize, @"PageSize",
                               Keyword , @"Keyword",
                               nil];
    if (self.showType==1) {
        
    }
    
    self.bareOpt = [MyAppDelegate.cserviceEngine postXMLWithCode:@"qrySalesProductList"
                                                                    params:params
                       onSucceeded:^(NSDictionary *dict) {
                           DDLogInfo(@"%s--%@", __func__, dict.description);
                           id Data = [dict objectForKey:@"Data"];
                           NSArray *tmpary = nil;
                           if (Data && [Data respondsToSelector: @selector(objectForKey:)]) {
                               id DataList = [Data objectForKey:@"DataList"];
                               if (DataList && [DataList respondsToSelector:@selector(objectForKey:)]) {
                                   id List = [DataList objectForKey:@"List"];
                                   
                                   if ([List isKindOfClass:[NSDictionary class]]) {
                                       tmpary = [NSArray arrayWithObject:List];
                                   }else if([List isKindOfClass:[NSArray class]]){
                                       tmpary = List;
                                   }
                               }
                           }

                           if(self.showType == 0) {
                               if(tmpary.count < 10) {
                                   self.norIsFinished = YES ;
                                   [self.norArray addObjectsFromArray:tmpary];
                               }
                               else {
                                   [self.norArray addObjectsFromArray:tmpary];
                               }
                               self.norIsLoading = NO;
                               self.norPageIndex ++;
                               [self.tableView reloadData];
                           } else {
                               if(tmpary.count < 10)
                               {
                                   self.searchIsFinishing = YES;
                                   [self.searchArray addObjectsFromArray:tmpary];
                               }else {
                                   [self.searchArray addObjectsFromArray:tmpary];
                               }
                               
                               self.searchPageIndex ++;
                               self.searchIsLoading = NO;
                               [self.tableView reloadData];
                           }
                           
                            [SVProgressHUD dismiss];
                       }
                           onError:^(NSError *engineError) {
                               DDLogInfo(@"%s--%@", __func__, engineError);
                               //获取信息失败
                               [SVProgressHUD dismiss];
                               __weak __typeof(&*self)weakSelf = self;
                               double delayInSeconds = 1.0;
                               dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                               dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                   __strong __typeof(&*weakSelf)strongSelf = weakSelf;
                                   if (!strongSelf) {
                                       return;
                                   }
                                   if (strongSelf.showType == 0) {
                                       strongSelf.norIsLoading = NO;
                                   } else{
                                       strongSelf.searchIsLoading = NO ;
                                   }
                                   [strongSelf.tableView reloadData];
                               });
                               
                               if ([engineError.userInfo objectForKey:@"ResultCode"])
                               {
                                   if ([engineError.userInfo[@"ResultCode"] isEqualToString:@"X104"])
                                   {
                                       // 取消掉全部请求和回调，避免出现多个弹框
                                       [MyAppDelegate.cserviceEngine cancelAllOperations];
                                       // 提示重新登录
                                       SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                                                        andMessage:@"长时间未登录，请重新登录。"];
                                       [alertView addButtonWithTitle:@"确定"
                                                                type:SIAlertViewButtonTypeDefault
                                                             handler:^(SIAlertView *alertView) {
                                                                 [MyAppDelegate showReloginVC];
                                                                 if (self.navigationController != nil)
                                                                 {
                                                                     [self.navigationController popViewControllerAnimated:NO];
                                                                 }
                                                             }];
                                       alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                       [alertView show];
//                                       [alertView release];
                                   }
                                   else{
                                       ToastAlertView *alert = [ToastAlertView new];
                                       [alert showAlertMsg:@"系统繁忙,请重新提交"];
//                                       [alert release];
                                   }
                               }
                           }];
}

-(void)StockNumRequest:(NSDictionary *)dictionary
{
    if (self.phonesStockOpt) {
        [self.phonesStockOpt cancel];
        self.phonesStockOpt = nil ;
    }
    
    NSDictionary * params   =  [NSDictionary dictionaryWithObjectsAndKeys:
                                [dictionary objectForKey:@"SalesProdId"],@"TermResCd",
                                nil];
    
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    
    self.phonesStockOpt = [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryTermStockInfo"
                                                                 params:params
                                                            onSucceeded:^(NSDictionary *dict) {
                                                                DDLogInfo(@"%s--%@", __func__, dict.description);
                                                                id Data = [dict objectForKey:@"Data"];
                                                                if (Data && [Data respondsToSelector:@selector(objectForKey:)]) {
                                                                    _stock = [Data objectForKey:@"Stock"];
                                                                    NSString * tipmsg = @"阿哦，你挑到爆款啦，被抢光啦，逛逛别的吧~";
                                                                    if ([_stock intValue]<1) {
                                                                        ToastAlertView *alert = [ToastAlertView new];
                                                                        [alert showAlertMsg:tipmsg];
                                                                    }else{  //跳转
                                                                        NSString *usrId = [[Global sharedInstance].custInfoDict objectForKey:@"UserId"];
                                                                        CTPhoneInfoVCtler *newCtler = [[CTPhoneInfoVCtler alloc]init];
                                                                        [newCtler ChoosePage:1 Info:dictionary UsrID:usrId];
                                                                        [self.navigationController pushViewController:newCtler animated:YES];
                                                                       
                                                                    }
                                                                    
                                                                }
                                                                [SVProgressHUD dismiss];
                                                            } onError:^(NSError *engineError) {
                                                                DDLogInfo(@"%s--%@", __func__, engineError);
                                                                [SVProgressHUD dismiss];
                                                                if ([engineError.userInfo objectForKey:@"ResultCode"])
                                                                {
                                                                    if ([engineError.userInfo[@"ResultCode"] isEqualToString:@"X104"])
                                                                    {
                                                                        // 取消掉全部请求和回调，避免出现多个弹框
                                                                        [MyAppDelegate.cserviceEngine cancelAllOperations];
                                                                        // 提示重新登录
                                                                        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                                                                                         andMessage:@"长时间未登录，请重新登录。"];
                                                                        [alertView addButtonWithTitle:@"确定"
                                                                                                 type:SIAlertViewButtonTypeDefault
                                                                                              handler:^(SIAlertView *alertView) {
                                                                                                  [MyAppDelegate showReloginVC];
                                                                                                  if (self.navigationController != nil)
                                                                                                  {
                                                                                                      [self.navigationController popViewControllerAnimated:NO];
                                                                                                  }
                                                                                              }];
                                                                        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                                                        [alertView show];
                                                                    }
                                                                    else{
                                                                        ToastAlertView *alert = [ToastAlertView new];
                                                                        [alert showAlertMsg:@"信息获取失败"];
                                                                    }
                                                                }
                                                            }];
}

#pragma mark - UITableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        switch (self.showType) {
            case 0:
                if (!self.norIsFinished) {
                    return 1;
                }else{
                    return 0;
                }
                break;
            case 1:
                if (!self.searchIsFinishing) {
                    return 1;
                }else{
                    return 0;
                }
            break;
        }
    }
    
    if (self.showType == 0) {
        return self.norArray.count ;
    }else{
        return self.searchArray.count ;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        static NSString *LoadMoreCell = @"LoadMoreCell";
        CTLoadingCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadMoreCell];
        if(!cell) {
            cell = [[CTLoadingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LoadMoreCell];
        }
        
        if(self.showType == 0)
        {
            [cell setView:self.norIsLoading];
        } else {
            [cell setView:self.searchIsLoading];
        }
        
        return  cell;
    } else {
        static NSString *CellIdentifier = @"Cell";
        ContractPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell) {
            cell = [[ContractPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone ;
        }
        int row = indexPath.row ;
        if(self.showType == 0)
        {
            [cell setInfo:self.norArray[row]];
        }
        else{
            if (self.searchArray.count > 0 ) {
                [cell setInfo:self.searchArray[row]];
            }
        }
        return  cell;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 1个好友的Sections+1个Load More Section
    return 2;
}

//设置tablevie的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 103;
    }else{
        return 45;
    }
}

//cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    //处理当没有数据的时候点击转圈出现崩溃得问题
    if (indexPath.section == 1) {
        return ;
    }
    if ([Global sharedInstance].isLogin == NO) {
        CTLoginVCtler *vc = [[CTLoginVCtler alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [MyAppDelegate.tabBarController presentViewController:nav animated:YES completion:^(void){
        }];
        return;
    }

    NSString *UserId = [Global sharedInstance].custInfoDict[@"UserId"];
    if(!UserId && UserId.length==0)
    {
        NSDictionary *loginDict = [Global sharedInstance].loginInfoDict;
        NSString *Account = [loginDict objectForKey:@"UserLoginName"] ? [loginDict objectForKey:@"UserLoginName"] : @"";
        
        NSDictionary *params1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 Account, @"Account",
                                 @"201", @"AccountType",
                                 ESHORE_ShopId, @"ShopId", nil];
        
        __block CTBarePhoneVCtler *weakSelf = self;
        [MyAppDelegate.cserviceEngine postXMLWithCode:@"custIdInfo"
                                               params:params1
                                          onSucceeded:^(NSDictionary *dict) {
                                              
                                              //获取用户id
                                              id Data = [dict objectForKey:@"Data"];
                                              if (Data && [Data respondsToSelector:@selector(objectForKey:)]) {
                                                  [Global sharedInstance].custInfoDict = dict[@"Data"];
                                                  NSDictionary *dic;
                                                  if (_showType ==0) {
                                                      dic = [weakSelf.norArray objectAtIndex:indexPath.row];
                                                  }else{
                                                      dic = [weakSelf.searchArray objectAtIndex:indexPath.row];
                                                  }
                                                  [self StockNumRequest:dic];
                                              }
                                          } onError:^(NSError *engineError) {
                                              [SVProgressHUD dismiss];
                                              if ([engineError.userInfo objectForKey:@"ResultCode"])
                                              {
                                                  if ([engineError.userInfo[@"ResultCode"] isEqualToString:@"X104"])
                                                  {
                                                      // 取消掉全部请求和回调，避免出现多个弹框
                                                      [MyAppDelegate.cserviceEngine cancelAllOperations];
                                                      // 提示重新登录
                                                      SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                                                                       andMessage:@"长时间未登录，请重新登录。"];
                                                      [alertView addButtonWithTitle:@"确定"
                                                                               type:SIAlertViewButtonTypeDefault
                                                                            handler:^(SIAlertView *alertView) {
                                                                                [MyAppDelegate showReloginVC];
                                                                                if (self.navigationController != nil)
                                                                                {
                                                                                    [self.navigationController popViewControllerAnimated:NO];
                                                                                }
                                                                            }];
                                                      alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                                      [alertView show];
                                                  }
                                              }
                                              else{
                                                  ToastAlertView *alert = [ToastAlertView new];
                                                  [alert showAlertMsg:@"系统繁忙,请重新提交"];
                                              }
                                          }];
    }else{
        NSDictionary *dic;
        if (_showType ==0) {
            dic = [self.norArray objectAtIndex:indexPath.row];
        }else{
            dic = [self.searchArray objectAtIndex:indexPath.row];
        }
        [self StockNumRequest:dic];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    //判断是否到达底部
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 2;
    if(y > h + reload_distance) {
        if(self.showType == 0)  //
        {
            if(self.norIsFinished)
            {
                return;
            }
            if(!self.norIsLoading) {
                self.norIsLoading = YES;
                [self.tableView reloadData];
                [self qryBareList:@"" pageIndex:self.norPageIndex];
            }
        } else {
            if(self.searchIsFinishing) {
                return ;
            }
            if(!self.searchIsLoading) {
                self.searchIsLoading = YES;
                [self.tableView reloadData];
                [self qryBareList:self.keyWord pageIndex:self.searchPageIndex];
            }
        }
    }
    
}

#pragma  mark - action

- (void) onRightBtnAction:(id)sender
{
     [self search];
}

#pragma mark - searchView delegate

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length == 0) {
        return NO ;
    }
    
    self.coverButton.hidden = YES ;
    [self favorites];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.coverButton.hidden = NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    
    return YES;
}


@end
