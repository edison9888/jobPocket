//
//  BBCenterManager.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  中间的视图的逻辑管理

#import "BBCenterViewManager.h"
#import "BBCenterItem.h"

#import "BBCenterRepDataModel.h"
#import "BBCenterItemDataModel.h"

@interface BBCenterViewManager ()<UITableViewDataSource,UITableViewDelegate>
{
    UINib *nib;
} 
@property (assign,nonatomic) BBCenterViewType type;
@property (strong,nonatomic) NSMutableArray   *datas;
@property (assign,nonatomic) int              PageIndex;
@property (assign,nonatomic) int              PageSize;
@end
@implementation BBCenterViewManager
-(instancetype)init
{
    self=[super init];
    if (self) {
        NSLog(@"%s",__func__);
    }
    return self;
}
#pragma mark - method

-(void)updateWithType:(BBCenterViewType)type
{
    self.type=type;
    switch (self.type)
    {
        case BBC_NONE:
            self.tableView.hidden=YES;
            self.noDataView.hidden=YES;
            break;
        case BBC_HasData:
            self.tableView.hidden=NO;
            self.noDataView.hidden=YES;
            break;
        case BBC_NoData:
            self.tableView.hidden=YES;
            self.noDataView.hidden=NO;
            break;
        default:
            break;
    }
    
}
#pragma mark 返回当前是什么界面
-(UIView*)updateView
{
    return nil;
}
-(void)updateWithData:(BBCenterRepDataModel*)repData
{
    if (repData) {
        
    }
    else
    {
        [self updateWithType:BBC_NONE];
    }
 
}
#pragma mark - UITableViewDataSource
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier=@"Identifier";
    if (nib==nil)
    {
        nib=[UINib nibWithNibName:@"BBCenterItem" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:Identifier];
    }
    BBCenterItem *item=[tableView dequeueReusableCellWithIdentifier:Identifier];
    BBCenterItemDataModel *model=[self.datas objectAtIndex:indexPath.row];
    item.name.text=model.ComName;
    item.region.text=model.ComAddress;
    
    return item;
}

@end
