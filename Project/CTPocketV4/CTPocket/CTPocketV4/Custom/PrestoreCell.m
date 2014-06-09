//
//  PrestoreCell.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-4-10.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "PrestoreCell.h"
#import "QryBdSalesComInfo.h"
#import "SIAlertView.h"
#import "UIColor+Category.h"

@interface PrestoreCell  ()
{
    UIButton *selectedBtn;
}
@property(nonatomic,strong)NSMutableArray *btns;
@end
@implementation PrestoreCell

+(CGFloat)cellHeightWithDatas:(NSArray *)datas
{
    CGFloat cellHeight=1;
    NSArray *configItems=datas;
    int counts=[configItems count];
    NSMutableArray *btns=[NSMutableArray array];
    if (counts > 0)
    {
        // 显示预存话费可选项
        BOOL isSelected = NO;
        int tag = 0;
        for (YckModel *dict in configItems) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            if ((dict.Default) &&
                (isSelected == NO)) {
                btn.selected = YES;
                isSelected = YES;
            }
            btn.tag = tag;
            [btns addObject:btn];
            tag++;
        }
        
     
        cellHeight =20+((counts+1)/2)*30;
        
        // 促销政策
        int t = -1;
        for (UIButton *btn in btns)
        {
            if (btn.selected == YES) {
                t = btn.tag;
                break;
            }
        }
        if (t != -1) { 
            YckModel *dict=configItems[t];
            if (dict.Prestore.Tip &&
                (![dict.Prestore.Tip isEqual:@"null"]))
            {
                cellHeight = cellHeight + 30 + 8;
            }
            else
            {
                cellHeight+=8;
            }
            
        }
    }
    
    return cellHeight;
}

- (void)config
{
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // Initialization code
    /***/
    // 处理预存话费可选项
    _btns=[NSMutableArray array];
    // 处理预存话费可选项
    NSArray *configItems = _datas;
    
    if ([configItems count] > 0) {
        
        // 显示预存话费可选项
        CGFloat originY =  15;
        
        // 号码预存
        UILabel *mLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, originY, 38, 32)];
        mLabel.backgroundColor = [UIColor clearColor];
        mLabel.numberOfLines = 2;
        mLabel.textColor = [UIColor colorWithR:49 G:49 B:49 A:1];
        mLabel.text = @"预存\n话费";
        mLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:mLabel];
        
        // !
        UIImage *image = [UIImage imageNamed:@"WriteOrderInfo_icon1@2x"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(260, originY-4, 20, 20)];
        imageView.image = image;
        [self.contentView addSubview:imageView];
        
        UIButton *tBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tBtn.frame = CGRectMake(260, originY-13, 30, 30);
        //        tBtn.backgroundColor = [UIColor clearColor];
        //        [tBtn setBackgroundImage:[UIImage imageNamed:@"WriteOrderInfo_icon1@2x"] forState:UIControlStateNormal];
        [tBtn addTarget:self
                 action:@selector(onTipAction)
       forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:tBtn];
        
        // arrow
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(300, originY+12, 8, 14)];
        arrow.image = [UIImage imageNamed:@"WriteOrderInfo_icon2@2x"];
        [self.contentView addSubview:arrow];
        
        // 点击查看提示
        UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(231, originY + 20, 70, 12)];// originY + 15 + 5
        tLabel.backgroundColor = [UIColor clearColor];
        tLabel.font = [UIFont boldSystemFontOfSize:11.0f];
        tLabel.textColor = [UIColor grayColor];
        tLabel.text = @"点击查看提示";
        [self.contentView addSubview:tLabel];
        
        UILabel *itemTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, originY, 160, 15)];
        itemTitle.backgroundColor = [UIColor clearColor];
        itemTitle.font = [UIFont boldSystemFontOfSize:14.0f];
        itemTitle.textColor = [UIColor blackColor];
        itemTitle.text = @"选择号码激活预存话费";
