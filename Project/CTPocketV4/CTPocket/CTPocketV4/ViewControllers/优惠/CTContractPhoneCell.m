//
//  CTContractPhoneCell.m
//  CTPocketV4
//
//  Created by liuruxian on 13-11-19.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTContractPhoneCell.h"

@implementation CTContractPhoneCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIImage *BGimage = [UIImage imageNamed:@"packages_select.png"];
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(17, 0, self.frame.size.width-34, BGimage.size.height)];
        imageview.userInteractionEnabled = YES;
        imageview.backgroundColor = [UIColor clearColor];
        [self addSubview:imageview];
        
        int xPos = 0; int ySet = CGRectGetMaxY(imageview.frame);
        {
            self.backgroundColor    = [UIColor clearColor];
            UIImage *image1         = [UIImage imageNamed:@"packages_select.png"];
            UIImageView *contractimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image1.size.width, image1.size.height)];
            contractimageview.backgroundColor = [UIColor clearColor];
            contractimageview.userInteractionEnabled = YES;
            contractimageview.image = image1 ;
            [imageview addSubview:contractimageview];
            
            UILabel *label        = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, contractimageview.frame.size.width, contractimageview.frame.size.height)];
            label.backgroundColor = [UIColor clearColor];
            label.text = @"";
            label.textColor       = [UIColor blackColor];
            label.textAlignment   = UITextAlignmentCenter;
            label.font            = [UIFont systemFontOfSize:14];
            self._contractlb         = label;
            self._contractImageView    = contractimageview;
            [contractimageview addSubview:label];
            xPos = CGRectGetMaxX(contractimageview.frame) + 24;
        }
        {
            UILabel *label        = [[UILabel alloc]initWithFrame:CGRectMake(xPos, 0, 40, imageview.frame.size.height)];
            label.backgroundColor = [UIColor clearColor];
            label.text = @"";
            label.textColor       = [UIColor blackColor];
            label.textAlignment   = UITextAlignmentCenter;
            label.font            = [UIFont systemFontOfSize:14];
            xPos                  = CGRectGetMaxX(label.frame) + 32;
            self._totalPricelb           = label;
            [imageview addSubview:label];
        }
        {
            UILabel *label        = [[UILabel alloc]initWithFrame:CGRectMake(xPos, 0, 40, imageview.frame.size.height)];
            label.backgroundColor = [UIColor clearColor];
            label.text            = @"";
            label.textColor       = [UIColor blackColor];
            label.textAlignment   = UITextAlignmentCenter;
            label.font            = [UIFont systemFontOfSize:14];
            xPos                  = CGRectGetMaxX(label.frame) + 33;
            self._phonePricelb         = label;
            [imageview addSubview:label];
        }
        {
            UILabel *label        = [[UILabel alloc]initWithFrame:CGRectMake(xPos, 0, 40, imageview.frame.size.height)];
            label.backgroundColor = [UIColor clearColor];
            label.text            = @"";
            label.textColor       = [UIColor blackColor];
            label.textAlignment   = UITextAlignmentCenter;
            label.font            = [UIFont systemFontOfSize:14];
            [imageview addSubview:label];
            self._storedMoneylb = label;
        }
        {
            UIImageView *view     = [[UIImageView alloc]initWithFrame:CGRectMake(0, ySet, self.frame.size.width, 10)];
            view.backgroundColor  = [UIColor clearColor];
            [self addSubview:view];
        }
    }
    return self;
}
-(void)setContractInfo:(NSMutableArray *)contractInfoDic
{
    //UTF-16编码
    NSString *valueStr = @"合约单价"; NSString *totalPrice = @"总价格";
    NSString *PhonePrice = @"购机款"; NSString *store = @"预存话费";
    if (contractInfoDic == nil && contractInfoDic.count == 0) {
        return;
    }
    for (NSDictionary *item in contractInfoDic) {
        [item objectEnumerator];
        if ([item objectForKey:valueStr]) {
            self._contractlb.text    = (NSString *)[item objectForKey:valueStr];
        }
        if ([item objectForKey:totalPrice]) {
            self._totalPricelb.text    = (NSString *)[item objectForKey:totalPrice];
        }
        if ([item objectForKey:PhonePrice]) {
            self._phonePricelb.text    = [item objectForKey:PhonePrice];
            
        }
        if ([item objectForKey:store]) {
            self._storedMoneylb.text    = (NSString *)[item objectForKey:store];
        }
    }
}
-(void)showInfo:(UIButton *)sender
{
    ((UIButton *)sender).selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(showInfo:)]) {
        [self.delegate showInfo:self];
    }
}
-(void)setBtnSelectedStatus:(BOOL)status
{
    
}
-(void)setImage:(BOOL)status
{
    UIImage *image1 = [UIImage imageNamed:@"packages_select.png"];
    UIImage *image2 = [UIImage imageNamed:@"packages_contractSelect.png"];
    if (status) {
        self._contractImageView.image = image2;
    }else{
        self._contractImageView.image = image1;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
