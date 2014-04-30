//
//  CRecipientEditView.m
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-1-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CRecipientEditView.h"

@implementation CRecipientEditView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        UIButton* btnHidden = [UIButton buttonWithType:UIButtonTypeCustom];
        btnHidden.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        btnHidden.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [btnHidden addTarget:self
                      action:@selector(onBtnHidden:)
            forControlEvents:UIControlEventTouchUpInside];
        btnHidden.tag = 1001;
        [self addSubview:btnHidden];
        
        CGFloat xoffset = 15;
        CGFloat yoffset = 10;
        CGRect  trect   = CGRectMake(xoffset, yoffset,frame.size.width-xoffset*2, 30);
        {
            UILabel* labTip = [[UILabel alloc] initWithFrame:trect];
            labTip.backgroundColor = [UIColor clearColor];
            labTip.text = @"填写收件人信息";
            labTip.font = [UIFont boldSystemFontOfSize:15];
            [self addSubview:labTip];
        }
        yoffset = CGRectGetMaxY(trect)+5;
        trect   = CGRectMake(xoffset+10, yoffset, frame.size.width-xoffset*2,35);
        {
            UILabel* startLab = [[UILabel alloc] initWithFrame:CGRectMake(xoffset, yoffset,10, 35)];
            startLab.backgroundColor = [UIColor clearColor];
            startLab.text = @"*";
            startLab.textColor = [UIColor colorWithRed:233/255.0
                                                 green:80/255.0
                                                  blue:65/255.0
                                                 alpha:1];
            startLab.font = [UIFont systemFontOfSize:15];
            [self addSubview:startLab];
            
            UILabel* labTip = [[UILabel alloc] initWithFrame:CGRectMake(xoffset+10, yoffset,70, 35)];
            labTip.backgroundColor = [UIColor clearColor];
            labTip.text = @"收件人:";
            labTip.font = [UIFont systemFontOfSize:15];
            [self addSubview:labTip];
            
            CGRect rightRc = CGRectMake(CGRectGetMaxX(labTip.frame),
                                        yoffset,
                                        CGRectGetWidth(trect)-CGRectGetWidth(labTip.frame),
                                        35);
            UITextField *txtFeild = [[UITextField alloc]initWithFrame:rightRc];
            txtFeild.backgroundColor =  [UIColor whiteColor];
            txtFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter ;
            txtFeild.returnKeyType = UIReturnKeyDone ;
            txtFeild.clearButtonMode = UITextFieldViewModeWhileEditing ; //点击清除
            txtFeild.keyboardType = UIKeyboardTypeDefault;
            txtFeild.font = [UIFont systemFontOfSize:14];
            [self addSubview:txtFeild];
            _reciper = txtFeild;
        }
        yoffset = CGRectGetMaxY(trect)+5;
        trect   = CGRectMake(xoffset+10, yoffset, frame.size.width-xoffset*2,35);
        // 收件人所在地区
        {
            UITextField *txtFeild = [[UITextField alloc]initWithFrame:trect];
            txtFeild.backgroundColor =  [UIColor whiteColor];
            txtFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter ;
            txtFeild.returnKeyType = UIReturnKeyDone ;
            txtFeild.placeholder  = @"收件人所在省市区";
            txtFeild.keyboardType = UIKeyboardTypeNumberPad ;
            txtFeild.enabled = NO;
            txtFeild.font = [UIFont systemFontOfSize:14];
            [self addSubview:txtFeild];
            _province = txtFeild;
            
            UIButton* labTip = [UIButton buttonWithType:UIButtonTypeCustom];
            labTip.frame = trect;
            labTip.titleLabel.font = [UIFont systemFontOfSize:14];
            [labTip setImage:[UIImage imageNamed:@"recipien_piker.png"]
                    forState:UIControlStateNormal];
            [labTip setContentEdgeInsets:UIEdgeInsetsMake(0,trect.size.width-16, 0,0)];
            [labTip addTarget:self action:@selector(onPikerAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:labTip];
        }
        yoffset = CGRectGetMaxY(trect)+5;
        trect   = CGRectMake(xoffset+10, yoffset, frame.size.width-xoffset*2,35);
        // 收件人所在地区
        {
            UITextField *txtFeild = [[UITextField alloc]initWithFrame:trect];
            txtFeild.backgroundColor =  [UIColor whiteColor];
            txtFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter ;
            txtFeild.returnKeyType = UIReturnKeyDone ;
            txtFeild.placeholder  = @"请填写详细的街道地址，确保准确送达";
            txtFeild.keyboardType = UIKeyboardTypeDefault ;
            txtFeild.font = [UIFont systemFontOfSize:14];
            [self addSubview:txtFeild];
            _address = txtFeild;
        }
        yoffset = CGRectGetMaxY(trect)+5;
        trect   = CGRectMake(xoffset+10, yoffset, frame.size.width-xoffset*2,35);
        {
            UILabel* labTip = [[UILabel alloc] initWithFrame:CGRectMake(xoffset+10, yoffset,70, 35)];
            labTip.backgroundColor = [UIColor clearColor];
            labTip.text = @"邮政编码:";
            labTip.font = [UIFont systemFontOfSize:15];
            [self addSubview:labTip];
            
            CGRect rightRc = CGRectMake(CGRectGetMaxX(labTip.frame),
                                        yoffset,
                                        CGRectGetWidth(trect)-CGRectGetWidth(labTip.frame),
                                        35);
            UITextField *txtFeild = [[UITextField alloc]initWithFrame:rightRc];
            txtFeild.backgroundColor =  [UIColor whiteColor];
            txtFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter ;
            txtFeild.returnKeyType = UIReturnKeyDone ;
            txtFeild.clearButtonMode = UITextFieldViewModeWhileEditing ; //点击清除
            txtFeild.keyboardType = UIKeyboardTypeNumberPad ;
            txtFeild.font = [UIFont systemFontOfSize:14];
            [self addSubview:txtFeild];
            _postcode = txtFeild;
        }
        yoffset = CGRectGetMaxY(trect)+5;
        trect   = CGRectMake(xoffset+10, yoffset, frame.size.width-xoffset*2,35);
        {
            UILabel* startLab = [[UILabel alloc] initWithFrame:CGRectMake(xoffset, yoffset,10, 35)];
            startLab.backgroundColor = [UIColor clearColor];
            startLab.text = @"*";
            startLab.textColor = [UIColor colorWithRed:233/255.0
                                                 green:80/255.0
                                                  blue:65/255.0
                                                 alpha:1];
            startLab.font = [UIFont systemFontOfSize:15];
            [self addSubview:startLab];

            UILabel* labTip = [[UILabel alloc] initWithFrame:CGRectMake(xoffset+10, yoffset,70, 35)];
            labTip.backgroundColor = [UIColor clearColor];
            labTip.text = @"联系电话:";
            labTip.font = [UIFont systemFontOfSize:15];
            [self addSubview:labTip];
            
            CGRect rightRc = CGRectMake(CGRectGetMaxX(labTip.frame),
                                        yoffset,
                                        CGRectGetWidth(trect)-CGRectGetWidth(labTip.frame),
                                        35);
            UITextField *txtFeild = [[UITextField alloc]initWithFrame:rightRc];
            txtFeild.backgroundColor =  [UIColor whiteColor];
            txtFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter ;
            txtFeild.returnKeyType = UIReturnKeyDone ;
            txtFeild.placeholder  = @"请填写正确的号码或固话";
            txtFeild.clearButtonMode = UITextFieldViewModeWhileEditing ; //点击清除
            txtFeild.keyboardType = UIKeyboardTypeNumberPad ;
            txtFeild.font = [UIFont systemFontOfSize:14];
            [self addSubview:txtFeild];
            _phone = txtFeild;
        }
    }
    return self;
}

