//
//  EsColumnTitleView.h
//  xhgdzwyq
//
//  Created by apple on 13-11-29.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ columnSelectedBlock) (NSInteger idx);

@interface EsColumnTitleView : UIView

@property (nonatomic, copy) columnSelectedBlock columnBlock;
@property (nonatomic, assign) NSInteger selectedIndex;

- (id)initWithFrame:(CGRect)frame columns:(NSArray* )columns;

@end
