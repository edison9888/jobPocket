//
//  CTPrettyNumViewCell.m
//  CTPocketV4
//
//  Created by liuruxian on 14-1-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTPrettyNumViewCell.h"
#import "TTTAttributedLabel.h"
#import <QuartzCore/QuartzCore.h>
#import "CTQryCollected.h"
#import "ToastAlertView.h"
#import "SIAlertView.h"

#define kselectedBtnTag 1000
#define kcollectionBtnTag 1100

@interface CTPrettyNumViewCell()


@property (nonatomic, strong) UIImageView *roundImageView;
@property (nonatomic, assign) ViewListCellType viewListCellType;

@end

@implementation CTPrettyNumViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ViewListCellType:(ViewListCellType)listCellType
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.viewListCellType = listCellType ;
        
        CTPrettyNumView *firstView = [[CTPrettyNumView alloc]initWithFrame:CGRectMake(0, 0, 158, 62)
                                                              listCellType:listCellType];
        firstView.backgroundColor = [UIColor clearColor];
        self.leftView = firstView;
        [self addSubview:firstView];
        
        CTPrettyNumView *secondView = [[CTPrettyNumView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(firstView.frame),
                                                                                       0,
                                                                                       158,
                                                                                       62)
                                                            listCellType:listCellType];
        secondView.backgroundColor = [UIColor clearColor];
        self.rightView = secondView ;
        [self addSubview:secondView];
        
    }
    
    return self;
}

#pragma mark - fun

- (void) reflesh
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

@interface CTPrettyNumView () <TTTAttributedLabelDelegate>
{
    
}

@property (nonatomic ,strong) UIView *view ;
@property (nonatomic, strong) TTTAttributedLabel *phoneNumLable;
@property (nonatomic, strong) UILabel *detailInfoLable;
@property (nonatomic, copy)   CellSelectCityBlock prettyNumBlock ;
@property (nonatomic, copy)   CellCollectedBlock collectBlock;
@property (nonatomic, strong) CTPrettyNumData *data;
@property (nonatomic, assign) ViewListCellType viewListCellType;
@property (nonatomic, strong) UIImageView *markImageView;
@property (nonatomic, strong) UIImageView *collectionView;
@property (nonatomic, strong) UILabel *markLabel;
@property (nonatomic,strong)  UIImageView *bgImageView;

//分割线


@end

@implementation CTPrettyNumView

- (id)initWithFrame:(CGRect)frame listCellType : (ViewListCellType)viewListCellType
{
   self = [super initWithFrame:frame];
    if (self) {
        self.viewListCellType = viewListCellType ;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                0,
                                                                158,
                                                                62)];
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
    
         self.view = view;
        {
            
            UIImageView *round = [[UIImageView alloc]initWithFrame:
                                  CGRectMake(6,
                                             (CGRectGetHeight(view.frame)-22)/2,
                                             22,
                                             22)];

            round.layer.cornerRadius = 11;
            round.autoresizingMask = UIViewContentModeScaleAspectFit ;
            self.markImageView = round ;
            
            [self.view addSubview:round];
            {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
                label.backgroundColor = [UIColor clearColor];
 
                label.textAlignment = UITextAlignmentCenter ;
                label.font = [UIFont systemFontOfSize:9];
                label.textColor = [UIColor whiteColor];
                label.tag = 0;
                self.markLabel = label ;
                [round addSubview:label];
            }
            
            self.phoneNumLable.delegate = self;
            self.phoneNumLable = [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(round.frame)+6, 13, 100, 16)];
            self.phoneNumLable.font = [UIFont systemFontOfSize:14];
            self.phoneNumLable.textColor = [UIColor blackColor];
            self.phoneNumLable.lineBreakMode = UILineBreakModeWordWrap;
            self.phoneNumLable.backgroundColor = [UIColor clearColor];
            self.phoneNumLable.numberOfLines = 0;
            self.phoneNumLable.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCTUnderlineStyleAttributeName];
            self.phoneNumLable.highlightedTextColor = [UIColor blackColor];
            self.phoneNumLable.shadowColor = [UIColor colorWithWhite:0.87f alpha:1.0f];
            self.phoneNumLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
            self.phoneNumLable.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
            
            //选择显示不同位置的字体颜色
            [self.view addSubview:self.phoneNumLable];

            NSMutableAttributedString * tttstring = [[NSMutableAttributedString alloc] initWithString:@" "];
            UIFont *italicSystemFont = [UIFont systemFontOfSize:14];
            CTFontRef italicFont = CTFontCreateWithName((CFStringRef)italicSystemFont.fontName, italicSystemFont.pointSize, NULL);
            if(italicFont){
                
                [tttstring addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor colorWithRed:255/255. green:93/255. blue:65/255. alpha:1] CGColor] range:NSMakeRange(0,[tttstring length])];
                [tttstring addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(italicFont) range:NSMakeRange(0,[tttstring length])];
            }
            
            [self.phoneNumLable setText:tttstring];
            
            UILabel *label2 = [[UILabel alloc]initWithFrame:
                               CGRectMake(CGRectGetMaxX(round.frame)+5,
                                          CGRectGetMaxY(self.phoneNumLable.frame)+8,
                                          100,
                                          14)];
            label2.backgroundColor = [UIColor clearColor];
            label2.textColor = [UIColor blackColor];
            label2.font = [UIFont systemFontOfSize:14];
            label2.text = @"";
            label2.textAlignment = UITextAlignmentCenter ;
            self.detailInfoLable = label2 ;
            [self.view addSubview:label2];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(self.view.bounds.origin.x, 0, CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame));
            button.backgroundColor = [UIColor clearColor];
            [button setBackgroundImage:[UIImage imageNamed:@"prettyNum_numberSel_btn.png"] forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"prettyNum_numberUnsel_btn.png"] forState:UIControlStateSelected];
            button.tag = kselectedBtnTag ;
            button.selected = NO;
            [button addTarget:self action:@selector(selectedAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
            
            //收藏按钮
            UIButton *collectBtn = [UIButton buttonWithType: UIButtonTypeCustom];
            collectBtn.backgroundColor = [UIColor clearColor];
            collectBtn.frame = CGRectMake(CGRectGetWidth(self.view.frame)-27,
                                          (CGRectGetHeight(self.view.frame)-30)/2+3,
                                          27,
                                          30);
            collectBtn.selected = NO;
            collectBtn.tag = kcollectionBtnTag ;
            [collectBtn setImage:[UIImage imageNamed:@"prettyNum_collection_unselected.png"] forState:UIControlStateNormal];
            [collectBtn setImage:[UIImage imageNamed:@"prettyNum_collection_selected.png"] forState:UIControlStateSelected];
            [collectBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:collectBtn];
        }
        
        //加入监听
        if (self.viewListCellType == topListCellType) {
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(allCellViewCancelSelected:)
                                                        name:kTopCellCityButtonCancelSelect
                                                      object:nil];
        }else if(self.viewListCellType == bussinessCellType)
        {
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(allCellViewCancelSelected:)
                                                        name:kBussinessCellCityButtonCancelSelect
                                                      object:nil];
        }else if(self.viewListCellType == lovingCellType)
        {
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(allCellViewCancelSelected:)
                                                        name:kLovingCellCityButtonCancelSelect
                                                      object:nil];
        }
        else if(self.viewListCellType == freeCellType)
        {
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(allCellViewCancelSelected:)
                                                        name:kFreeCellCityButtonCancelSelect
                                                      object:nil];
        }
    }
    return  self;
}

