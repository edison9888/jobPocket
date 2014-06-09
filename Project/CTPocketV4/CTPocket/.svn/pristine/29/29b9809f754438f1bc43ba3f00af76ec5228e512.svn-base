//
//  CRecipientSelectVctler.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-1-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CRecipientSelectVctler.h"
#import "CRecipientUpdateVctler.h"
#import "CserviceEngine.h"
#import "AppDelegate.h"
#import "SIAlertView.h"

#define kTagEditView    8765

@interface CRecipientSelectVctler ()
{
    NSMutableArray* _recipienList;
}
@property (strong, nonatomic)CserviceOperation *_QryOperation;
@property (strong, nonatomic)CserviceOperation *_delOperation;

-(void)getRecipienList;
-(void)OnEditBtnAdtion:(id)sender;
-(void)OnAddRecipien:(id)sender;
-(void)OnModifyBtn:(id)sender;
-(void)OnDeleteBtn:(id)sender;
-(void)onSelectOKAction:(id)sender;
@end

@implementation CRecipientSelectVctler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"选择收件人信息";
        _recipienList = [NSMutableArray new];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getRecipienList)
                                                     name:@"UpdateAddressSuccess"
                                                   object:nil];
        
        mSelIndex = -1;     // added by zy, 2014-02-14
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self]; // added by zy, 2014-02-14
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 左按钮
    [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    
    ifShowingEdit  = NO;
    isHiddenStatus = YES;
	// Do any additional setup after loading the view.
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,
                                                               CGRectGetWidth(self.view.frame),
                                                               CGRectGetHeight(self.view.frame))
                                              style:UITableViewStylePlain];
    mTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    mTableView.backgroundColor = [UIColor colorWithRed:235/255.0
                                                 green:235/255.0
                                                  blue:235/255.0
                                                 alpha:1.0];
    [self.view addSubview:mTableView];
    mTableView.delegate   = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle  = UITableViewCellSelectionStyleNone;
    mTableView.tableHeaderView = [self getHeaderView];
    mTableView.tableFooterView = [self getFooterView];

    // 请求数据
    [self getRecipienList]; // added by zy, 2014-02-14
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIView* editview = [self.view viewWithTag:kTagEditView];
    if (!editview)
    {
        editview = [[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetHeight(mTableView.frame),
                                                            CGRectGetWidth(mTableView.frame),70)];
        editview.tag     = kTagEditView;
        editview.backgroundColor = [UIColor colorWithRed:207/255.0
                                                   green:207/255.0
                                                    blue:207/255.0
                                                   alpha:1.0];
        {
            UIButton* btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
            btnEdit.frame = CGRectMake(45,13,103,39);
            [btnEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnEdit setTitle:@"修改" forState:UIControlStateNormal];
            UIImage* bgImg =
            [[UIImage imageNamed:@"myOrderBtn.png"] stretchableImageWithLeftCapWidth:20
                                                                        topCapHeight:20];
            [btnEdit setBackgroundImage:bgImg forState:UIControlStateNormal];
            [btnEdit addTarget:self action:@selector(OnModifyBtn:)
              forControlEvents:UIControlEventTouchUpInside];
            [editview addSubview:btnEdit];
            
            UIButton* btndele = [UIButton buttonWithType:UIButtonTypeCustom];
            btndele.frame = CGRectMake(172,13,103,39);
            [btndele setTitleColor:[UIColor whiteColor]
                          forState:UIControlStateNormal];
            [btndele setTitle:@"删除" forState:UIControlStateNormal];
            bgImg =
            [[UIImage imageNamed:@"myOrderBtn.png"] stretchableImageWithLeftCapWidth:20
                                                                        topCapHeight:20];
            [btndele setBackgroundImage:bgImg forState:UIControlStateNormal];
            [btndele addTarget:self action:@selector(OnDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
            [editview addSubview:btndele];
        }
        [self.view addSubview:editview];
    }
    //[self getRecipienList];   // modified by zy, 2014-02-14
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_recipienList count];
}

