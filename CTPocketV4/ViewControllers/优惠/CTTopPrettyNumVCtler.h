//
//  CTTopPrettyNumVCtler.h
//  CTPocketV4
//
//  Created by liuruxian on 14-1-7.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTBaseViewController.h"
#import "CTCity.h"
#import "CTPrettyNumData.h"

typedef enum _qryTopNumType
{
    normalModel = 0,
    SearchModel
} qryTopNumType;

@interface CTTopPrettyNumVCtler : CTBaseViewController

@property (nonatomic, strong) CTPrettyNumData * selectedData;
- (void)qryNumByCnl : (NSString *) searchText;
//- (void) createView ;
@property (nonatomic, strong) CTCity *areaInfo;
- (void) location;

@end
