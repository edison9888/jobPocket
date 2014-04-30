//
//  CTFeedbackDetailVCtler.m
//  CTPocketV4
//
//  Created by 许忠洲 on 13-11-21.
//  Copyright (c) 2013年 广东亿迅科技有限公司. All rights reserved.
//  吐槽详情页

#import "CTFeedbackDetailVCtler.h"
#import "SVProgressHUD.h"
#import "Utils.h"
#import "SIAlertView.h"
#import "AppDelegate.h"

@interface CTFeedbackDetailVCtler ()
{
    UIScrollView *_fbScrollView;
    UIImageView *_imageViewW;
    UIImageView *_imageViewG;
}

@end

@implementation CTFeedbackDetailVCtler

static NSDateFormatter *unixFormatter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // 标题
        self.title = @"吐槽反馈";
        // 左按钮
        [self setLeftButton:[UIImage imageNamed:@"btn_back"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    unixFormatter = [[NSDateFormatter alloc] init];
    [unixFormatter setDateFormat:@"yyyy年M月d日 HH:mm"];
    
    // _fbScrollView
    {
        _fbScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _fbScrollView.backgroundColor = [UIColor clearColor];
        _fbScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_fbScrollView];
    }
    
    // _imageViewW
    {
        _imageViewW = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, 236, 105)];
        UIImage *imageW = [UIImage imageNamed:@"chat_b_w"];
        UIImage *resizeableImageW = [imageW resizableImageWithCapInsets:UIEdgeInsetsMake(imageW.size.height/2.0, imageW.size.width/2.0, imageW.size.height/2.0, imageW.size.width/2.0)];
        _imageViewW.image = resizeableImageW;
        [_fbScrollView addSubview:_imageViewW];
    }
    
    // 提问日期
    {
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(30+15, 20+8, 212, 16)];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.font = [UIFont systemFontOfSize:13.0f];
        dateLabel.textColor = [UIColor blackColor];
        [_fbScrollView addSubview:dateLabel];
        
        id reply_date = [self.info objectForKey:@"reply_date"];
        if (reply_date && [reply_date respondsToSelector:@selector(doubleValue)]) {
            NSTimeInterval reply_date_secs = [reply_date doubleValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:reply_date_secs/1000];
            dateLabel.text = [NSString stringWithFormat:@"吐槽时间：%@", [unixFormatter stringFromDate:date]];
        }
    }
    
    // 提问内容
    {
        UILabel *askLabel = [[UILabel alloc] initWithFrame:CGRectMake(30+15, 20+8+20, 212, 16)];
        askLabel.backgroundColor = [UIColor clearColor];
        askLabel.font = [UIFont systemFontOfSize:13.0f];
        askLabel.textColor = [UIColor blackColor];
        [_fbScrollView addSubview:askLabel];
        
        id user_reply_message = [self.info objectForKey:@"user_reply_message"];
        if (user_reply_message && [user_reply_message isKindOfClass:[NSString class]]) {
            askLabel.text = [NSString stringWithFormat:@"吐槽内容：\n%@", [user_reply_message stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            askLabel.numberOfLines = 0;
            [askLabel sizeToFit];
        }
        
        // 调整_imageViewW的高度
        CGFloat h = askLabel.frame.origin.y + askLabel.frame.size.height + 10 - _imageViewW.frame.origin.y;
        CGRect rect = _imageViewW.frame;
        rect.size.height = h;
        _imageViewW.frame = rect;
    }
    
    // 是否已处理反馈
    id reply_content = [self.info objectForKey:@"reply_content"];
    if (reply_content && [reply_content isKindOfClass:[NSString class]]) {
        
        NSData *reply_content_data = [reply_content dataUsingEncoding:NSUTF8StringEncoding];
        if (reply_content_data == nil)
        {
            reply_content = nil;
        }
        else
        {
            NSError *error = nil;
            reply_content = [NSJSONSerialization JSONObjectWithData:reply_content_data options:0 error:&error];
            if(error) DLog(@"JSON Parsing Error: %@", error);
        }
    }
    if (reply_content == nil || ![reply_content isKindOfClass:[NSArray class]]) {
        // 未回复
        
        // _imageViewG
        {
            _imageViewG = [[UIImageView alloc] initWithFrame:CGRectMake(124, _imageViewW.frame.origin.y+_imageViewW.frame.size.height+8, 164, 35)];
            _imageViewG.image = [UIImage imageNamed:@"chat_b_y"];
            [_fbScrollView addSubview:_imageViewG];
        }
        
        // 客服状态
        {
            CGRect rect = _imageViewG.frame;
            rect.origin.x = rect.origin.x + 8;
            
            UILabel *answerLabel = [[UILabel alloc] initWithFrame:rect];
            answerLabel.backgroundColor = [UIColor clearColor];
            answerLabel.font = [UIFont systemFontOfSize:13.0f];
            answerLabel.textColor = [UIColor blackColor];
            answerLabel.text = @"客服状态：正在处理...";
            [_fbScrollView addSubview:answerLabel];
        }
        
        _fbScrollView.contentSize = CGSizeMake(self.view.frame.size.width, _imageViewG.frame.origin.y+_imageViewG.frame.size.height+20);
    }
    else
    {
        // 已回复
        
        // _imageViewG
        {
            _imageViewG = [[UIImageView alloc] initWithFrame:CGRectMake(50, _imageViewW.frame.origin.y+_imageViewW.frame.size.height+8, 237, 149)];
            UIImage *imageG = [UIImage imageNamed:@"chat_b_g"];
            UIImage *resizeableImageW = [imageG resizableImageWithCapInsets:UIEdgeInsetsMake(imageG.size.height/2.0, imageG.size.width/2.0, imageG.size.height/2.0, imageG.size.width/2.0)];
            _imageViewG.image = resizeableImageW;
            [_fbScrollView addSubview:_imageViewG];
        }
        
        // 回答日期
        {
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageViewG.frame.origin.x+8, _imageViewG.frame.origin.y+8, 212, 16)];
            dateLabel.backgroundColor = [UIColor clearColor];
            dateLabel.font = [UIFont systemFontOfSize:13.0f];
            dateLabel.textColor = [UIColor blackColor];
            [_fbScrollView addSubview:dateLabel];
            
            id reply_time = [self.info objectForKey:@"reply_time"];
            if (reply_time && [reply_time respondsToSelector:@selector(doubleValue)]) {
                NSTimeInterval reply_date_secs = [reply_time doubleValue];
                NSDate *date = [NSDate dateWithTimeIntervalSince1970:reply_date_secs];
                dateLabel.text = [NSString stringWithFormat:@"答复时间：%@", [unixFormatter stringFromDate:date]];
            }
        }
        
        // 答复信息
        {
            UILabel *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageViewG.frame.origin.x+8, _imageViewG.frame.origin.y+8+20, 212, 16)];
            answerLabel.backgroundColor = [UIColor clearColor];
            answerLabel.font = [UIFont systemFontOfSize:13.0f];
            answerLabel.textColor = [UIColor blackColor];
            [_fbScrollView addSubview:answerLabel];
            
            {
                NSString *text = @"";
                for (NSDictionary *dictionary in reply_content) {
                    if (dictionary && [dictionary respondsToSelector:@selector(objectForKey:)]) {
                        id content = [dictionary objectForKey:@"content"];
                        int index = [reply_content indexOfObject:dictionary];
                        if (content && [content isKindOfClass:[NSString class]]) {
                            if (index < [reply_content count] - 1) {
                                text = [text stringByAppendingFormat:@"%d、%@\n", index+1, content];
                            } else {
                                text = [text stringByAppendingFormat:@"%d、%@", index+1, content];
                            }
                        }
                    }
                }
                answerLabel.text = [NSString stringWithFormat:@"答复信息：\n%@", [text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                answerLabel.numberOfLines = 0;
                [answerLabel sizeToFit];
            }
            
            // 调整_imageViewW的高度
            CGFloat h = answerLabel.frame.origin.y + answerLabel.frame.size.height + 10 - _imageViewG.frame.origin.y;
            CGRect rect = _imageViewG.frame;
            rect.size.height = h;
            _imageViewG.frame = rect;
        }
        
        CGFloat originY = 0;
        // 那块绿色的玩意和提示语
        {
            UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(0, _imageViewG.frame.origin.y+_imageViewG.frame.size.height+25, 6, 27)];
            greenView.backgroundColor = [UIColor colorWithRed:0.43f green:0.77f blue:0.21f alpha:1.00f];
            [_fbScrollView addSubview:greenView];
            
            UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, greenView.frame.origin.y, 260, 27)];
            tipLabel.backgroundColor = [UIColor clearColor];
            tipLabel.font = [UIFont systemFontOfSize:13.0f];
            tipLabel.textColor = [UIColor blackColor];
            tipLabel.text = @"您对所反馈的意见或建议是否满意？";
            [_fbScrollView addSubview:tipLabel];
            
            originY = tipLabel.frame.origin.y + tipLabel.frame.size.height + 20;
        }
        
        // 反馈按钮
        {
            NSArray *titleArray = [NSArray arrayWithObjects:@"非常满意", @"满意", @"不满意", nil];
            CGFloat originX = 45;
            for (int i = 0; i < 3; i++) {
                NSString *iconName = [NSString stringWithFormat:@"fb_face_0%d.png", i+1];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(originX, originY, 47, 47);
                [btn setBackgroundImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
                btn.tag = i;
                [btn addTarget:self action:@selector(onVoteAction:) forControlEvents:UIControlEventTouchUpInside];
                [_fbScrollView addSubview:btn];
                
                UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(originX-10, originY+47, 47+20, 22)];
                labTitle.backgroundColor = [UIColor clearColor];
                labTitle.font = [UIFont systemFontOfSize:13];
                labTitle.textColor= [UIColor blackColor];
                labTitle.text = [titleArray objectAtIndex:i];
                labTitle.textAlignment = UITextAlignmentCenter;
                [_fbScrollView addSubview:labTitle];
                
                originX = originX + 47 + 44;
            }
            originY = originY + 47 + 22 +24;
        }
        
        _fbScrollView.contentSize = CGSizeMake(self.view.frame.size.width, originY);
    }
}

