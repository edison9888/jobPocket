//
//  OptPackageView.m
//  CTPocketV4
//
//  Created by 许忠洲 on 14-1-20.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "OptPackageView.h"
#import "SVProgressHUD.h"

#define kBtnTag 1000
#define kLabelTag 1200
@interface OptPackageView ()
@property (strong, nonatomic) UILabel *OptName;
@property (strong, nonatomic) UIButton *arrowDown;
@property (strong, nonatomic) UIButton *arrowUp;
@property (strong, nonatomic) UIImageView *sepatator;
@property (nonatomic) int maxValueAddedServiceCount;
@property (nonatomic, strong) UIImageView *arrowBg;
@property (nonatomic, strong) UILabel *presentLab;
@property (nonatomic, strong) NSDictionary *infoDcit;

@property (nonatomic, strong) NSMutableArray *array ;

@end

@implementation OptPackageView

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [[NSMutableArray alloc] init];
    }
    return _btns;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        
        self.OptName = [[UILabel alloc] initWithFrame:CGRectMake(5, 12, 208, 16)];
        self.OptName.backgroundColor = [UIColor clearColor];
        self.OptName.font = [UIFont systemFontOfSize:15.0f];
        self.OptName.textColor = [UIColor blackColor];
        [self addSubview:self.OptName];
        
        self.arrowDown = [UIButton buttonWithType:UIButtonTypeCustom];
        self.arrowDown.frame = CGRectMake(0, 5, 280, 30);
        [self.arrowDown setBackgroundImage:[UIImage imageNamed:@"LeXiangPackage_arrow_down@2x"] forState:UIControlStateNormal];
        [self.arrowDown addTarget:self
                           action:@selector(showAllContent)
                 forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.arrowDown];
        
        UILabel *present = [[UILabel alloc] initWithFrame:CGRectMake(5, 42, 232, 16)];
        present.backgroundColor = [UIColor clearColor];
        present.font = [UIFont systemFontOfSize:13.0f];
        present.textColor = [UIColor blackColor];
        present.text = @"赠送业务：来电显示；189邮箱 ( 2G )";
        [self addSubview:present];
        self.presentLab = present;
        
        self.sepatator = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1)];
        self.sepatator.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        self.sepatator.image = [UIImage imageNamed:@"LeXiangPackage_Separator.png"];
        [self addSubview:self.sepatator];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 65, 235, 8)];
        imageView.image = [UIImage imageNamed:@"LeXiangPackage_arrow_up@2x"];
        [self addSubview:imageView];
        imageView.hidden = YES;
        self.arrowBg = imageView ;
        
        self.arrowUp = [UIButton buttonWithType:UIButtonTypeCustom];
        self.arrowUp.frame = CGRectMake(13, 62, 235, 25);
        [self.arrowUp addTarget:self
                         action:@selector(hideSomeContent)
               forControlEvents:UIControlEventTouchUpInside];
        self.arrowUp.hidden = YES;
        [self addSubview:self.arrowUp];
    }
    return self;
}

