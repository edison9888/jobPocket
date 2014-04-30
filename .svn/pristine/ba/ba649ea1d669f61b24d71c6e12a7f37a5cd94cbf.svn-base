//
//  OptPackageView.h
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-20.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OptPackageViewDelegate <NSObject>
@optional
- (void)resetOptContent;
@end

@interface OptPackageView : UIView
@property (nonatomic, weak) id<OptPackageViewDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *btns;
- (void)setContent:(NSDictionary *)OptionalPackage;
@end
