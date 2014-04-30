//
//  CTBarePhoneCell.m
//  CTPocketV4
//
//  Created by liuruxian on 13-11-25.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBarePhoneCell.h"
#import "UIView+RoundRect.h"

@interface CTBarePhoneCell ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *picture;
@property (nonatomic, strong) UILabel *phoneName;
@property (nonatomic, strong) UILabel *price;
@end

@implementation CTBarePhoneCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        CGRect rect          = self.frame;
        rect.size.height     = 103;
        rect.size.width      = 320;
        self.frame           = rect;
        
        self.backgroundColor = [UIColor clearColor];
        {
            UIImageView *bgview    = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 13)];
            bgview.backgroundColor = [UIColor whiteColor];
            [bgview dwMakeRoundCornerWithRadius:5]; //圆角处理
            bgview.userInteractionEnabled = YES;
            [self addSubview:bgview];
            int xPos = 10 , yPos = 0;
            {
                //云卡图片
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(xPos, 10, 80, bgview.frame.size.height-20)];
                imageView.userInteractionEnabled = YES ;
                xPos = CGRectGetMaxX(imageView.frame);
                [bgview addSubview:imageView];
                self.picture = imageView ;
            }
            xPos +=15;
            {
                UILabel *label        = [[UILabel alloc]initWithFrame:CGRectMake(xPos, 15, bgview.frame.size.width - 10, 40)];
                label.backgroundColor = [UIColor clearColor];
                label.text            = @"云卡";
                label.textAlignment   = UITextAlignmentLeft;
                label.font            = [UIFont systemFontOfSize:12];
                label.textColor       = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
                label.numberOfLines   = 0;     // 不可少Label属性之一
                label.lineBreakMode   = UIKeyboardAppearanceDefault;    // 不可少Label属性之二
                self.phoneName = label ;
                [bgview addSubview:label];
                
                yPos =  CGRectGetMaxY(label.frame) + 6;
            }
            {
                UILabel *label        = [[UILabel alloc]initWithFrame:CGRectMake(xPos, yPos, bgview.frame.size.width - 10, 20)];
                label.backgroundColor = [UIColor clearColor];
                label.text            = @"300";
                label.textAlignment   = UITextAlignmentLeft;
                label.textColor       = [UIColor colorWithRed:102/255. green:102/255. blue:102/255. alpha:1];
                label.font            = [UIFont systemFontOfSize:12];
                label.numberOfLines   = 0;     // 不可少Label属性之一
                label.lineBreakMode   = UIKeyboardAppearanceDefault;    // 不可少Label属性之二
                self.price = label ;
                [bgview addSubview:label];
            }
        }
    }
    return self;
}

#pragma mark - fun

-(void)setInfo:(NSDictionary *)dictionary
{
    if (dictionary == nil) { //设置默认信息
        return;
    }
    self.phoneInfo = dictionary ; //设置属性信息
    id info = (id)[dictionary objectForKey:@"Price"];        //读取手机价格
    if(info && [info isKindOfClass:[NSString class]]){
        self.price.text = [NSString stringWithFormat:@"价格 : %@元", info];
    }
    info = [dictionary objectForKey:@"Name"];                    //读取手机名称
    if(info && [info isKindOfClass:[NSString class]]){
        CGRect rect = self.phoneName.frame;
        CGSize labelSize = [info sizeWithFont:[UIFont boldSystemFontOfSize:12]
                            constrainedToSize:CGSizeMake(150, 40)
                                lineBreakMode:UILineBreakModeCharacterWrap];   // str是要显示的字符
        rect.size = labelSize;
        self.phoneName.frame = rect;
        self.phoneName.text = info;
        
    }
    NSString * imageurl = [dictionary objectForKey:@"IconUrl"];
    NSURL *url = [NSURL URLWithString:imageurl];
    
//    [self.picture setImageFromURL:url placeHolderImage:@"loadingImage2.png"];
    [self.picture setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loadingImage2.png"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
