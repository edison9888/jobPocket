//
//  EsColumnImageView.h
//  xhgdzwyq
//
//  Created by apple on 13-11-29.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EsNewsColumn.h"

@interface EsColumnImageView : UIButton

- (id)initWithFrame:(CGRect)frame
         columnInfo:(EsNewsColumn* )columnInfo
         isHeadLine:(BOOL)isHeadLine
         completion:(void(^)(EsColumnImageView *sender))completion;

@end
