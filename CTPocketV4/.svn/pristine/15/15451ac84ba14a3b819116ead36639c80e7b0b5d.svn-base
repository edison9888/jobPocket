//
//  CTSimpleInfoView.h
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-11.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CTSimpleInfoViewDelegate <NSObject>
@optional
- (void)didSelectFlowButton;
@end

@interface CTSimpleInfoView : UIView
{
    UILabel *_titleLabel;
    UIView *_usedFlowImage;
    UILabel *_flowLabel;
    UILabel *_benYueHuaFeiLabel;
    UILabel *_dangQianYuELabel;
}
@property (weak, nonatomic) id<CTSimpleInfoViewDelegate> delegate;

- (void)setUserName:(NSString *)userName;
- (void)setUsedFlow:(CGFloat)usedFlow allFlow:(CGFloat)allFlow;
- (void)setBenYueHuaFei:(NSString *)benYueHuaFei;
- (void)setDangQianYuE:(NSString *)dangQianYuE;

@end