#pragma mark - NSNotification

- (void) allCellViewCancelSelected : (NSNotification *)notification
{
    if (self == [notification object]) {
        return;
    }
    //不是同一个按钮的情况下 判断是否为选中状态  假如不是选中状态则不用管  要是选中状态置位为未选中
    [self selectedView];
}

#pragma mark - fun

- (void)selectedView
{
    UIButton *button = (UIButton *)[self.view viewWithTag:kselectedBtnTag];
    if (button.selected == YES) {
        button.selected = NO;
    }
}

//设置选中
- (void) setSelected : (BOOL) isSelected
{
    UIButton *button = (UIButton *)[self.view viewWithTag:kselectedBtnTag];
    if (isSelected) {
        button.selected = YES;
    }else{
        button.selected = NO;
    }
}

- (void) relesh
{
   {
        if (self.data == nil) {
            self.view.hidden = YES;
            return ;
        }
        
        self.view.hidden = NO;
        
        self.phoneNumLable.text = self.data.PhoneNumber == nil?@"":self.data.PhoneNumber ;
        self.detailInfoLable.text = self.data.PrepayMent == nil?@"":[NSString stringWithFormat:@"预存:%@元",self.data.PrepayMent];
        int endPos = [self.data.HlEnd intValue];
        int startPos = [self.data.HlStart intValue];
        NSString *phoneNum = self.data.PhoneNumber == nil ? @"":self.data.PhoneNumber;
        NSMutableAttributedString * tttstring = [[NSMutableAttributedString alloc] initWithString:phoneNum];
        NSMutableAttributedString *insertStr =  [[NSMutableAttributedString alloc]initWithString:@" "];

        if (endPos>0) {
            NSRange range = NSMakeRange(startPos, endPos-startPos);
           
            UIFont *italicSystemFont = [UIFont systemFontOfSize:14];
            CTFontRef italicFont = CTFontCreateWithName((CFStringRef)italicSystemFont.fontName, italicSystemFont.pointSize, NULL);
            if(italicFont){
                [tttstring addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor colorWithRed:255/255. green:93/255. blue:65/255. alpha:1] CGColor] range:range];
                [tttstring addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(italicFont) range:NSMakeRange(0, self.data.PhoneNumber.length)];
                [tttstring insertAttributedString:insertStr atIndex:3];
                [tttstring insertAttributedString:insertStr atIndex:8];
            }
        }
        else{
            UIFont *italicSystemFont = [UIFont systemFontOfSize:14];
            CTFontRef italicFont = CTFontCreateWithName((CFStringRef)italicSystemFont.fontName, italicSystemFont.pointSize, NULL);
            if(italicFont){
                [tttstring addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(italicFont) range:NSMakeRange(0, self.data.PhoneNumber.length)];
                [tttstring insertAttributedString:insertStr atIndex:3];
                [tttstring insertAttributedString:insertStr atIndex:8];
            }
        }
       
        [self.phoneNumLable setText:tttstring];
        UIButton *button = (UIButton *)[self.view viewWithTag:kcollectionBtnTag];
        if ([self.data.isCollected integerValue]==0) {
            //不收藏
            button.selected = NO;
        }else{
            button.selected = YES;
        }

        switch ([self.data.TypeId intValue]) {
           case 0:
               self.markImageView.backgroundColor = [UIColor clearColor];
               self.markImageView.image = [UIImage imageNamed:@"prettyNum_other_icon@2x"];
               self.markLabel.text = @"";
               break;
           case 1:
               self.markImageView.backgroundColor = [UIColor colorWithRed:244/255. green:146/255. blue:68/255. alpha:1];
               self.markLabel.text = @"顶级";
               self.markImageView.image = nil;
               break;
           case 2:
               self.markImageView.backgroundColor = [UIColor colorWithRed:225/255. green:136/255. blue:171/255. alpha:1];
               self.markLabel.text = @"爱情";
               self.markImageView.image = nil;
               break;
           case 3:
               self.markImageView.backgroundColor = [UIColor colorWithRed:247/255. green:133/255. blue:114/255. alpha:1];
               self.markLabel.text = @"事业";
               self.markImageView.image = nil;
               break;
           case 4:
               self.markImageView.backgroundColor = [UIColor colorWithRed:111/255. green:197/255. blue:55/255. alpha:1];
               self.markLabel.text = @"0元";
               self.markImageView.image = nil;
               break;
        }
        }
}

