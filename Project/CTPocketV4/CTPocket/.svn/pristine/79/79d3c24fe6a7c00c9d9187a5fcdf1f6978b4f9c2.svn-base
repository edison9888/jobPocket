//
//  CTBdSalesPackageCell.h
//  CTPocketV4
//
//  Created by Y W on 14-3-21.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QryBdSalesComInfo.h"

#import "ThreeSubView.h"

typedef void(^CTBdSalesPackageCellWantGoDetailBlock)();

@class AutoScrollLabel;
@interface CTBdSalesPackageCell : UITableViewCell

+ (CGFloat)CellHeightWithPackageModel:(PackageModel *)packageModel;

@property (nonatomic, strong) PackageModel *packageModel;
@property (nonatomic, strong)AutoScrollLabel *autoLB ;

@property (nonatomic, readwrite, copy) CTBdSalesPackageCellWantGoDetailBlock goDetailBlock;

@end