- (UIView *)getHeaderView{
    UIView* headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width, 30);
    headerView.backgroundColor = [UIColor clearColor];
    {
        UIButton* btnRead = [UIButton buttonWithType:UIButtonTypeCustom];
        btnRead.frame  = CGRectMake(CGRectGetWidth(self.view.frame)-100,0,80, 30);
        [btnRead setTitleColor:[UIColor colorWithRed:70/255.0
                                               green:136/255.0
                                                blue:31/255.0
                                               alpha:1]
                      forState:UIControlStateNormal];
        [btnRead setTitle:@"编辑" forState:UIControlStateNormal];
        [btnRead addTarget:self
                    action:@selector(OnEditBtnAdtion:)
          forControlEvents:UIControlEventTouchUpInside];
        [btnRead setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0,-20)];
        [headerView addSubview:btnRead];
    }
    return headerView;
}

- (UIView *)getFooterView{
    UIView* footView = [[UIView alloc] init];
    footView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    footView.backgroundColor = [UIColor clearColor];
    {
        
        UIButton* btnAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        btnAdd.frame = CGRectMake(40,10,CGRectGetWidth(self.view.frame)-80,35);;
        [btnAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnAdd.titleLabel.font = [UIFont systemFontOfSize:14];
        [btnAdd setTitle:@"添加新收件人信息" forState:UIControlStateNormal];
        UIImage* bgImg =
        [[UIImage imageNamed:@"FeiYoung_Btn2.png"] stretchableImageWithLeftCapWidth:20
                                                                    topCapHeight:20];
        [btnAdd setBackgroundImage:bgImg forState:UIControlStateNormal];
        [btnAdd addTarget:self
                   action:@selector(OnAddRecipien:)
         forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:btnAdd];
        
        UILabel* lab =[[UILabel alloc] init];
        lab.backgroundColor = [UIColor clearColor];
        lab.frame    = CGRectMake(40, 10, 20, 15);
        lab.textColor= [UIColor colorWithRed:70/255.0
                                       green:136/255.0
                                        blue:31/255.0
                                       alpha:1];
        lab.text = @"+";
        [btnAdd addSubview:lab];
    }
    {
        UIButton* btnOK = [UIButton buttonWithType:UIButtonTypeCustom];
        btnOK.frame = CGRectMake(20,60,CGRectGetWidth(self.view.frame)-40,35);;
        [btnOK setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnOK setTitle:@"确定" forState:UIControlStateNormal];
        UIImage* bgImg =
        [[UIImage imageNamed:@"myOrderBtn.png"] stretchableImageWithLeftCapWidth:20
                                                                    topCapHeight:20];
        [btnOK addTarget:self
                  action:@selector(onSelectOKAction:)
        forControlEvents:UIControlEventTouchUpInside];
        [btnOK setBackgroundImage:bgImg forState:UIControlStateNormal];
        [footView addSubview:btnOK];
    }
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cellid = @"recipientcellid";
    UITableViewCell* cell   = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellid];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        
        UIImageView* icon = [[UIImageView alloc] initWithFrame:CGRectMake((53-33)/2,(108-33)/2, 33, 33)];
        icon.tag          = 99;
        icon.backgroundColor = [UIColor clearColor];
        icon.userInteractionEnabled = NO;
        icon.image      = [UIImage imageNamed:@"kilometer_btn_normal.png"];
        [cell.contentView addSubview:icon];
        
        UIImageView* ContentView = [[UIImageView alloc] initWithFrame:CGRectMake(53,(108-92)/2,236, 92)];
        ContentView.tag   = 100;
        ContentView.image = [UIImage imageNamed:@"recipiencell_bg_s.png"];
        ContentView.userInteractionEnabled = NO;
        [[cell contentView] addSubview:ContentView];
        {
            UILabel* labLine1 = [[UILabel alloc] init];
            labLine1.tag   = 101;
            labLine1.backgroundColor = [UIColor clearColor];
            labLine1.font  = [UIFont systemFontOfSize:13];
            labLine1.frame = CGRectMake(10,10,CGRectGetWidth(ContentView.frame)-20,18);
            [ContentView addSubview:labLine1];
            
            UILabel* labLine2 = [[UILabel alloc] init];
            labLine2.tag   = 102;
            labLine2.backgroundColor = [UIColor clearColor];
            labLine2.numberOfLines = 2;
            labLine2.font  = [UIFont systemFontOfSize:13];
            labLine2.frame = CGRectMake(10,34,CGRectGetWidth(ContentView.frame)-20,36);
            [ContentView addSubview:labLine2];
        }
    }
    
    NSDictionary* dict   = [_recipienList objectAtIndex:[indexPath row]];
    UIImageView* icon    = (UIImageView*)[cell.contentView viewWithTag:99];
    UIImageView* cntview = (UIImageView*)[cell.contentView viewWithTag:100];
    UILabel* lab01 = (UILabel*)[cell.contentView viewWithTag:101];
    UILabel* lab02 = (UILabel*)[cell.contentView viewWithTag:102];
    
    lab01.text    = [dict objectForKey:@"UserName"];
    lab02.text    = [NSString stringWithFormat:@"%@  %@",[dict objectForKey:@"Address"],[dict objectForKey:@"PostCode"]];

    if ([indexPath row] == mSelIndex)
    {
        icon.image    = [UIImage imageNamed:@"kilometer_btn_selected.png"];
        cntview.image = [UIImage imageNamed:@"recipiencell_bg_s.png"];
    }else{
        icon.image    = [UIImage imageNamed:@"kilometer_btn_normal.png"];
        cntview.image = [UIImage imageNamed:@"recipiencell_bg_n.png"];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    mSelIndex = [indexPath row];
    [tableView reloadData];
}

