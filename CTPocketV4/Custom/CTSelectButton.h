//
//  CTSelectButton.h
//  CTPocketV4
//
//  Created by Y W on 14-3-20.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CTSelectButtonSelectBlock)(id object);

@interface CTSelectButton : UIButton

@property (nonatomic, strong) id object;

@property (nonatomic, strong, readonly) UIImage *normalImage;
@property (nonatomic, strong, readonly) UIImage *selectImage;
- (void)buttonAction:(UIButton *)button;
- (id)initWithFrame:(CGRect)frame selectBlock:(CTSelectButtonSelectBlock)selectBlock;

@end