//        [self.contentView addSubview:itemTitle];
        originY = originY;
        
        int originX = 45;
        BOOL isSelected = NO;
        int tag = 0;
        
        for (YckModel *dict in configItems)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(originX, originY, 82, 30);
            [btn setBackgroundImage:[UIImage imageNamed:@"WriteOrderInfo_btn"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"WriteOrderInfo_btn_selected"] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:0.43 green:0.77 blue:0.21 alpha:1] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
            [btn setTitle:dict.Prestore.Name forState:UIControlStateNormal];
            if ((dict.Default) &&
                (isSelected == NO)) {
                btn.selected = YES;
                isSelected = YES;
                selectedBtn=btn;
            }
            [btn addTarget:self
                    action:@selector(onPrestoreBtnAction:)
          forControlEvents:UIControlEventTouchUpInside];
            btn.tag = tag;
            [self.contentView addSubview:btn];
            [self.btns addObject:btn];
            if (originX == 45) {
                originX = 45+80+10;
            }
            else {
                originX = 45;
                originY = originY + 30 + 10;
            }
            tag++;
        }
        int itemCount= [configItems count];
        originY = 20+((itemCount+1)/2)*30;
//        if (originX == 190) {
//            + 34 + 8;
//        }
        
        // 促销政策
        int t = -1;
        for (UIButton *btn in self.btns) {
            if (btn.selected == YES) {
                t = btn.tag;
                break;
            }
        }
        if (t != -1) {
            //15 + 15 + 18;34 8;30 8
            YckModel *dict=configItems[t];
            NSString *tipStr = @"";
            if (dict.Prestore.Tip &&
                (![dict.Prestore.Tip isEqual:@"null"])) {
                self.tip = [[UILabel alloc] initWithFrame:CGRectMake(45, originY, 260, 30)];
                self.tip.backgroundColor = [UIColor clearColor];
                self.tip.font = [UIFont systemFontOfSize:14.0f];
                self.tip.textColor = [UIColor colorWithRed:0.93 green:0.36 blue:0.25 alpha:1];
                self.tip.numberOfLines = 2;
                tipStr =dict.Prestore.Tip;
                self.tip.text = [NSString stringWithFormat:@"促销政策：%@", tipStr];
                [self.contentView addSubview:self.tip];
                originY = originY + 30 + 8;
            }
            
            else {
                //                tipStr = @"无";
                originY+=8;
            }
            
        }
        else {
            //            self.tip.text = @"促销政策：无";
        }
        
//        UIImageView *sepatator2 = [[UIImageView alloc] initWithFrame:CGRectMake(22, originY, 280, 1)];
//        sepatator2.image = [UIImage imageNamed:@"LeXiangPackage_Separator.png"];
//        [self.contentView addSubview:sepatator2];
    }
    
    
}

- (void)onPrestoreBtnAction:(UIButton *)btn
{
    for (UIButton *tBtn in self.btns) {
        if ([tBtn isEqual:btn]) {
            BOOL isSelected=btn.selected;
            BOOL invalidSelected=!((selectedBtn==nil&&isSelected)||selectedBtn==btn);
            if (invalidSelected)
            {
                if (!isSelected) {
                    selectedBtn=btn;
                    btn.selected = !isSelected;
                }
            }
            
            YckModel *yckModel =self.datas[btn.tag];
            
            if (btn.selected == YES) {
                 yckModel.Default=YES;
                NSString *tipStr = @"";
                if (yckModel.Prestore.Tip &&
                    (![yckModel.Prestore.Tip isEqual:@"null"])) {
                    tipStr = yckModel.Prestore.Tip;
                }
                else {
                    tipStr = @"无";
                }
                self.tip.text = [NSString stringWithFormat:@"促销政策：%@", tipStr];
            }else
            {
                yckModel.Default=NO;
            }
        }
        else {
            tBtn.selected = NO;
            YckModel *yckModel =self.datas[btn.tag];
            yckModel.Default=NO;
        }
    }
}
- (void)onTipAction
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"重要提示"
                                                     andMessage:@"为保证您的号码能正常激活使用，需要您预存部分话费。\n话费预存部分请到当地电信话费营业厅按月索取发票。"];
    [alertView addButtonWithTitle:@"知道了"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              //
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
}

@end
