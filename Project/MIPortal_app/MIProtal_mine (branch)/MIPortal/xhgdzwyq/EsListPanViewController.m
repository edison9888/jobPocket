//
//  EsListPanViewController.m
//  xhgdzwyq
//
//  Created by Eshore on 13-11-13.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsListPanViewController.h"
#import "EsNewsTableViewController.h"
#import "EsNewsListCtrl.h"


@interface EsListPanViewController ()

- (void)initScrollView;

@end

@implementation EsListPanViewController

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
    // Do any additional setup after loading the view from its nib.
    self.view.frame = self.listPanFrame;
    [self initScrollView];
    self.newsLists = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (void) setScrollviewContent:(NSInteger)pageNum curPage:(NSInteger)pageIndex
{
#warning wensj 暂时这样： + 5*(pageNum-1) ,滑起来有点怪，每次都要往右滑一点再滑回来
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * pageNum + 5*(pageNum-1), self.scrollView.bounds.size.height);
//    //让列表页面先去获取新闻
    
    //设置要展示的每一页
    [self createAllEmptyPagesForScrollView: pageNum];
    
    //显示pageIndex+1页
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width * pageIndex + 5*pageIndex, 0)];
    
    //获取新闻
    EsNewsListCtrl *newsListCtrl = [[EsNewsListCtrl alloc] init];
    NSArray *arrAdd = [newsListCtrl getNewsList:self.scrollView.bounds.size.height/NTABEL_HEIGHT_NORMAL];
    BOOL bFind = NO;
    for (id obj in self.newsLists) {
//        NSDictionary *d ;
        if (nil != [obj valueForKey:[NSString stringWithFormat:@"%d", pageIndex ]]) {
            [[obj valueForKey:[NSString stringWithFormat:@"%d", pageIndex ]] addObjectsFromArray:arrAdd];
            bFind = YES;
            break;
        }
    }
    if (!bFind) {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:[NSMutableArray arrayWithArray:arrAdd] forKey:[NSString stringWithFormat:@"%d", pageIndex ]];
        NSLog(@"%@", [[arrAdd objectAtIndex:2] titleText]);
        
        [self.newsLists addObject:dic];
    }

    
}

#pragma mark - inner func
- (void)initScrollView
{
    //配置scrollView属性
    self.scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//    NSLog(@"scrollview rect: (%f,%f,%f,%f)", self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.clipsToBounds = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
}

- (void)createAllEmptyPagesForScrollView:(NSInteger)pages
{
    if (pages < 0) {
        //err log
        return;
    }
        
    CGRect frame = self.scrollView.bounds;
//    UIImageView *imgView;
    //栏目不会很多，每个栏目列表用一个ctrl来控制
    if (nil == self.newsListCtrls) {
        self.newsListCtrls = [[NSMutableDictionary alloc] init];
    }
    for (NSInteger page = 0; page < pages; page++)
    {
        EsNewsTableViewController *tbvCtrl = [self.newsListCtrls objectForKey:@(page)];
        if (nil == tbvCtrl) {
            tbvCtrl = [[EsNewsTableViewController alloc] init];
            [self.newsListCtrls setObject:tbvCtrl forKey:@(page)];
            [tbvCtrl setCategoryID:@(page)];
            tbvCtrl.cprtDelegate = self.cprtDelegate;
        }
        //
        [tbvCtrl prepareNewsList];
        UITableView *tableTst = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width * page + 5*page, 0, frame.size.width, frame.size.height)];
        
        tableTst.delegate = tbvCtrl;
        tableTst.dataSource = tbvCtrl;
        [self.scrollView addSubview:tableTst];
        
#if 0   //for test
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * page, frame.origin.y, frame.size.width, frame.size.height)];
 
        UIImage *img = [UIImage imageNamed:@"morenlanmu.jpg"];
        imgView.image = img;
        [self.scrollView addSubview:imgView];
#endif

    }
}

#pragma mark - callback

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
//    CGFloat pageWidth = self.scrollView.bounds.size.width;
//    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
//    if (page < 0){
//        return;
//    }
//    if (page >= PAGECOUNT)
//    {
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//        [self.view removeFromSuperview];
//        return;
//    }
//    pageControl.currentPage = page;
//    int page = scrollView.contentOffset.x
    int page = floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width) + 1;//scrollView.contentOffset.x/scrollView.frame.size.width;
    [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width * page + 5*page, 0)];
    [self.delegate categoryDidChanged:page];
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    int page = floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width) + 1;//scrollView.contentOffset.x/scrollView.frame.size.width;
//    [self.delegate categoryDidChanged:page];
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.contentView.backgroundColor = [UIColor yellowColor];
    }
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.frame.origin.x + 60, cell.contentView.frame.origin.y + 10, 200, 40)];
//    NSLog(@"%@", [[arrAdd objectAtIndex:2] titleText]);
//    NSLog(@"%@", [[self.newsLists objectAtIndex:0] objectForKey:[NSString stringWithFormat:@"%d", 0]]);
    titleLabel.text = [[[[self.newsLists objectAtIndex:0] objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]] objectAtIndex:0] titleText];
//    cell.textLabel.text = @"xx";
    [cell.contentView addSubview:titleLabel];
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return NTABEL_HEIGHT_IMG;
    }
    else {
        return NTABEL_HEIGHT_NORMAL;
    }
}

@end
