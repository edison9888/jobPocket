//
//  EsColumnImageView.m
//  xhgdzwyq
//
//  Created by apple on 13-11-29.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsColumnImageView.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"

@implementation EsColumnImageView

- (id)initWithFrame:(CGRect)frame
         columnInfo:(EsNewsColumn* )columnInfo
         isHeadLine:(BOOL)isHeadLine
         completion:(void(^)(EsColumnImageView *sender))completion
{
    frame.size.width = (isHeadLine ? 248 : 120);
    frame.size.height = 120;
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = RGB(120, 120, 120, 1);
        if (columnInfo.catalogPicUrl.length)
        {
            [self setBackgroundImageWithURL:[NSURL URLWithString:columnInfo.catalogPicUrl]
                                   forState:UIControlStateNormal
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType)
            {
                if (completion)
                {
                    completion(nil);
                }
            }];
        }
        
        {
            //UIImage* img = [UIImage imageNamed:(isHeadLine ? @"top_black_long" : @"top_black_short")]; //首页列表图片黑色阴影
            UIImage* img = [UIImage imageNamed:(isHeadLine ? @"" : @"")];
            UIButton* textbtn = [UIButton buttonWithType:UIButtonTypeCustom];
            textbtn.backgroundColor = [UIColor clearColor];
            textbtn.frame = CGRectMake(0,
                                       CGRectGetHeight(self.frame) - img.size.height,
                                       CGRectGetWidth(self.frame),
                                       img.size.height);
            [textbtn setBackgroundImage:img forState:UIControlStateNormal];
            [textbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [textbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            textbtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            textbtn.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
            textbtn.userInteractionEnabled = NO;
            [self addSubview:textbtn];
            
            if (columnInfo.catalogName.length)
            {
                [textbtn setTitle:columnInfo.catalogName forState:UIControlStateNormal];
            }
            
            if (isHeadLine)
            {
                [textbtn setTitleEdgeInsets:UIEdgeInsetsMake(10, 25, 10, 10)];
                
                UIImageView* iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"color_scanning_headlines"]];
                iv.frame = CGRectMake(10,
                                      CGRectGetHeight(textbtn.frame) - 10 - CGRectGetHeight(iv.frame),
                                      CGRectGetWidth(iv.frame),
                                      CGRectGetHeight(iv.frame));
                [textbtn addSubview:iv];
            }
            else
            {
                [textbtn setTitleEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
            }
        }
    }
    
    return self;
}

@end
