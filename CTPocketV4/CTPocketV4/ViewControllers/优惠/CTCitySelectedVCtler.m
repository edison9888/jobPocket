//
//  CTCitySelectedVCtler.m
//  CTPocketV4
//
//  Created by liuruxian on 14-1-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTCitySelectedVCtler.h"
#import "UIView+RoundRect.h"
#import "CTQryCity.h"
#import "CTQryCity_Model.h" 
#import "CTHelperMap.h"
#import "HeaderView.h"
#import "CTSelectedCityViewCell.h"

typedef enum _TableViewSearchType
{
    TableViewSearchTypeNormal = 0,
    TableViewSearchTypeSearch
}TableViewSearchType;


@interface CTCitySelectedVCtler ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UILocalizedIndexedCollation *collation;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, assign) TableViewSearchType tableViewSearchType;
@property (nonatomic, strong) NSMutableArray *searchArray;
@end

@implementation CTCitySelectedVCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.cityArray = [NSMutableArray array];
        self.sectionArray = [NSMutableArray array];
        self.searchArray  = [NSMutableArray array];
        self.tableViewSearchType = TableViewSearchTypeNormal ;
        self.pageType = 0;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"选择所在地区";
    [self setLeftButton:[UIImage imageNamed:@"btn_back.png"]];
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1];
    
    UIView *divideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
    divideView.backgroundColor = [UIColor colorWithRed:213/255. green:213/255. blue:213/255. alpha:1];
    [self.view addSubview:divideView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 49)];
    headerView.backgroundColor = [UIColor clearColor];
    
    
    UIImage *image = [UIImage imageNamed:@"prettyNum_searchBar_bg.png"];
    CGRect rect = CGRectMake(24,
                             6,
                             200,
                             38);
    
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    textField.delegate = (id<UITextFieldDelegate>)self;
    textField.backgroundColor = [UIColor clearColor];
    textField.borderStyle = UITextBorderStyleNone;
    textField.background = image ;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:14];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeySearch;
    textField.enablesReturnKeyAutomatically = YES;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    [textField dwMakeRoundCornerWithRadius:5];
    
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
    
    textField.placeholder = @"  请输入搜索的城市名称";
    [headerView addSubview:textField];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setBackgroundImage:[UIImage imageNamed:@"prettyNum_belongs_btn.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(CGRectGetMaxX(textField.frame)+3,
                              6,
                              47,
                              38);
    [headerView addSubview:button];
    self.searchTextField = textField;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(6, 0, self.view.frame.size.width-6, self.view.bounds.size.height)];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    tableView.delegate = (id<UITableViewDelegate>) self;
    tableView.dataSource = (id<UITableViewDataSource>) self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
   
    
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    
    if (version >= 7.0f) {
        
        tableView.sectionIndexColor = [UIColor colorWithRed:191/255. green:191/255. blue:191/255. alpha:1];
        tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    } 
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    self.tableView.tableHeaderView = headerView ;
    
    //加载得view
    UIView *loadingView = [[UIView alloc] initWithFrame:self.view.bounds];
    loadingView.backgroundColor = [UIColor colorWithRed:213/255. green:213/255. blue:213/255. alpha:1];
    [self.view addSubview:loadingView];
    {
        UIActivityIndicatorView *spin = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spin setFrame:CGRectMake((CGRectGetWidth(loadingView.frame)-15)/2 - 20,(CGRectGetHeight(loadingView.frame)-20)/2-50, 15, 20)];
        [spin startAnimating];
        [loadingView addSubview:spin];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(spin.frame)+5, (CGRectGetHeight(loadingView.frame)-16)/2 - 50, 100, 16)];
        label.text = @"加载中...";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:14];
        [loadingView addSubview:label];
    }
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        [[CTQryCity shareQryCity] qryCityFinishBlock:^(CTQryCity_Model *model,NSError *error)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 // 更新界面
                 [self.cityArray setArray:model.citysArray];
                 [self configureSection];
                 [self.tableView reloadData];
                 loadingView.hidden = YES ;
             });
         }];
 
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) configureSection {
    //初始化
    self.collation = [UILocalizedIndexedCollation currentCollation];//作为集合类出现
    int index=0 , sectionTitleCounts = [[self.collation sectionTitles] count];
    [self.sectionArray removeAllObjects];

    //初始化27个对象
    for (int i=0; i<sectionTitleCounts; i++) {
        NSMutableArray *array = [NSMutableArray array];
        [self.sectionArray addObject:array];
    }
    
    //归类各个对象在section的位置
    for (CTCity *city in self.cityArray) {
        NSInteger sectionIndex = [self.collation sectionForObject:city collationStringSelector:@selector(citynameAlph)];
        NSMutableArray *sectionCitys = [self.sectionArray objectAtIndex:sectionIndex];
        [sectionCitys addObject:city];
    }
    
    //排序sectionarray
    for (index=0; index<sectionTitleCounts; index++) {
        NSMutableArray *cityAryForSection = [self.sectionArray objectAtIndex:index];
        //排序
        NSArray *array = [self.collation sortedArrayFromArray:cityAryForSection collationStringSelector:@selector(citynameAlph)];
        //取代当前的对象
        [self.sectionArray replaceObjectAtIndex:index withObject:array];
    }
    
    //热门城市
    CTCity *city1 = [CTCity modelObjectWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       @"8110100",@"citycode",
                                                       @"609001",@"provincecode",
                                                       @"北京",@"cityname",
                                                       @"北京",@"provincename",
                                                       @"",@"hbcitycode",
                                                       @"",@"hbprovincecode",
                                                       @"BJ",@"citynameAlph",
                                                       nil]];
    
    CTCity *city2 = [CTCity modelObjectWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       @"8440100",@"citycode",
                                                       @"600101",@"provincecode",
                                                       @"广州",@"cityname",
                                                       @"广州",@"provincename",
                                                       @"",@"hbcitycode",
                                                       @"",@"hbprovincecode",
                                                       @"GZ",@"citynameAlph",
                                                       nil]];
    
    CTCity *city3 = [CTCity modelObjectWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       @"8310100",@"citycode",
                                                       @"600102",@"provincecode",
                                                       @"上海",@"cityname",
                                                       @"上海",@"provincename",
                                                       @"",@"hbcitycode",
                                                       @"",@"hbprovincecode",
                                                       @"SH",@"citynameAlph",
                                                       nil]];
    
    CTCity *city4 = [CTCity modelObjectWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       @"8440300",@"citycode",
                                                       @"600101",@"provincecode",
                                                       @"深圳",@"cityname",
                                                       @"深圳",@"provincename",
                                                       @"",@"hbcitycode",
                                                       @"",@"hbprovincecode",
                                                       @"SZ",@"citynameAlph",
                                                       nil]];
    
    CTCity *city5 = [CTCity modelObjectWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       @"8330100",@"citycode",
                                                       @"600104",@"provincecode",
                                                       @"杭州",@"cityname",
                                                       @"杭州",@"provincename",
                                                       @"",@"hbcitycode",
                                                       @"",@"hbprovincecode",
                                                       @"HZ",@"citynameAlph",
                                                       nil]];
    
    CTCity *city6 = [CTCity modelObjectWithDictionary:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       @"8320100",@"citycode",
                                                       @"600103",@"provincecode",
                                                       @"南京",@"cityname",
                                                       @"南京",@"provincename",
                                                       @"",@"hbcitycode",
                                                       @"",@"hbprovincecode",
                                                       @"NJ",@"citynameAlph",
                                                       nil]];
    
    NSMutableArray *hotCityArray = [NSMutableArray arrayWithObjects:city1,city2,city3,city4,city5,city6,nil];
    [self.sectionArray insertObject:hotCityArray atIndex:0];

    //定位城市
    CTCity *city7 = [CTHelperMap shareHelperMap].areaInfo;
    
    NSMutableArray *locateCity = [NSMutableArray arrayWithObject:city7];
    [self.sectionArray insertObject:locateCity atIndex:0];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