//
-(void)OnEditBtnAdtion:(id)sender{
    UIView* editView = (UIView*)[self.view viewWithTag:kTagEditView];
    if (editView)
    {
        if (ifShowingEdit)
        {
            return;
        }else
        {
            if (isHiddenStatus)
            {
                if ([_recipienList count] <=0) {
                    return;
                }
                [UIView animateWithDuration:0.35
                                 animations:^(void){
                                     ifShowingEdit  = YES;
                                     NSLog(@"hidden=%@",NSStringFromCGRect(editView.frame));
                                     editView.frame = CGRectMake(editView.frame.origin.x,
                                                                 editView.frame.origin.y-editView.frame.size.height,
                                                                 editView.frame.size.width, editView.frame.size.height);
                                     
                                 }completion:^(BOOL finished){
                                     ifShowingEdit  = NO;
                                     isHiddenStatus = NO;
                                     [(UIButton*)sender setTitle:@"取消编辑"
                                                        forState:UIControlStateNormal];
                                     [(UIButton*)sender setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0,0)];
                                     NSLog(@"hidden finish=%@",NSStringFromCGRect(editView.frame));
                                 }];
            }else{
                [UIView animateWithDuration:0.35
                                 animations:^(void){
                                     NSLog(@"showing=%@",NSStringFromCGRect(editView.frame));
                                     ifShowingEdit  = YES;
                                     editView.frame = CGRectMake(editView.frame.origin.x,
                                                                 editView.frame.origin.y+editView.frame.size.height,
                                                                 editView.frame.size.width, editView.frame.size.height);
                                     
                                 }completion:^(BOOL finished){
                                     ifShowingEdit  = NO;
                                     isHiddenStatus = YES;
                                     NSLog(@"show finish=%@",NSStringFromCGRect(editView.frame));
                                     [(UIButton*)sender setTitle:@"编辑"
                                                        forState:UIControlStateNormal];
                                     [(UIButton*)sender setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0,-20)];
                                 }];
            }
        }
    }
}

