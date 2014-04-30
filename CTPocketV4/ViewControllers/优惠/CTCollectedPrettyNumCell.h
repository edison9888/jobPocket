//
//  CTCollectedPrettyNumCel.h
//  CTPocketV4
//
//  Created by liuruxian on 14-1-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTCollectedPrettyNumCell ;

@protocol CollectedPrettyNumCollectedDelegate <NSObject>

@optional

- (void)cancelCollected:(CTCollectedPrettyNumCell *)collectedCell;

@end

@interface CTCollectedPrettyNumCell : UITableViewCell

//- (void) setInfo : (NSDictionary *) dictionary cancelCollectedBlock : (CellCancelCollectBlocke) collectedBlock;
- (void) setInfo : (NSMutableDictionary *) dictionary ;
@property (nonatomic, assign) id<CollectedPrettyNumCollectedDelegate> delegate;
@property (nonatomic, strong) NSDictionary *infoDict;

@end