#pragma mark - self func

- (void)onVoteAction:(UIButton *)sender
{
    [SVProgressHUD showWithStatus:@"提交中..." maskType:SVProgressHUDMaskTypeGradient];
    
    int user_reply_satisfactory_int = 0;
    switch (sender.tag) {
        case 0:
            user_reply_satisfactory_int = 1;
            break;
        case 1:
            user_reply_satisfactory_int = 2;
            break;
        case 2:
            user_reply_satisfactory_int = 4;
            break;
        default:
            break;
    }
    
    // 应用编号为12
    NSString* str_application_id = @"12";
    
    // 上报周期:用户反馈日期时间戳
    NSString* str_reply_date = [[NSString alloc] initWithFormat:@"%lld", (long long)[[NSDate date] timeIntervalSince1970]];
    
    // MD5加密:效验合法性 规则：time+key做md5加密
    NSString* key = @"0c07b128fca8195eb6513ba7162bed86";
    NSString* str = [NSString stringWithFormat:@"%@%@", str_reply_date,key];
    NSString* str_sig = [[Utils MD5:str] lowercaseString];
    
    // 当前的时间戳:效验参数
    NSString* str_time = [[NSString alloc]initWithFormat:@"%lld", (long long)[[NSDate date] timeIntervalSince1970]];
    
    NSNumber* content_id = [self.info objectForKey:@"content_id"];
    
    if (content_id == nil) {
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                         andMessage:@"评价失败！"];
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  NSLog(@"取消");
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        [alertView show];
    }
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            str_application_id, @"application_id",
                            str_sig, @"sig",
                            str_time, @"time",
                            content_id, @"reply_content_id",
                            str_reply_date, @"satisfactory_date",
                            [NSNumber numberWithInt:user_reply_satisfactory_int], @"user_reply_satisfactory",
                            nil];
    
    [MyAppDelegate.feedbackEngine postJSONWithMethod:@"userSatisfactory"
                                              params:params
                                         onSucceeded:^(NSDictionary *dict) {
                                             
                                             [SVProgressHUD dismiss];
                                             
                                             SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"提示"
                                                                                              andMessage:@"满意度递交成功！"];
                                             [alertView addButtonWithTitle:@"确定"
                                                                      type:SIAlertViewButtonTypeDefault
                                                                   handler:^(SIAlertView *alertView) {
                                                                       NSLog(@"确定");
                                                                       [self.navigationController popViewControllerAnimated:YES];
                                                                   }];
                                             alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                             [alertView show];
                                             
                                         } onError:^(NSError *engineError) {
                                             
                                             [SVProgressHUD dismiss];
                                             
                                             SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                                                              andMessage:engineError.localizedDescription];
                                             [alertView addButtonWithTitle:@"确定"
                                                                      type:SIAlertViewButtonTypeDefault
                                                                   handler:^(SIAlertView *alertView) {
                                                                       NSLog(@"取消");
                                                                   }];
                                             alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                             [alertView show];
                                         }];
}

@end
