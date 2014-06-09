//
//  ToastAlertView.m
//  SphygmometerGuard
//
//  Created by  apple on 12-11-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ToastAlertView.h"
#import <QuartzCore/QuartzCore.h>
#import "EsAppDelegate.h"

@interface ToastAlertView()

- (void)dismiss;

@end

@implementation ToastAlertView

- (id)init
{
    __block BOOL hasExisting = NO;
    __block ToastAlertView * alert = nil;
    EsAppDelegate * appdelegate = (EsAppDelegate *)[UIApplication sharedApplication].delegate;
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
        return alert;
    }
    
    if (self = [super init])
    {
        self.userInteractionEnabled = NO;
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

//- (void)dealloc
//{
//    [_textLabel release];
//    [super dealloc];
//}

- (void)showAlertMsg:(NSString*)msg
{
    EsAppDelegate * appdelegate = (EsAppDelegate *)[UIApplication sharedApplication].delegate;
    
    _textLabel.frame = CGRectMake(0, 0, 200, 260);
    _textLabel.text = msg;
    [_textLabel sizeToFit];
    
    CGRect rc = CGRectInset(_textLabel.frame, -10, -10);
    rc.origin.x = (320 - CGRectGetWidth(rc))/2;
    rc.origin.y = CGRectGetHeight(appdelegate.window.frame) - 50 - CGRectGetHeight(rc) - appdelegate.keyboardHeight;
    self.frame = rc;
    rc = _textLabel.frame;
    rc.origin = CGPointMake(10, 10);
    _textLabel.frame = rc;
    
    [appdelegate.window addSubview:self];
    [appdelegate.window bringSubviewToFront:self];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:2];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

@end
