//
//  CTContractPhoneVCtler.m
//  CTPocketV4
//
//  Created by liuruxian on 13-11-18.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTContractPhoneVCtler.h"
#import "UIView+RoundRect.h"
#import "SearchView.h"
#import "CserviceOperation.h"
#import "AppDelegate.h"
#import "NSDataAdditions.h"
#import "ContractPhoneCell.h"
#import "SIAlertView.h"
#import "CTPhoneInfoVCtler.h"
#import <QuartzCore/QuartzCore.h>
#import "SVProgressHUD.h"
#import "ToastAlertView.h"
#import "CTLoginVCtler.h"
#import "CTLoadMoreCell.h"
#import "CTLoadingCell.h"

#define kContractBtnTag 200

@interface CTContractPhoneVCtler ()<UITableViewDataSource,UITableViewDelegate,searchPhoneInfodelgate>

@property (nonatomic, strong) NSMutableArray *phonesSellTypeArray;
@property (nonatomic, strong) NSMutableArray *searchPhoneInfoArray;


@property (nonatomic, strong) NSDictionary *indexDic;
@property (nonatomic, strong) NSString    *stock;
@property (nonatomic, strong) UITableView *phonesSellTaleView;


@property (nonatomic, strong) NSString *keyWord;

@property (nonatomic, assign) int showType;
//@property (nonatomic, strong) NSString    *stock;
@property (nonatomic, assign) int cellIndex;
@property (nonatomic, assign) BOOL isPush ;



@property (nonatomic, assign) int norPageIndex;
@property (nonatomic, assign) int norPageSize;
@property (nonatomic, assign) BOOL norIsLoading;
@property (nonatomic, assign) BOOL norIsFinished;

@property (nonatomic, assign) int searchPageInde;
@property (nonatomic, assign) int searchPageSize;
@property (nonatomic, assign) BOOL searchIsLoading;
@property (nonatomic, assign) BOOL  searchIsFinishing;



@property (nonatomic, strong) CserviceOperation *phoneSellsListOpt;
@property (nonatomic, strong) CserviceOperation *phonesStockOpt;

@property (nonatomic, strong) UIView *phoneSearchView;
@property (nonatomic, strong) UIView *tabBgView;
@property (nonatomic, strong) UIButton *coverButton;
@property (nonatomic, assign) BOOL isShowSearchView;
@property (nonatomic, strong) UITextField *searchTextFiled;

@property (nonatomic, assign) BOOL firstQry;

@end

@implementation CTContractPhoneVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.showType = 0;
        self.isShowSearchView = NO;
        self.firstQry = NO;
        if (!self.phonesSellTypeArray) {
            self.phonesSellTypeArray = [[NSMutableArray alloc]init];
        }
        
        if (!self.searchPhoneInfoArray) {
            self.searchPhoneInfoArray = [[NSMutableArray alloc]init];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(autoJumpPage)
                                                     name:@"autoJumpPage"
                                                   object:nil];
        self.norPageIndex = 1;
        self.norPageSize = 10;
        self.norIsFinished = NO;
        self.norIsLoading = NO;
        
        self.searchPageInde = 1;
        self.searchPageSize = 10;
        self.searchIsFinishing = NO;
        self.searchIsLoading = NO;
        
        self.keyWord = @"";
        
    }
    return self;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"合约机";
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
                tableview.dataSource = self;
                tableview.delegate = self;
                tableview.separatorStyle       = UITableViewCellSeparatorStyleNone;
                tableview.backgroundColor      = [UIColor clearColor];
                
                [tabBgView addSubview:tableview];
                self.phonesSellTaleView            = tableview;
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
        [self.view bringSubviewToFront:self.coverButton];
        [self loadmore:@""];
    }
}

#pragma mark - msg

