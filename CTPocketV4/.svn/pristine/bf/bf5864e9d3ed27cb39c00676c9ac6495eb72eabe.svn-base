//
//  ToastAlertView.m
//  SphygmometerGuard
//
//  Created by  apple on 12-11-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ToastAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface ToastAlertView()

- (void)dismiss;

@end

@implementation ToastAlertView

+ (id)alloc
{
    __block BOOL hasExisting = NO;
    __block ToastAlertView * alert = nil;
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appdelegate.window.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         if ([obj isKindOfClass:[ToastAlertView class]])
         {
             hasExisting = YES;
             alert = (ToastAlertView *)obj;
             *stop = YES;
         }
     }];
    
    if (hasExisting && alert)
    {
        [alert removeFromSuperview];
    }
    
    return [super alloc];
}

- (id)init
{
    if (self = [super init])
    {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.backgroundColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:0.8];
        self.layer.shadowColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:0.8].CGColor;
		self.layer.shadowOpacity = 0.8;
		self.layer.shadowOffset = CGSizeMake(1,1);
		self.layer.shadowRadius = 3;
		self.layer.cornerRadius = 6;
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 260)];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.numberOfLines = 0;
        _textLabel.textAlignment = UITextAlignmentLeft;
        [self addSubview:_textLabel];
    }
    return self;
}

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
}

- (void)showAlertMsg:(NSString*)msg
{
    AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    _textLabel.text = msg;
    [_textLabel sizeToFit];
    
    CGRect rc = CGRectInset(_textLabel.frame, -10, -10);
    rc.origin.x = (320 - CGRectGetWidth(rc))/2;
    rc.origin.y = CGRectGetHeight(appdelegate.window.frame) - 50 - CGRectGetHeight(rc);//(480 - CGRectGetHeight(rc))/2;
//    rc.origin.y = (CGRectGetHeight(appdelegate.window.frame) - 50 - CGRectGetHeight(rc))/2;
    self.frame = rc;
    rc = _textLabel.frame;
    rc.origin = CGPointMake(10, 10);
    _textLabel.frame = rc;
    
    [self removeFromSuperview];
    [appdelegate.window addSubview:self];
    [appdelegate.window bringSubviewToFront:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismiss) object:nil];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
}

- (void)dismiss
{
    [self removeFromSuperview];
}
@end