- (void)setContent:(NSDictionary *)OptionalPackage
{
    CGRect rect = self.frame;
    rect.size.width = 280;
    rect.size.height = 72;
    self.frame = rect;
    
    self.infoDcit = OptionalPackage ;
    self.maxValueAddedServiceCount = [OptionalPackage[@"MaxValueAddedServiceCount"] intValue] ? [OptionalPackage[@"MaxValueAddedServiceCount"] intValue] : 0;
    //免费增值业务：n个（m选n）”，m是包总数，n是可选个数
//    NSString *optName = OptionalPackage[@"OptName"] ? OptionalPackage[@"OptName"] : @"";
    int TotalValueAddedServiceCount = [OptionalPackage[@"TotalValueAddedServiceCount"] intValue] ? [OptionalPackage[@"TotalValueAddedServiceCount"] intValue] : 0;
    self.OptName.text = [NSString stringWithFormat:@"免费增值业务:%d个(%d选%d)",self.maxValueAddedServiceCount,TotalValueAddedServiceCount,self.maxValueAddedServiceCount];//optName
    self.OptName.numberOfLines = 0;
    [self.OptName sizeToFit];
    
    if ([OptionalPackage[@"Services"][@"Item"] count] > 0) {
        
        //add by liuruxian 2014-02-25
        self.array = [NSMutableArray array];
        
        int x = 14;
        int y = 42;
        int tag = 0;
        for (NSDictionary *dict in OptionalPackage[@"Services"][@"Item"]) {
            if (x >= 254) {
                x = 14;
                y = y + 34 + 8;
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(x, y, 74, 34);
            btn.hidden = YES ;
            [btn setBackgroundImage:[UIImage imageNamed:@"LeXiangPackage_Service@2x"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"WriteOrderInfo_btn_selected@2x"] forState:UIControlStateSelected];
            {
                UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, btn.bounds.size.width-12, btn.bounds.size.height)];
                title.backgroundColor = [UIColor clearColor];
                title.font = [UIFont systemFontOfSize:13.0f];
                title.textColor = [UIColor blackColor];
                title.textAlignment = UITextAlignmentCenter;
                title.numberOfLines = 2;
                title.text = dict[@"Name"];
                title.tag = kLabelTag ;
                [btn addSubview:title];
            }
            btn.tag = kBtnTag + tag;
            [btn addTarget:self action:@selector(onOptPackageAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [self.btns addObject:btn];
            if (tag < self.maxValueAddedServiceCount) {
                btn.selected = YES ;
            }
            tag++;
            x = x + 74 + 6;
        }
    }
    
    //add by liuruxian 2014-02-25
    [self setPresentInfo];
    rect.size.height = CGRectGetMaxY(self.presentLab.frame) + 16;
    self.frame = rect ;
    self.sepatator.frame = CGRectMake(0,self.bounds.size.height-1, self.bounds.size.width, 1);
}

//add by liuruxian 2014-02-25
- (void) setPresentInfo
{
    NSString *text = @"增值业务 : ";
    if (self.infoDcit) {
        for (int i=0; i<self.btns.count; i++) {
            UIButton *btn = (UIButton *)[self viewWithTag:i+kBtnTag];
            if (btn.selected) {
                UILabel *label = (UILabel *)[[self.btns objectAtIndex:i] viewWithTag:kLabelTag];
                text = [text stringByAppendingString:[NSString stringWithFormat:@"%@;",label.text]];
            }
        }
    }
    
    self.presentLab.text = text ;
    self.presentLab.numberOfLines = 0;
    [self.presentLab sizeToFit];
    self.presentLab.frame = CGRectMake(self.presentLab.frame.origin.x,
                                       self.presentLab.frame.origin.y,
                                       232, self.presentLab.frame.size.height);
}

- (void)showAllContent
{
    self.arrowDown.hidden = YES;
    
    int h = [self.btns count] / 3;
    if ([self.btns count] % 3 > 0) {
        h++;
    }
    
    self.arrowUp.hidden = NO;
    self.arrowBg.hidden = NO;
    
    //add by liuruxian 2014-02-25
    self.presentLab.hidden = YES;
    if (self.btns && self.btns.count > 0) {
        for (int i=0; i<self.btns.count; i++) {
            UIButton *btn = [self.btns objectAtIndex:i];
            btn.hidden = NO;
        }
    }
 
    CGRect arrowRect = self.arrowUp.frame;
    arrowRect.origin.y = 42 + h * 42;
    self.arrowUp.frame = arrowRect;
    
    arrowRect = self.arrowBg.frame;
    arrowRect.origin.y = self.arrowUp.frame.origin.y + 3;
    self.arrowBg.frame = arrowRect ;
    
    CGRect rect = self.frame;
    rect.size.height = 42 + h * 42 + self.arrowUp.frame.size.height - 8 ;
    self.frame = rect;
    
    self.sepatator.frame = CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1);
    
    if ([self.delegate respondsToSelector:@selector(resetOptContent)]) {
        [self.delegate resetOptContent];
    }
}

- (void)hideSomeContent
{
    self.arrowDown.hidden = NO;
    self.arrowUp.hidden = YES;
    
    //add by liuruxian 2014-02-25
    self.presentLab.hidden = NO;
    if (self.btns && self.btns.count > 0) {
        for (int i=0; i<self.btns.count; i++) {
            UIButton *btn = [self.btns objectAtIndex:i];
            btn.hidden = YES;
        }
    }
    
    CGRect rect = self.frame;
    rect.size.height = self.presentLab.frame.origin.y + CGRectGetHeight(self.presentLab.frame) + 14;
    self.frame = rect;
    
    self.sepatator.frame = CGRectMake(0, self.bounds.size.height-1, self.bounds.size.width, 1);
    
    if ([self.delegate respondsToSelector:@selector(resetOptContent)]) {
        [self.delegate resetOptContent];
    }
}

- (void)onOptPackageAction:(UIButton *)btn
{
    if (btn.selected == YES) {
        btn.selected = NO;
    }
    else {
        int selectedCount = 0;
        for (UIButton *button in self.btns) {
            if (button.selected == YES) {
                selectedCount++;
            }
        }
        if (selectedCount >= self.maxValueAddedServiceCount) {
            // 提示
            [SVProgressHUD showErrorWithStatus:self.OptName.text];
        }
        else {
            btn.selected = YES;
        }
    }
    [self setPresentInfo];
}

@end
