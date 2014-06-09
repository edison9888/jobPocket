//
//  EsChooseCell.m
//  xhgdzwyq
//
//  Created by Hehx on 14-5-23.
//  Copyright (c) 2014年 Eshore. All rights reserved.
//

#import "EsChooseCell.h"

@interface EsChooseCell()
{
    UILabel  *_titleLabel;
    UIButton *_btn;
}
@end
@implementation EsChooseCell

-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}


-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
}

-(void)setDelegate:(id<clickDeledate>)thisdelegate
{
    _delegate = thisdelegate;
}

-(void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    [self setBtnOn:_isSelected];
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier height:(CGFloat)height
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat padding = 20;
        {
            //显示的内容
            self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), height);
            UILabel *label = [UILabel new];
            label.frame = CGRectMake(padding, 0, CGRectGetWidth(self.frame),  CGRectGetHeight(self.frame));
            label.textColor = kUIColorFromRGB(0x777777);
            label.backgroundColor = [UIColor clearColor];
            [self addSubview:label];
            _titleLabel = label;
        }
        {
            //右边按钮
            UIImage *offImg = [UIImage imageNamed:@"choose_off"];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat width = offImg.size.width;
            btn.frame = CGRectMake(CGRectGetWidth(self.frame)- padding - width, (CGRectGetHeight(self.frame)-width)*0.5-10, width+20, width+20);
            [btn setImage:offImg forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            _btn = btn;
        }
//        {
//            //画线
//            UILabel *line = [UILabel new];
//            line.frame = CGRectMake(padding, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame)-padding*2, 1);
//            line.backgroundColor = kUIColorFromRGB(0xcccccc);
//            [self addSubview:line];
//        }
    }
    return self;
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

-(void)btnClick:(UIButton *)btn
{
    _isSelected = !_isSelected;
    //改变按钮形式
    [self setBtnOn:_isSelected];
    //通知上层处理业务
    [_delegate clickBtn:_indexPath isSelected:_isSelected];
    
}


- (void)setBtnOn:(BOOL)choose{
    if (choose) {
        [_btn setImage:[UIImage imageNamed:@"choose_on"] forState:UIControlStateNormal];
    }else{
        [_btn setImage:[UIImage imageNamed:@"choose_off"] forState:UIControlStateNormal];
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