- (void)autoJumpPage
{
    if(self.isPush)
    {
        NSString *UserId = [Global sharedInstance].custInfoDict[@"UserId"];
        if(!UserId && UserId.length==0)
        {
            NSDictionary *loginDict = [Global sharedInstance].loginInfoDict;
            NSString *Account = [loginDict objectForKey:@"UserLoginName"] ? [loginDict objectForKey:@"UserLoginName"] : @"";
            
            NSDictionary *params1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                     Account, @"Account",
                                     @"201", @"AccountType",
                                     ESHORE_ShopId, @"ShopId", nil];
            
            __block CTContractPhoneVCtler *weakSelf = self;
            [MyAppDelegate.cserviceEngine postXMLWithCode:@"custIdInfo"
                                                   params:params1
                                              onSucceeded:^(NSDictionary *dict) {
                                                  self.isPush = NO ;
                                                  //获取用户id
                                                  id Data = [dict objectForKey:@"Data"];
                                                  if (Data && [Data respondsToSelector:@selector(objectForKey:)]) {
                                                      [Global sharedInstance].custInfoDict = dict[@"Data"];
                                                      //                                                  [weakSelf bankCardInfo];
                                                      if (_showType == 0) {
                                                          weakSelf.indexDic =  [_phonesSellTypeArray objectAtIndex:self.cellIndex];
                                                          [weakSelf StockNumRequest:weakSelf.indexDic];
                                                      }else{
                                                          weakSelf.indexDic =  [_searchPhoneInfoArray objectAtIndex:self.cellIndex];
                                                          [weakSelf StockNumRequest:weakSelf.indexDic];
                                                      }
                                                  }
                                              } onError:^(NSError *engineError) {
                                                  //                                              [SVProgressHUD dismiss];
                                                  self.isPush = NO ;
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
        }else {
            self.isPush = NO ;
            if (_showType == 0) {
                self.indexDic =  [_phonesSellTypeArray objectAtIndex:self.cellIndex];
                [self StockNumRequest:self.indexDic];
            }else{
                self.indexDic =  [_searchPhoneInfoArray objectAtIndex:self.cellIndex];
                [self StockNumRequest:self.indexDic];
            }
        }
        
    }
    

}

#pragma mark - function

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
                                [self.phonesSellTaleView reloadData];
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
    self.searchPageInde = 1;
    self.searchIsLoading = YES ;
    self.searchIsFinishing = NO;
    
    if (self.searchPhoneInfoArray) {
        [self.searchPhoneInfoArray removeAllObjects];
    } else {
        self.searchPhoneInfoArray = [NSMutableArray array];
    }
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeGradient];
    [self qrySalesProductList:self.searchTextFiled.text pageIndex:self.searchPageInde];
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

- (void) loadmore : (NSString *)keyWord
{
    if(self.showType == 0)
    {
        if(self.norIsFinished)
        {
            return;
        }
        if(!self.norIsLoading) {
            self.norIsLoading = YES;
            [self qrySalesProductList:@"" pageIndex:self.norPageIndex];
        }
    } else {
        if(self.searchIsFinishing) {
            return ;
        }
        if(!self.searchIsLoading) {
            self.searchIsLoading = YES;
            [self qrySalesProductList:keyWord pageIndex:self.searchPageInde];
        }
    }
}

