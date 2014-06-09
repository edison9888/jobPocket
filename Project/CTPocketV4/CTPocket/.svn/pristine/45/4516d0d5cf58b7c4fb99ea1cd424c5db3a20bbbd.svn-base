//
//  CTContractPhoneCell.h
//  CTPocketV4
//
//  Created by liuruxian on 13-11-19.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTContractPhoneCell;
@protocol showInfodelegate <NSObject>

@optional
-(void)showInfo:(CTContractPhoneCell *)cell;

@end

@interface CTContractPhoneCell : UITableViewCell

@property (nonatomic,assign) id        <showInfodelegate>delegate;
@property (nonatomic,assign) UIButton  *_contractBtn;
@property (nonatomic,assign) UILabel   *_totalPricelb;
@property (nonatomic,retain) UILabel   *_phonePricelb;
@property (nonatomic,assign) UILabel   *_storedMoneylb;
@property (nonatomic,assign) UIImageView *_contractImageView;
@property (nonatomic,assign) UILabel   *_contractlb;
@property (nonatomic,assign) NSDictionary *_contractInfoDic;
@property (nonatomic,assign)   NSString *_contractID;
-(void)setContractInfo:(NSArray *)dictionary;
-(void)setImage:(BOOL)status ;

@end