-(void)hiddenKeyBord
{
    [_reciper resignFirstResponder];
    [_province resignFirstResponder];
    [_address resignFirstResponder];
    [_postcode resignFirstResponder];
    [_phone resignFirstResponder];
}

-(void)onBtnHidden:(id)sender
{
    if(_delegate && [_delegate respondsToSelector:@selector(onHiddenPopView:)])
    {
        [_delegate onHiddenPopView:self];
    }
}

-(void)setProvince:(NSString*)prov
              city:(NSString*)city
              dist:(NSString*)dist
{
    _province.text = [NSString stringWithFormat:@"%@,%@,%@",prov,city==nil?@"":city,dist==nil?@"":dist];
}

-(void)onPikerAction:(id)sender
{
    if(_delegate && [_delegate respondsToSelector:@selector(onPikerAction:)])
    {
        [_delegate onPikerAction:self];
    }
}

-(void)setAdressDict:(NSDictionary*)dict
{
    DLog(@"dict=%@",dict);
    _reciper.text = [dict objectForKey:@"UserName"];
    _address.text = [dict objectForKey:@"Address"];
    _phone.text   = [dict objectForKey:@"CusMobile"];
    _postcode.text= [dict objectForKey:@"PostCode"];
    _province.text= [NSString stringWithFormat:@"%@,%@,%@",
                     [dict objectForKey:@"ProvinceName"],
                     [dict objectForKey:@"CityName"],
                     [dict objectForKey:@"CountyName"]];
}

-(NSError*)checkInputValues{
    NSError* error = nil;
    int code = 0;
    NSString* errorMsg = @"";
    do
    {
        if(_reciper.text == nil ||
           [_reciper.text length]<=0){
            code     = 1;
            errorMsg = @"请填写收件人";
            break;
        }
        if (_reciper.text &&
            [[_reciper.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
            code     = 1;
            errorMsg = @"请填写正确的收件人";
            break;
        }
        if(_province.text == nil ||
           [_province.text length]<=0){
            code     = 2;
            errorMsg = @"请选择收件人所在地市";
            break;
        }
        if(_address.text == nil ||
           [_address.text length]<=0 || [[_address.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
            code     = 3;
            errorMsg = @"请填写详细地址，以便快递能正确送达";
            break;
        }
        if (_postcode.text.length > 0 &&
            _postcode.text.length != 6) {
            code     = 5;
            errorMsg = @"请填写正确的邮政编码";
            break;
        }
        if(_phone.text == nil ||
           [_phone.text length]<=0 || [[_phone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0){
            code     = 4;
            errorMsg = @"请填写收件人联系电话";
            break;
        }
    } while (NO);
    if (code != 0) {
        error = [NSError errorWithDomain:errorMsg
                                    code:code
                                userInfo:nil];
    }
    return error;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