- (void) qrySalesProductList : (NSString *) keyWord pageIndex : (int) page
{
    //查询商品列表
    NSString *ShopId        = ESHORE_ShopId;
    NSString *Type          = @"8";
    NSString *PageIndex     =  [[NSString alloc] initWithFormat:@"%d",page];
    NSString *PageSize      = @"10"; //分页显示10条
    NSString *Keyword = keyWord;
    
    if (keyWord!=nil) {
        NSData* data = [keyWord dataUsingEncoding:NSUTF8StringEncoding];
        Keyword = [data base64EncodedString];
        Keyword = [Keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    NSDictionary * params   = [NSDictionary dictionaryWithObjectsAndKeys:
                               ShopId,   @"ShopId",
                               Type,     @"Type",
                               PageIndex,@"PageIndex",
                               PageSize, @"PageSize",
                               Keyword , @"Keyword",
                               nil];
    
    self.phoneSellsListOpt = [MyAppDelegate.cserviceEngine postXMLWithCode:@"qrySalesProductList"
                                                                    params:params
                                                               onSucceeded:^(NSDictionary *dict)
    {
        //格式化数据(将指定的数据格式化成数组)
        dict = [Utils objFormatArray:dict path:@"Data/DataList/List"];
        
       DDLogInfo(@"%s--%@", __func__, dict.description);
       id Data = [dict objectForKey:@"Data"];
       NSArray *tmpary = nil;
       if (Data && [Data respondsToSelector: @selector(objectForKey:)]) {
           id DataList = [Data objectForKey:@"DataList"];
           if (DataList && [DataList respondsToSelector:@selector(objectForKey:)]) {
               id List = [DataList objectForKey:@"List"];
               tmpary = List;
           }
       }
       
       
       if(self.showType == 0) {
           if(tmpary.count < 10) {
               self.norIsFinished = YES ;
               [self.phonesSellTypeArray addObjectsFromArray:tmpary];
           }
           else {
               [self.phonesSellTypeArray addObjectsFromArray:tmpary];
           }
           self.norIsLoading = NO;
           self.norPageIndex ++;
           [self.phonesSellTaleView reloadData];
       } else {
           if(tmpary.count < 10)
           {
               self.searchIsFinishing = YES;
               [self.searchPhoneInfoArray addObjectsFromArray:tmpary];
           }else {
               [self.searchPhoneInfoArray addObjectsFromArray:tmpary];
           }
           self.searchPageInde ++;
           self.searchIsLoading = NO;
           [self.phonesSellTaleView reloadData];
       }

       [SVProgressHUD dismiss];
       
   } onError:^(NSError *engineError) {
       DDLogInfo(@"%s--%@", __func__, engineError);
       [SVProgressHUD dismiss];
       
//                                                                   if (self.showType == 0) {
//                                                                       self.norIsLoading = NO ;
//                                                                   } else {
//                                                                       self.searchIsLoading = NO ;
//                                                                   }
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
           [strongSelf.phonesSellTaleView reloadData];
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
           }
       }
       else{
           ToastAlertView *alert = [ToastAlertView new];
           [alert showAlertMsg:@"系统繁忙,请稍后再试"];
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
    __block CTContractPhoneVCtler *weakSelf = self;
    
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
                                                                        CTPhoneInfoVCtler *phoneSellCtler = [[CTPhoneInfoVCtler alloc]init];
                                                                        [phoneSellCtler ChoosePage:0 Info:self.indexDic UsrID:@""];
                                                                        [weakSelf.navigationController pushViewController:phoneSellCtler animated:YES];
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

#pragma  mark - searchViewdelegage

-(void)searchPhoneInfo:(SearchView *)searchView
{
    [self.searchPhoneInfoArray removeAllObjects];
    
    _showType = 1;
    self.keyWord = [NSString stringWithString:searchView._searchInfo];
    if (_searchPhoneInfoArray  != nil) {
        [_searchPhoneInfoArray removeAllObjects];
    }
    [self qrySalesProductList: self.keyWord pageIndex:1];
    
}
#pragma mark - left and right
- (void) onRightBtnAction:(id)sender
{
    [self search];
}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_showType == 0) {
        if(section ==1 )
        {
            if(self.norIsFinished){
                return 0;
            } else {
                return 1;
            }
        } else {
            return _phonesSellTypeArray.count ;
        }
        
    }else{
        if(section ==1 )
        {
            if(self.searchIsFinishing){
                return 0;
            } else {
                return 1;
            }
        } else {
            return self.searchPhoneInfoArray.count ;
        }
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
        
//        [cell.spin startAnimating];
        
        if(self.showType == 0)
        {
//            [self loadmore:@""];
            [cell setView:self.norIsLoading];
        } else {
//            [self loadmore:self.keyWord];
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
            [cell setInfo:self.phonesSellTypeArray[row]];
        }
        else{
            if (self.searchPhoneInfoArray.count > 0 ) {
                [cell setInfo:self.searchPhoneInfoArray[row]];
            }
        }
        return  cell;
    }
}
//设置tablevie的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        return 45 ;
    }
    return 103;
}
//cell响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
    
    int index = indexPath.row;
    if ([Global sharedInstance].isLogin == NO) {
        CTLoginVCtler *vc = [[CTLoginVCtler alloc] init];
        self.cellIndex = index ;
        self.isPush = YES ;
        vc.isPush = YES ;
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
        
        __block CTContractPhoneVCtler *weakSelf = self;
        [MyAppDelegate.cserviceEngine postXMLWithCode:@"custIdInfo"
                                               params:params1
                                          onSucceeded:^(NSDictionary *dict) {
                                              
                                              //获取用户id
                                              id Data = [dict objectForKey:@"Data"];
                                              if (Data && [Data respondsToSelector:@selector(objectForKey:)]) {
                                                  [Global sharedInstance].custInfoDict = dict[@"Data"];
//                                                  [weakSelf bankCardInfo];
                                                  if (_showType == 0) {
                                                      weakSelf.indexDic =  [_phonesSellTypeArray objectAtIndex:index];
                                                      [weakSelf StockNumRequest:weakSelf.indexDic];
                                                  }else{
                                                      weakSelf.indexDic =  [_searchPhoneInfoArray objectAtIndex:index];
                                                      [weakSelf StockNumRequest:weakSelf.indexDic];
                                                  }
                                              }
                                          } onError:^(NSError *engineError) {
//                                              [SVProgressHUD dismiss];
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
    }else {
        if (_showType == 0) {
            self.indexDic =  [_phonesSellTypeArray objectAtIndex:index];
            [self StockNumRequest:self.indexDic];
        }else{
            self.indexDic =  [_searchPhoneInfoArray objectAtIndex:index];
            [self StockNumRequest:self.indexDic];
        }
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
        if (self.showType == 0) {
            if(self.norIsFinished)
            {
                return;
            }
            if(!self.norIsLoading) {
                self.norIsLoading = YES;
                [self.phonesSellTaleView reloadData];
                [self qrySalesProductList:@"" pageIndex:self.norPageIndex];
            }
          
        } else {
            if(self.searchIsFinishing) {
                return ;
            }
            if(!self.searchIsLoading) {
                self.searchIsLoading = YES;
                [self.phonesSellTaleView reloadData];
                [self qrySalesProductList:self.keyWord pageIndex:self.searchPageInde];
            }
        }
    }
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