-(void)OnAddRecipien:(id)sender
{
    CRecipientUpdateVctler *vc= [[CRecipientUpdateVctler alloc] init];
    vc.viewForType = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)OnModifyBtn:(id)sender{
    if (mSelIndex < 0 ||
        mSelIndex >= [_recipienList count])
    {
        return;
    }
    
    NSDictionary* selDict = [_recipienList objectAtIndex:mSelIndex];
    CRecipientUpdateVctler *vc= [[CRecipientUpdateVctler alloc] initWithViewForType:2 address:selDict];
    //vc.viewForType = 2;
    //vc.addessDict  = selDict;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)OnDeleteBtn:(id)sender
{
    if (mSelIndex < 0 ||
        mSelIndex >= [_recipienList count])
    {
        return;
    }
    
    SIAlertView *alertView =
    [[SIAlertView alloc] initWithTitle:nil
                            andMessage:@"确认删除收件人信息？"];
    
    [alertView addButtonWithTitle:@"取消"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView){
                          }];
    
    [alertView addButtonWithTitle:@"确定"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView){
                              NSDictionary* selDict = [_recipienList objectAtIndex:mSelIndex];
                              NSString* AddressId = [selDict objectForKey:@"AddressId"];
                              
                              NSString *UserId = [Global sharedInstance].custInfoDict[@"UserId"];
                              NSDictionary *params= [NSDictionary dictionaryWithObjectsAndKeys:
                                                     UserId,@"UserId",
                                                     AddressId,@"AddressId",
                                                     nil];
                              
                              self._delOperation =
                              [MyAppDelegate.cserviceEngine postXMLWithCode:@"delComConsigneeAddress"
                                                                     params:params
                                                                onSucceeded:^(NSDictionary *dict){
                                                                    [_recipienList removeObjectAtIndex:mSelIndex];
                                                                    mSelIndex = 0;
                                                                    [mTableView reloadData];
                                                                }onError:^(NSError*engineError){
                                                                    SIAlertView *alertView =
                                                                    [[SIAlertView alloc] initWithTitle:nil
                                                                                            andMessage:[engineError localizedDescription]];
                                                                    
                                                                    [alertView addButtonWithTitle:@"确定"
                                                                                             type:SIAlertViewButtonTypeDefault
                                                                                          handler:^(SIAlertView *alertView){
                                                                                          }];
                                                                    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                                                    [alertView show];
                                                                }];
                          }];
    
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
    
  
}

-(void)onSelectOKAction:(id)sender
{
    // added by zy, 2014-02-14
    if (mSelIndex < 0 || mSelIndex >= _recipienList.count)
    {
        return;
    }
    
    NSDictionary* selDict = [_recipienList objectAtIndex:mSelIndex];
    NSNotificationCenter* defaultcenter = [NSNotificationCenter defaultCenter];
    [defaultcenter postNotificationName:CTP_MSG_SELECT_RECIPIENT
                                 object:nil
                               userInfo:selDict];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - net works
-(void)getRecipienList
{
    NSString *UserId = [Global sharedInstance].custInfoDict[@"UserId"];
    NSDictionary *params= [NSDictionary dictionaryWithObjectsAndKeys:
                           UserId,@"UserId",nil];
    self._QryOperation   =
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"getConsigneeAddress"
                                           params:params
                                      onSucceeded:^(NSDictionary *dict) {
                                          DLog(@"***getConsigneeAddress\r\n%@",dict);
                                          [_recipienList removeAllObjects];
                                          
                                          id  dataList = dict[@"Data"][@"Items"][@"Item"];
                                          if ([dataList isKindOfClass:[NSDictionary class]])
                                          {
                                              [_recipienList addObject:dataList];
                                          }else if([dataList isKindOfClass:[NSArray class]]){
                                              [_recipienList addObjectsFromArray:dataList];
                                          }
                                          
                                          if (mSelIndex == -1)  // added by zy, 2014-02-19
                                          {
                                              int counter = 0;
                                              for (NSDictionary* ttd in _recipienList)
                                              {
                                                  if ([ttd[@"IfDefault"] integerValue] == 1)
                                                  {
                                                      mSelIndex = counter;
                                                      break;
                                                  }
                                                  counter ++;
                                              }
                                          }
                                          
                                          [mTableView reloadData];
                                      } onError:^(NSError *engineError) {
                                          DDLogInfo(@"%s--%@", __func__, engineError);
                                          
                                          SIAlertView *alertView =
                                          [[SIAlertView alloc] initWithTitle:nil
                                                                  andMessage:[engineError localizedDescription]];
                                          
                                          if ([engineError code] == -1009)
                                          {
                                              alertView.message = @"网络连接失败，请检查网络连接";
                                          }
                                          
                                          [alertView addButtonWithTitle:@"确定"
                                                                   type:SIAlertViewButtonTypeDefault
                                                                handler:^(SIAlertView *alertView){
                                                                }];
                                          alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                          [alertView show];
                                      }];

}

@end
