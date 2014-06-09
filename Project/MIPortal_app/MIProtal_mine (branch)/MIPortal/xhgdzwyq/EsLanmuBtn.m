//
//  EsLanmuBtn.m
//  xhgdzwyq
//  栏目块
//  Created by 温斯嘉 on 13-11-7.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import "EsLanmuBtn.h"

@implementation EsLanmuBtn

- (id)initWithMainFrame:(CGRect)mainFrame withMainBgImage:(UIImage *)mainBgImg withTitle:(NSString *)title withTitleBgImg:(UIImage *)titleBgImg atIndex:(NSInteger)aIndex
{
    self = [super initWithFrame:mainFrame];
    
    if (self) {
//        self.bgImg = mainBgImg;
        self.titleText = title;
        self.index = aIndex;
        
        //显示风格
        self.backgroundColor = [UIColor redColor];
        //背景图片
        self.mainBgImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.mainBgImgView.image = mainBgImg;
        [self addSubview:self.mainBgImgView];
        //标题背景
        self.titleBgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.size.height-LANMU_TITLEBG_HEIGHT, self.bounds.size.width, LANMU_TITLEBG_HEIGHT)];
        self.titleBgImgView.image = titleBgImg;
        [self addSubview:self.titleBgImgView];
        
        //栏目标题文字
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x+LANMU_TITLEINSET_LEFT, self.bounds.size.height-LANMU_TITLEINSET_BOTTOM-LANMU_TITLE_HEGHT, self.bounds.size.width-LANMU_TITLEINSET_LEFT*2, LANMU_TITLE_HEGHT)];
        self.titleLable.backgroundColor = [UIColor clearColor];
        self.titleLable.textColor = [UIColor whiteColor];
        self.titleLable.text = title;
        [self addSubview:self.titleLable];
        
        //采用叠加按钮的方式捕捉点击事件
        self.mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mainBtn setFrame:self.bounds];
        [self.mainBtn setBackgroundColor:[UIColor clearColor]];
        [self.mainBtn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.mainBtn];
        
    }
    return self;
}

#pragma mark - action

- (void) clickItem:(id)sender {
    [self.delegate lanmuDidTapped:self];
}

@end
