//
//  CTNumberSelectedCell.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-3-25.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTPrettyNumData.h"

@class CTNumberSelectView;

typedef enum _ViewListCellType
{
    topListCellType = 0,
    bussinessCellType = 1,
    lovingCellType = 2,
    freeCellType = 3
}ViewListCellType;

typedef void(^CellSelectCityBlock)(CTPrettyNumData *prettyNumInfo);
typedef void(^CellCollectedBlock)(int collectIndex,BOOL collectedStatus);

static NSString *const kTopCellCityButtonCancelSelect = @"kTopCellCityButtonCancelSelect";
static NSString *const kBussinessCellCityButtonCancelSelect = @"kBussinessCellCityButtonCancelSelect";
static NSString *const kLovingCellCityButtonCancelSelect = @"kLovingCellCityButtonCancelSelect";
static NSString *const kFreeCellCityButtonCancelSelect = @"kFreeCellCityButtonCancelSelect";

@interface CTNumberSelectedCell : UITableViewCell

@property (nonatomic, strong) CTNumberSelectView *leftView;
@property (nonatomic, strong) CTNumberSelectView *rightView;
@property (nonatomic, assign) ViewListCellType viewListCellType ;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
   ViewListCellType:(ViewListCellType)listCellType;

- (void) reflesh;

@end

@interface CTNumberSelectView : UIView
@property (nonatomic, assign) int viewIndex;

- (id)initWithFrame:(CGRect)frame listCellType : (ViewListCellType )viewListCellType;
- (void)setPrettynumInfo:(CTPrettyNumData *)prettyNumInfo viewIndex: (int)index selectBlock:(CellSelectCityBlock)selectBlock;
- (void)setCollectedBlock :  (CellCollectedBlock)collectedBlock ;
- (void) setSelected : (BOOL) isSelected ;

@end