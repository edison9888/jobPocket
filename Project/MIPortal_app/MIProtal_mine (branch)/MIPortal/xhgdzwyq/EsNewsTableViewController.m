//
//  EsNewsTableViewController.m
//  xhgdzwyq
//
//  Created by Eshore on 13-11-17.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsNewsTableViewController.h"
#import "EsNewsListCtrl.h"
#import "EsNewsDetailViewController.h"


@interface EsNewsTableViewController ()

@end

@implementation EsNewsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.newslistCtrl = [[EsNewsListCtrl alloc] init];
        self.newsData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    }
    
    // Configure the cell...
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.frame.origin.x + 60, cell.contentView.frame.origin.y + 10, 200, 40)];
    titleLabel.text = [[self.newsData objectAtIndex:indexPath.row] titleText];//[[[[self.newsLists objectAtIndex:0] objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]] objectAtIndex:0] titleText];
    //    cell.textLabel.text = @"xx";
    [cell.contentView addSubview:titleLabel];
    
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

//
- (void)prepareNewsList
{
    //获取新闻
    NSArray *arrAdd = [self.newslistCtrl getNewsList:8];
    [self.newsData addObjectsFromArray:arrAdd];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
//    if (nil == self.newsDetailViewCtrl)
    {
        self.newsDetailViewCtrl = [EsNewsDetailViewController new];//[[EsNewsDetailViewController alloc] initWithNibName:@"EsNewsDetailViewController" bundle:[NSBundle mainBundle]];   // modified by zy, 2013-11-24
        self.newsDetailViewCtrl.cprtDelegate = self.cprtDelegate;
//        self.newsDetailViewCtrl.newsList = self.newsData;                    // added by zy, 2013-11-26
        self.newsDetailViewCtrl.selectIdx = indexPath.row;                   // added by zy, 2013-11-26
    }
    
    [self.cprtDelegate pushViewCtrl:self.newsDetailViewCtrl currentViewCtrl:self];
    
}

@end
