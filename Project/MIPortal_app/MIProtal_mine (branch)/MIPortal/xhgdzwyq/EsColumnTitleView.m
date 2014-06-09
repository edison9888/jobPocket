//
//  EsColumnTitleView.m
//  xhgdzwyq
//
//  Created by apple on 13-11-29.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsColumnTitleView.h"
#import "EsNewsColumn.h"

@interface EsColumnTitleView()
{
    UIScrollView*   _contentScroll;
    UIImageView*    _indexView;
    
    NSArray*        _columnList;
}

@end

@implementation EsColumnTitleView

- (id)initWithFrame:(CGRect)frame columns:(NSArray* )columns
{
    _columnList = columns;
    frame.size.height = 44;
    frame.size.width = 320;
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        {
            UIScrollView* v = [[UIScrollView alloc] initWithFrame:CGRectInset(self.bounds, 40, 0)];
            v.backgroundColor = [UIColor clearColor];
            v.showsHorizontalScrollIndicator = NO;
            v.decelerationRate = 0;
            v.bounces = NO;
            v.clipsToBounds = NO;
            [self addSubview:v];
            _contentScroll = v;
            
            int originX = -30;
            for (EsNewsColumn* column in columns)
            {
                UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.tag = [columns indexOfObject:column];
                btn.frame = CGRectMake(originX, 0, 80, CGRectGetHeight(frame));
                [btn setTitleColor:RGB(0x78, 0x78, 0x78, 1) forState:UIControlStateNormal];
                [btn setTitleColor:RGB(255, 106, 40, 1) forState:UIControlStateSelected];
                [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
                [btn.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
                [btn addTarget:self action:@selector(onColumnBtn:) forControlEvents:UIControlEventTouchUpInside];
                [_contentScroll addSubview:btn];
                originX = CGRectGetMaxX(btn.frame);
                
                if (column.catalogName.length)
                {
                    [btn setTitle:column.catalogName forState:UIControlStateNormal];
                }
                if ([columns indexOfObject:column] == 0)
                {
                    btn.selected = YES;
                    UIImageView* iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[Global sharedSingleton].uiStyle.mode == UIStyleModeNight ? @"arrow_up_nightmode" : @"arrow_up"]];
                    iv.frame = CGRectMake(CGRectGetMinX(btn.frame) + (CGRectGetWidth(btn.frame) - CGRectGetWidth(iv.frame))/2,
                                          CGRectGetHeight(self.frame) - CGRectGetHeight(iv.frame) + 1,
                                          CGRectGetWidth(iv.frame),
                                          CGRectGetHeight(iv.frame));
                    [_contentScroll addSubview:iv];
                    _indexView = iv;
                }
            }
            [_contentScroll bringSubviewToFront:_indexView];
            _contentScroll.contentSize = CGSizeMake(originX, 0);
        }
        {
            UIImageView* iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_left"]];
            iv.frame = CGRectMake(0,
                                  (CGRectGetHeight(frame) - CGRectGetHeight(iv.frame))/2,
                                  CGRectGetWidth(iv.frame),
                                  CGRectGetHeight(iv.frame));
            [self addSubview:iv];
        }
        {
            UIImageView* iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_right"]];
            iv.frame = CGRectMake(CGRectGetWidth(frame) - CGRectGetWidth(iv.frame),
                                  (CGRectGetHeight(frame) - CGRectGetHeight(iv.frame))/2,
                                  CGRectGetWidth(iv.frame),
                                  CGRectGetHeight(iv.frame));
            [self addSubview:iv];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onUIChangeFinishNotification)
                                                     name:kMsgChangeUIFinish
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onUIChangeFinishNotification
{
    _indexView.image = [UIImage imageNamed:[Global sharedSingleton].uiStyle.mode == UIStyleModeNight ? @"arrow_up_nightmode" : @"arrow_up"];
}

- (void)onColumnBtn:(id)sender
{
    UIButton* selectedbtn = (UIButton* )sender;
    [self setSelectedIndex:selectedbtn.tag];
    
    if (self.columnBlock)
    {
        self.columnBlock(selectedbtn.tag);
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    [_contentScroll.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         if ([obj isKindOfClass:[UIButton class]])
         {
             UIButton* btn = ((UIButton* )obj);
             if (btn.tag != selectedIndex)
             {
                 btn.selected = NO;
             }
             else
             {
                 btn.selected = YES;
                 [_contentScroll setContentOffset:CGPointMake(MAX(CGRectGetMaxX(btn.frame) - CGRectGetWidth(_contentScroll.frame), 0), 0)
                                         animated:YES];
                 [UIView animateWithDuration:0.3 animations:^
                 {
                     _indexView.center = CGPointMake(btn.center.x, _indexView.center.y);
                 }];
             }
         }
     }];
}

@end