#pragma mark - Action

- (void) searchAction
{
    [self.searchTextField resignFirstResponder];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.tableViewSearchType = TableViewSearchTypeSearch ;
    [self filterContentForSearchText:self.searchTextField.text];
    [self.tableView reloadData];
}

- (void) cancelSearchAction
{
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone ;
    self.searchTextField.text = @"";
     self.tableViewSearchType = TableViewSearchTypeNormal ;
    [self.tableView reloadData];
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    if(!self.searchArray)
    {
        return ;
    }
    
    [self.searchArray removeAllObjects];
    //匹配号百城市编码
     NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"(SELF.cityname contains[cd] %@) OR (SELF.citynameAlph contains[cd] %@)",searchText,searchText];
     NSPredicate *tempPre = resultPredicate;
     
     id filteredArray = [self.cityArray filteredArrayUsingPredicate:tempPre];
     if (filteredArray && [filteredArray isKindOfClass:[NSArray class]])
     {
        [self.searchArray addObjectsFromArray:filteredArray];
     } else if ([filteredArray isKindOfClass:[CTCity class]]) {
         [self.searchArray addObject:filteredArray];
     }
}

#pragma mark - UITableView delegate 
//Cell 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 37;
}
//section 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.tableViewSearchType == TableViewSearchTypeNormal)
    {
        return 37 ;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.tableViewSearchType == TableViewSearchTypeNormal) {
        HeaderView *view = [[HeaderView alloc] initWithFrame:CGRectZero] ;
        if (section == 0) {
            [view setTitle:@"定位城市"];
        } else if(section == 1) {
            [view setTitle:@"热门城市"];
        } else {
            [view setTitle:[self.collation sectionTitles][section-2]];
        }
        return view;
    } else {
        return nil ;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = indexPath.section ;
    int row = indexPath.row;
    
    if(self.pageType == 0)
    {
        if(self.tableViewSearchType == TableViewSearchTypeNormal){
            // 发送更新通知消息
            [[NSNotificationCenter defaultCenter] postNotificationName:SELECTCITY_MSG object:self.sectionArray[section][row]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:SELECTCITY_MSG object:self.searchArray[row]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        if(self.tableViewSearchType == TableViewSearchTypeNormal)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShakeChangeCity" object:self.sectionArray[section][row]];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShakeChangeCity" object:self.searchArray[row]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - UITableView datasource
//返回索引的section值
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (self.tableViewSearchType == TableViewSearchTypeNormal) {
        if (title == UITableViewIndexSearch) {
            [tableView setContentOffset:CGPointZero animated:YES];
            return NSNotFound;
        } else {
            return index+2;
        }
    }
    else {
        return 1;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;
{
    if (self.tableViewSearchType == TableViewSearchTypeNormal) {
        NSMutableArray *titleArray = [NSMutableArray arrayWithArray:[self.collation sectionIndexTitles]];
        if (titleArray.count>0) {
            [titleArray removeObjectAtIndex:titleArray.count-1];
            return titleArray;
        }
        else{
            return nil ;
        }
    } else {
        return nil ;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableViewSearchType == TableViewSearchTypeNormal) {
        return [self.sectionArray[section] count];
    } else {
       return  [self.searchArray count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableViewSearchType == TableViewSearchTypeNormal) {
        static NSString *identify = @"cell";
        CTSelectedCityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell==nil) {
            cell = [[CTSelectedCityViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            cell.backgroundColor = [UIColor colorWithRed:239/255. green:239/255. blue:239/255. alpha:1];
        }
        NSMutableArray *array = [self.sectionArray objectAtIndex:indexPath.section];
        CTCity *city = [array objectAtIndex:indexPath.row];
        NSString *cityName = [NSString stringWithFormat:@"%@",city.cityname];
        if ([cityName hasSuffix:@"市"]) {
            cityName = [cityName substringToIndex:cityName.length-1];
        }
        [cell setTitle:cityName];
        
        return cell;
    } else {
        static NSString *identify = @"searchCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            cell.backgroundColor = [UIColor clearColor];
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        CTCity *city = [self.searchArray objectAtIndex:indexPath.row];
        NSString *cityname = city.cityname ;
        if ([cityname hasSuffix:@"市"]) {
            cityname = [cityname substringToIndex:cityname.length-1];
        }
        cell.textLabel.text = cityname ;
      
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    if (self.tableViewSearchType == TableViewSearchTypeNormal) {
        return [self.sectionArray count];
    } else {
        return 1;
    }
}

#pragma mark - UITextFiledDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:0.3
                     animations:^(void){
                         __strong __typeof(&*weakSelf)strongSelf = weakSelf;
                         if (!strongSelf) {
                             return;
                         }
                     }completion:^(BOOL finish){
                         __strong __typeof(&*weakSelf)strongSelf = weakSelf;
                         if (!strongSelf) {
                             return;
                         }
                         
                     }];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    self.tableViewSearchType = TableViewSearchTypeSearch ;
    [self.tableView reloadData];
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length == 0) {
        return NO ;
    }
    
    [self searchAction];
    
    return YES;
}



@end
