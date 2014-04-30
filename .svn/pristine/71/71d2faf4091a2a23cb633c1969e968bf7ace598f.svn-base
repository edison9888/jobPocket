//
//  CTCollectedPrettyNumCel.m
//  CTPocketV4
//
//  Created by liuruxian on 14-1-12.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTCollectedPrettyNumCell.h"
#import "TTTAttributedLabel.h"

#define kcollectionBtnTag 1000

@interface CTCollectedPrettyNumCell () <TTTAttributedLabelDelegate>

@property (nonatomic, strong) TTTAttributedLabel *phoneNumLable;
@property (nonatomic, strong) UILabel *saveLabel;
@property (nonatomic, strong) UILabel *areaLabel ;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIButton *collectedBtn;
@property (nonatomic, strong) UIImageView *roundImageView;
@property (nonatomic, strong) UILabel *typeLabel;

@end


@implementation CTCollectedPrettyNumCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImageView *round = [[UIImageView alloc]initWithFrame:
                              CGRectMake(self.bounds.origin.x,
                                         (54-22)/2,
                                         22,
                                         22)];
        round.backgroundColor = [UIColor clearColor];
        round.layer.cornerRadius = 11;
        self.roundImageView = round ;
        [self addSubview:round];
        {
            UILabel *label = [[UILabel alloc]initWithFrame:round.bounds];
            label.backgroundColor = [UIColor clearColor];
            label.text = @"";
            label.textAlignment = UITextAlignmentCenter ;
            label.font = [UIFont systemFontOfSize:9];
            label.textColor = [UIColor whiteColor];
            label.tag = 0;
            label.numberOfLines = 0;
            [round addSubview:label];
            self.typeLabel = label;
        }
        
        self.phoneNumLable.delegate = self;
        self.phoneNumLable = [[TTTAttributedLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(round.frame)+6, 8, 110, 16)];
        self.phoneNumLable.textColor = [UIColor blackColor];
        self.phoneNumLable.lineBreakMode = UILineBreakModeWordWrap;
        self.phoneNumLable.numberOfLines = 0;
        self.phoneNumLable.backgroundColor = [UIColor clearColor];
        self.phoneNumLable.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:(NSString *)kCTUnderlineStyleAttributeName];
        self.phoneNumLable.highlightedTextColor = [UIColor blackColor];
        self.phoneNumLable.shadowColor = [UIColor colorWithWhite:0.87f alpha:1.0f];
        self.phoneNumLable.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.phoneNumLable.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
        
        //选择显示不同位置的字体颜色
        [self addSubview:self.phoneNumLable];
        NSMutableAttributedString * tttstring = [[NSMutableAttributedString alloc] initWithString:@"133 1314 8888"];
        UIFont *italicSystemFont = [UIFont systemFontOfSize:12];
        CTFontRef italicFont = CTFontCreateWithName((CFStringRef)italicSystemFont.fontName, italicSystemFont.pointSize, NULL);
        if(italicFont){
            float end = tttstring.length;

            [tttstring addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor redColor] CGColor] range:NSMakeRange(0,5)];
            [tttstring addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(italicFont) range:NSMakeRange(0,end)];
        }
        [self.phoneNumLable setText:tttstring];
        
        //预存
        UILabel *label2 = [[UILabel alloc]initWithFrame:
                           CGRectMake(CGRectGetMaxX(round.frame)+2,
                                      CGRectGetMaxY(self.phoneNumLable.frame)+6,
                                      110,
                                      16)];
        label2.backgroundColor = [UIColor clearColor];
        label2.textColor = [UIColor blackColor];
        label2.font = [UIFont systemFontOfSize:14];
        label2.text = @"";
        label2.textAlignment = UITextAlignmentCenter ;
        self.saveLabel = label2 ;
        [self addSubview:label2];
        
        //地区
        UILabel *areaLabel = [[UILabel alloc] initWithFrame:
                              CGRectMake(CGRectGetMaxX(round.frame)+6 +120, 10, 100, 16)];
        areaLabel.backgroundColor = [UIColor clearColor];
        areaLabel.textColor = [UIColor blackColor];
        areaLabel.font = [UIFont systemFontOfSize:14];
        areaLabel.text = @"";
//        areaLabel.textAlignment = UITextAlignmentCenter ;
//        areaLabel.numberOfLines = 0;
        self.areaLabel = areaLabel ;
        [self addSubview:areaLabel];
        
        //低消
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:
                              CGRectMake(CGRectGetMaxX(round.frame)+6 + 120 ,
                                          CGRectGetMaxY(areaLabel.frame)+6,
                                         120,
                                         16)];
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.textColor = [UIColor blackColor];
        infoLabel.font = [UIFont systemFontOfSize:14];
        infoLabel.text = @"";
