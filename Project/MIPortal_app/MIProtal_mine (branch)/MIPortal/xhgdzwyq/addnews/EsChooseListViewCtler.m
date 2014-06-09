/*--------------------------------------------
 *Name：EsChooseListViewCtler.h
 *Desc：随手拍，发布新闻的时候，选择分享到哪些项目的页面
 *Date：2014/05/23
 *Auth：hehx
 *--------------------------------------------*/

#import "EsChooseListViewCtler.h"
#import "EsNewsColumn.h"
#import "EsChooseCell.h"

#define kCellHeight 60
@interface EsChooseListViewCtler ()
{
    UITableView     *_tableView;
    NSMutableArray  *_dataList;
    NSMutableArray  *_chooseList;
    NSMutableArray  *_btns;
    EsChooseCell    *_allBtn;
}
@end

@implementation EsChooseListViewCtler

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
    self.title = @"选择可见范围";
    [self setBackButton];
    [self setRightButtonWidthTitle:@"确定"];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = (id<UITableViewDelegate>)self;
    tableView.dataSource = (id<UITableViewDataSource>)self;
    [self.view addSubview:tableView];
    //获取数据
    _dataList = [NSMutableArray array];
    [_dataList addObjectsFromArray:[Global sharedSingleton].columns];
    _tableView = tableView;
    _btns = [[NSMutableArray alloc] initWithCapacity:_dataList.count];
    
    _chooseList = [[NSMutableArray alloc]init];
    NSString *idString = [Global sharedSingleton].parentModes;
    
    //判断项目组选中
    if (idString != nil) {
        NSArray *idArray = [idString componentsSeparatedByString:@","];
        for (EsNewsColumn *new in _dataList) {
            NSString *str = [NSString stringWithFormat:@"%@", new.catalogId];
            for (NSString *idstr in idArray) {
                if ([str isEqualToString:idstr]) {
                    [_chooseList addObject:new];
                }
            }
        }
    }
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //判断项目组选中
    for (EsChooseCell *cell in _btns) {
        for (EsNewsColumn *new in _chooseList) {
            if ([cell.title isEqualToString:new.catalogName]) {
                [cell setIsSelected:YES];
            }
        }
    }
    if (_btns.count == _chooseList.count) {
        [_allBtn setIsSelected:YES];
    }
}

-(void)onRightBtnAction:(id)sender
{
    NSMutableString *strData = [[NSMutableString alloc]init];
    NSMutableString *arrData = [[NSMutableString alloc]init];
    int i = 0;
    if ([_chooseList count]) {
        for (EsNewsColumn *new in _chooseList) {
            if(i > 0)
            {
                [strData appendString:@","];
                [arrData appendString:@","];
            }
            [strData appendFormat:@"%@",new.catalogId];
            [arrData appendFormat:@"%@", new.catalogName];
            i++;
            CLog(@"new id is %@",new.catalogId);
        }
        [Global sharedSingleton].parentModes = strData;
        [Global sharedSingleton].chooseModes = arrData;
        if (_chooseList.count == _btns.count) {
            [Global sharedSingleton].chooseModes = @"全部";
        }
    }
    else
    {
        [Global sharedSingleton].parentModes = nil;
        [Global sharedSingleton].chooseModes = @"只限项目组";
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

#pragma mark - tableview datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identity = @"cell";
    EsChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell = [[EsChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity height:kCellHeight];
    }
    //设置数据
    switch (indexPath.section) {
        case 0:
            cell.title = @"全选";
            _allBtn = cell;
            break;
        case 1:
        {
            EsNewsColumn *news = [_dataList objectAtIndex:indexPath.row];
            cell.title = news.catalogName;
            cell.indexPath = indexPath;
            [_btns insertObject:cell atIndex:indexPath.row];
        }
            break;
        default:
            break;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.delegate = (id<clickDeledate>)self;
    
    return cell;
}

#pragma mark - 业务处理
-(void)clickBtn:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected
{
    if (indexPath.section == 0)
    {   //全选中/全不选中
        [self chooseAll:isSelected];
        if (isSelected) {
            [_chooseList addObjectsFromArray:_dataList];
        }else
        {
            [_chooseList removeAllObjects];
        }
    }
    else
    {
        if (!isSelected)
        {
            //一个不选中，全选肯定不中
            [_allBtn setIsSelected:NO];
        }else
        {
            BOOL all = YES;
            for (EsChooseCell *cell in _btns) {
                if (!cell.isSelected) {
                    all = NO;
                }
            }
            if (all) {
                [_allBtn setIsSelected:YES];
            }
        }
        
        if (isSelected)
        {
            //添加一个
            [_chooseList addObject:[_dataList objectAtIndex:indexPath.row]];
        }else
        {
            //移除
            for (EsNewsColumn *news in _chooseList) {
                if (news.catalogId == ((EsNewsColumn *)[_dataList objectAtIndex:indexPath.row]).catalogId) {
                    [_chooseList removeObject:news];
                    break;
                }
            }
        }
    }
    //添加一个数组处理数据
}

#pragma mark - 全选中或者全不选中
-(void)chooseAll:(BOOL)selected
{
    for (EsChooseCell *cell in _btns) {
        [cell setIsSelected:selected];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _dataList.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
