//
//  PropertiesView.h
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-20.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PropertiesViewDelegate <NSObject>
@optional
- (void)resetPropertiesContent;
@end

@interface PropertiesView : UIView
@property (nonatomic, weak) id<PropertiesViewDelegate> delegate;
- (void)setContent:(NSDictionary *)Properties;
@end