//        infoLabel.textAlignment = UITextAlignmentCenter ;
        infoLabel.numberOfLines = 0;
        self.infoLabel = infoLabel;
        [self addSubview:infoLabel];
        
        UIButton *collectBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        collectBtn.backgroundColor = [UIColor clearColor];
        collectBtn.frame = CGRectMake(CGRectGetMaxX(infoLabel.frame) -10,
                                      (CGRectGetHeight(self.frame)-40)/2+5,
                                      40,
                                      40);
        collectBtn.selected = YES;
        collectBtn.tag = kcollectionBtnTag ;
        [collectBtn setImage:[UIImage imageNamed:@"prettyNum_collection_unselected.png"] forState:UIControlStateNormal];
        [collectBtn setImage:[UIImage imageNamed:@"prettyNum_collection_selected.png"] forState:UIControlStateSelected];
        [collectBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
        self.collectedBtn = collectBtn ;
        [self addSubview:collectBtn];
        
        UIView *divide = [[UIView alloc] initWithFrame:CGRectMake(0,53,self.bounds.size.width-26, 1)];
        divide.backgroundColor = [UIColor colorWithRed:213/255. green:213/255. blue:213/255. alpha:1];
        [self addSubview:divide];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setInfo : (NSMutableDictionary *) dictionary
{
    self.infoDict = dictionary ;
    NSString *cityName = [NSString stringWithFormat:@"%@",self.infoDict[@"City"]];
    if ([cityName hasSuffix:@"市"]) {
        cityName = [cityName substringToIndex:cityName.length-1];
    }
    self.areaLabel.text = [NSString stringWithFormat:@"%@ %@",self.infoDict[@"Province"],cityName];
    self.saveLabel.text = [NSString stringWithFormat:@"预存 : %@元",self.infoDict[@"PrepayMent"]];
    self.infoLabel.text = [NSString stringWithFormat:@"月最低消 : %@元",self.infoDict[@"MinAmount"]];
    
    //号码
    self.phoneNumLable.text = self.infoDict[@"PhoneNumber"] == nil?@"":self.infoDict[@"PhoneNumber"] ;
    int startPos = [self.infoDict[@"HlStart"] intValue] ;
    int endPos = [self.infoDict[@"HlEnd"] intValue] ;
    NSString *phoneNum = self.infoDict[@"PhoneNumber"] == nil?@"":self.infoDict[@"PhoneNumber"];
    NSMutableAttributedString * tttstring = [[NSMutableAttributedString alloc] initWithString:phoneNum];
    NSMutableAttributedString *insertStr =  [[NSMutableAttributedString alloc]initWithString:@" "];
    
    if (endPos>0) {
        NSRange range = NSMakeRange(startPos, endPos-startPos);
        UIFont *italicSystemFont = [UIFont systemFontOfSize:14];
        CTFontRef italicFont = CTFontCreateWithName((CFStringRef)italicSystemFont.fontName, italicSystemFont.pointSize, NULL);
        if(italicFont){
            [tttstring addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor colorWithRed:255/255. green:93/255. blue:65/255. alpha:1] CGColor] range:range];
            [tttstring addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(italicFont) range:NSMakeRange(0, phoneNum.length)];
            [tttstring insertAttributedString:insertStr atIndex:3];
            [tttstring insertAttributedString:insertStr atIndex:8];
        }
    }
    else{
        UIFont *italicSystemFont = [UIFont systemFontOfSize:14];
        CTFontRef italicFont = CTFontCreateWithName((CFStringRef)italicSystemFont.fontName, italicSystemFont.pointSize, NULL);
        if(italicFont){
            [tttstring addAttribute:(NSString *)kCTFontAttributeName value:(id)CFBridgingRelease(italicFont) range:NSMakeRange(0, phoneNum.length)];
            [tttstring insertAttributedString:insertStr atIndex:3];
            [tttstring insertAttributedString:insertStr atIndex:8];
        }
    }
    
    [self.phoneNumLable setText:tttstring];
    
    int cellType = [[dictionary objectForKey:@"TypeId"] intValue];
    if (cellType == 0) {
        self.roundImageView.backgroundColor = [UIColor clearColor];
        self.roundImageView.image = [UIImage imageNamed:@"prettyNum_other_icon@2x"];
        self.typeLabel.text = @"";
    }else if (cellType == 1) {
        self.roundImageView.backgroundColor = [UIColor colorWithRed:244/255. green:146/255. blue:68/255. alpha:1];
        self.typeLabel.text = @"顶级";
        self.roundImageView.image=nil;
    } else if(cellType == 2) {
        self.roundImageView.backgroundColor = [UIColor colorWithRed:225/255. green:136/255. blue:171/255. alpha:1];
        self.typeLabel.text = @"爱情";
        self.roundImageView.image=nil;
    } else if(cellType == 3) {
        self.roundImageView.backgroundColor = [UIColor colorWithRed:247/255. green:133/255. blue:114/255. alpha:1];
        self.typeLabel.text = @"事业";
        self.roundImageView.image=nil;
    } else if(cellType == 4) {
        self.roundImageView.backgroundColor = [UIColor colorWithRed:111/255. green:197/255. blue:55/255. alpha:1];
        self.typeLabel.text = @"0元";
        self.roundImageView.image=nil;
    }
}

- (void) setCell : (NSMutableDictionary *) dict
{
    
}

#pragma mark - Action
- (void) collectionAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelCollected:)]) {
        [self.delegate cancelCollected:self];
    }
}


@end
