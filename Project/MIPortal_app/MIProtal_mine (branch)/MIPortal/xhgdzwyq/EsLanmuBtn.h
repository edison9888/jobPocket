//
//  EsLanmuBtn.h
//  xhgdzwyq
//  栏目块
//  负责实现栏目块的指定设计风格并显示
//  栏目信息（背景，文字）、栏目块位置、大小、顺序由外部指定
//  Created by 温斯嘉 on 13-11-7.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LANMU_TITLEBG_HEIGHT 40
#define LANMU_TITLEINSET_LEFT 10
#define LANMU_TITLEINSET_BOTTOM 5
#define LANMU_TITLE_HEGHT   20

@protocol EsLanmuBtnDelegate;

@interface EsLanmuBtn : UIView
@property (nonatomic, strong) UIImage *bgImg;
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, weak) id <EsLanmuBtnDelegate> delegate;
@property (nonatomic) NSInteger index;

//主背景图片框
@property (nonatomic, strong) UIImageView *mainBgImgView;
//标题背景图片框
@property (nonatomic, strong) UIImageView *titleBgImgView;
//标题文字
@property (nonatomic, strong) UILabel *titleLable;
//主体按钮
@property (nonatomic, strong) UIButton *mainBtn;

- (id)initWithMainFrame:(CGRect)mainFrame withMainBgImage:(UIImage *)mainBgImg withTitle:(NSString *)title withTitleBgImg:(UIImage *)titleBgImg atIndex:(NSInteger)aIndex;

@end


@protocol EsLanmuBtnDelegate <NSObject>

- (void)lanmuDidTapped:(EsLanmuBtn *)lanmuBtn;

@end