- (void)setPrettynumInfo:(CTPrettyNumData *)prettyNumInfo viewIndex : (int) index selectBlock:(CellSelectCityBlock)selectBlock 
{
    self.data = prettyNumInfo ;
    self.prettyNumBlock = selectBlock ;
    self.viewIndex = index ;
    [self relesh];
}

- (void)setCollectedBlock : (CellCollectedBlock)collectedBlock
{
    self.collectBlock = collectedBlock ;
}

#pragma mark - Action

- (void)collectionAction
{
    /*
     
        需求变更 收藏按钮不再使用
     
    */
    UIButton *button = (UIButton *)[self.view viewWithTag:kcollectionBtnTag];
    if (button.selected) {
        button.selected = NO;
        //发送取消收藏消息
        self.collectBlock(self.viewIndex,button.selected);
    } else {
        if ([CTQryCollected shareQryCollected].collectedMutableDict.count >= 10) {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                             andMessage:@"亲，临时收藏夹已经满了，不能再多了，嗝..."];
            [alertView addButtonWithTitle:@"取消"
                                     type:SIAlertViewButtonTypeDefault
                                  handler:^(SIAlertView *alertView) {
                                  }];
            [alertView addButtonWithTitle:@"去挑挑看"
                                     type:SIAlertViewButtonTypeDefault
                                  handler:^(SIAlertView *alertView) {
                                      //发送消息跳转
                                      [[NSNotificationCenter defaultCenter] postNotificationName:@"JUMPTOCOLLECTED" object:nil];
                                  }];
            alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
            [alertView show];

            return ;
        }
        button.selected = YES;
        //发送收藏消息
        self.collectBlock(self.viewIndex,button.selected);
    }
}

- (void) selectedAction
{
    //选中
    if (self.viewListCellType == topListCellType) {
        [[NSNotificationCenter defaultCenter]postNotificationName:kTopCellCityButtonCancelSelect object:self];
        self.prettyNumBlock(self.data);
    }else if(self.viewListCellType == bussinessCellType)
    {
       [[NSNotificationCenter defaultCenter]postNotificationName:kBussinessCellCityButtonCancelSelect object:self];
        self.prettyNumBlock(self.data);
    }else if(self.viewListCellType == lovingCellType)
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:kLovingCellCityButtonCancelSelect object:self];
        self.prettyNumBlock(self.data);
    }
    else if(self.viewListCellType == freeCellType)
    {
       [[NSNotificationCenter defaultCenter]postNotificationName:kFreeCellCityButtonCancelSelect object:self];
        self.prettyNumBlock(self.data);
    }
    
    UIButton *button = (UIButton *)[self.view viewWithTag:kselectedBtnTag];
    button.selected = YES ;
    [self setSelected:YES];
    
//  收藏按钮
    UIButton *collectBtn = (UIButton *)[self.view viewWithTag:kcollectionBtnTag];
    if ([CTQryCollected shareQryCollected].collectedMutableDict.count >= 10) {
        return ;
    }
    if (!collectBtn.selected) {
        collectBtn.selected = YES;
        //发送收藏消息
        self.collectBlock(self.viewIndex,button.selected);
    }
    
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end