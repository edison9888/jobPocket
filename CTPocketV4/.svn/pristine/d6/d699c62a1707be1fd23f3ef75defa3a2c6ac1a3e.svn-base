//
//  CTFeedbackCell.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-20.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  反馈Cell

#import "CTFeedbackCell.h"

@implementation CTFeedbackCell

static NSDateFormatter *unixFormatter;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        unixFormatter = [[NSDateFormatter alloc] init];
        [unixFormatter setDateFormat:@"yyyy年M月d日 HH:mm"];
        
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00];
        
        {
            _imageViewW = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 200, 50)];
            UIImage *image = [UIImage imageNamed:@"chat_bg_w"];
            UIImage *resizeableImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2.0, image.size.width/2.0, image.size.height/2.0, image.size.width/2.0)];
            _imageViewW.image = resizeableImage;
            [self.contentView addSubview:_imageViewW];
        }
        
        {
            _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, 180, 16)];
            _dateLabel.backgroundColor = [UIColor clearColor];
            _dateLabel.font = [UIFont systemFontOfSize:13.0f];
            _dateLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:_dateLabel];
        }
        
        {
            _askLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 16+16, 180, 16)];
            _askLabel.backgroundColor = [UIColor clearColor];
            _askLabel.font = [UIFont systemFontOfSize:13.0f];
            _askLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:_askLabel];
        }
        
        {
            _imageViewG = [[UIImageView alloc] initWithFrame:CGRectMake(195, 58, 65, 24)];
            _imageViewG.image = [UIImage imageNamed:@"chat_bg_g"];
            [self.contentView addSubview:_imageViewG];
        }
        
        {
            _answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 57, 60, 24)];
            _answerLabel.backgroundColor = [UIColor clearColor];
            _answerLabel.font = [UIFont systemFontOfSize:13.0f];
            _answerLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:_answerLabel];
        }
        
        {
            _separator = [[UIView alloc] initWithFrame:CGRectMake(0, 82+5, 260, 1)];
            _separator.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
            [self.contentView addSubview:_separator];
        }
    }
    return self;
}

- (void)setCellInfo:(NSDictionary *)info
{
    // 提问日期
    id reply_date = [info objectForKey:@"reply_date"];
    if (reply_date && [reply_date respondsToSelector:@selector(doubleValue)]) {
        NSTimeInterval reply_date_secs = [reply_date doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:reply_date_secs/1000];
        _dateLabel.text = [unixFormatter stringFromDate:date];
    }
    
    // 提问内容
    _askLabel.frame = CGRectMake(15, 16+16, 180, 16);
    id user_reply_message = [info objectForKey:@"user_reply_message"];
    if (user_reply_message && [user_reply_message isKindOfClass:[NSString class]]) {
        _askLabel.text = [user_reply_message stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _askLabel.numberOfLines = 0;
        [_askLabel sizeToFit];
    }
    
    // 已答复or未答复
    id reply_content = [info objectForKey:@"reply_content"];
    if (reply_content && ![reply_content isKindOfClass:[NSNull class]]) {
        if ([reply_content isKindOfClass:[NSArray class]] || [reply_content isKindOfClass:[NSString class]]) {
            _imageViewG.image = [UIImage imageNamed:@"chat_bg_g"];
            _answerLabel.text = @"已答复";
        }
    } else {
        _imageViewG.image = [UIImage imageNamed:@"chat_bg_y"];
        _answerLabel.text = @"未答复";
    }
    
    // 调整已答复和分割线的位置
    {
        CGFloat h = _askLabel.bounds.size.height - 16;
        
        _imageViewW.frame = CGRectMake(0, 10, 200, 50+h);
        
        _imageViewG.frame = CGRectMake(195, 58+h, 65, 24);
        
        _answerLabel.frame = CGRectMake(200, 57+h, 60, 24);
        
        _separator.frame = CGRectMake(0, 82+5+h, 260, 1);
    }
}

@end
