//
//  CTPInvoiceInfoVCtler.m
//  CTPocketv3
//
//  Created by lyh on 13-5-28.
//
//

#import "CTPInvoiceInfoVCtler.h"
//#import "CTPOrderConfirmVCtler.h"
#import "UIView+RoundRect.h"
#import "AppDelegate.h"
#import "UIView+BounceAnimation.h"
#import <QuartzCore/QuartzCore.h>
//#import "MainViewCtler.h"
#import "CTPOrderConfirmVCtler.h"

#define  tagInvoiceTypeCheckButton            1100
#define  tagPersonalCheckButton               1200
#define  tagCompanyCheckButton                1201
#define  tagDetailCheckButton                 1300
#define  tagComputerFittingCheckButton        1301
#define  tagSuppliesCheckButton               1302
#define  tagSaveInfoButton                    1400

#define  kCacheInvoice  @"cacheinvoice"

@interface CTPInvoiceItem()

//- (void)setInitInvoiceinfo;

@end

@implementation CTPInvoiceItem
@synthesize _invoiceType,_invoiceTitle,_itemListType;

-(id)init
{
    if ((self = [super init]))
    {
        _invoiceType  = 0;
        _invoiceTitle = 0;
        _itemListType = 0;
    }
    return self;
}


@end


@interface CTPInvoiceInfoVCtler ()

-(void)onCheckBtn:(id)sender;
-(void)onSaveInvoiceInfo:(id)sender;

@end

@implementation CTPInvoiceInfoVCtler
@synthesize _salesProductInfoDict,_orderInfoDict,_deliveryInfo,_customerInfo;
@synthesize isModifyInvoiceinfo;
@synthesize invoiceInfo;
@synthesize ContractInfo;
@synthesize PackageInfoDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _invoiceItem = [[CTPInvoiceItem alloc] init];
        
        NSDictionary *loginDict = [Global sharedInstance].loginInfoDict;
        NSString *Account = [loginDict objectForKey:@"UserLoginName"] ? [loginDict objectForKey:@"UserLoginName"] : @"";
        
        NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
        NSString * key = [NSString stringWithFormat:@"%@_%@", Account, kCacheInvoice];
        self.invoiceInfo = [def objectForKey:key];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发票信息";
    [self setLeftButton:[UIImage imageNamed:@"btn_back_recharge.png"]];
    {
        UIImage * img = [UIImage imageNamed:@"huidi.png"];
        UIImageView * bgview = [[UIImageView alloc] initWithImage:[img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height/2, img.size.width/2, img.size.height/2, img.size.width/2)]];
//        bgview.frame = CGRectMake(10, CGRectGetMaxY(_navbar.frame), CGRectGetWidth(self.view.frame) - 20, CGRectGetHeight(self.view.frame) - CGRectGetMaxY(_navbar.frame) - 15 - kCTPTabbarHeight);
         bgview.frame = CGRectMake(10, 0, CGRectGetWidth(self.view.frame) - 20, CGRectGetHeight(self.view.frame) -15-49 - 40);
        [self.view addSubview:bgview];
        _greyBgView     = bgview;
        
        UIScrollView * scrollview = [[UIScrollView alloc] initWithFrame:CGRectInset(bgview.frame, 5, 5)];
        scrollview.backgroundColor = [UIColor clearColor];
        [self.view addSubview:scrollview];
        _contentScroll = scrollview;
        
        [bgview release];
        [scrollview release];
    }
    
    int yOffset = 0;
    {
        yOffset = 8;
        { 
            UIImageView * imgBackground = [[UIImageView alloc] initWithFrame:CGRectMake(10, yOffset, _contentScroll.frame.size.width - 10 * 2, 70)];
            [imgBackground dwMakeRoundCornerWithRadius:5];
            imgBackground.backgroundColor = [UIColor whiteColor];
            [_contentScroll addSubview:imgBackground];
            [imgBackground release];
        }
        
        {
            yOffset += 5;
            UILabel*  labTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, yOffset, _contentScroll.frame.size.width / 2, 24)];
            labTitle.backgroundColor = [UIColor clearColor];
            labTitle.font     = [UIFont  systemFontOfSize:18];
            labTitle.textColor= [UIColor darkTextColor];
            labTitle.textAlignment = UITextAlignmentLeft;
            labTitle.text = @"发票类型";
            [_contentScroll addSubview:labTitle];
            yOffset += labTitle.frame.size.height;
            [labTitle release];
        }
        
        {
            yOffset += 5;
            UIImageView* divLine = [[UIImageView alloc] initWithFrame:CGRectMake(20,yOffset,_contentScroll.frame.size.width - 20 * 2,2)];
            divLine.image = [UIImage imageNamed:@"div_line.png"];
            [_contentScroll addSubview:divLine];
            yOffset += 2;
            [divLine release];
        }
        
        {
            yOffset += 2;
            UIButton* btncheck = [UIButton buttonWithType:UIButtonTypeCustom];
            btncheck.frame     = CGRectMake(20,yOffset,150,30);
            btncheck.tag       = tagInvoiceTypeCheckButton;
            [btncheck setImage:[UIImage imageNamed:@"btn_check_y.png"]
                      forState:UIControlStateNormal];
            UIEdgeInsets imgInset = UIEdgeInsetsMake(4,0,4,130);
            [btncheck setImageEdgeInsets:imgInset];
            [btncheck addTarget:self action:@selector(onCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_contentScroll addSubview:btncheck];
            
            UILabel* labContent = [[UILabel alloc] initWithFrame:CGRectMake(30,2,120,24)];
            labContent.backgroundColor = [UIColor clearColor];
            labContent.font     = [UIFont  systemFontOfSize:18];
            labContent.textColor= [UIColor darkTextColor];
            labContent.textAlignment = UITextAlignmentLeft;
            labContent.text      = @"普通发票";
            [btncheck addSubview:labContent];
            [labContent release];
            
        }

    }
    
    {
        yOffset += 45;
        {
            UIImageView * imgBackground = [[UIImageView alloc] initWithFrame:CGRectMake(10, yOffset, _contentScroll.frame.size.width - 10 * 2, 72 + 40)];
            [imgBackground dwMakeRoundCornerWithRadius:5];
            imgBackground.backgroundColor = [UIColor whiteColor];
            [_contentScroll addSubview:imgBackground];
            [imgBackground release];
        }
        
        {
            yOffset += 5;
            UILabel*  labTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, yOffset, _contentScroll.frame.size.width / 2, 24)];
            labTitle.backgroundColor = [UIColor clearColor];
            labTitle.font     = [UIFont  systemFontOfSize:18];
            labTitle.textColor= [UIColor darkTextColor];
            labTitle.textAlignment = UITextAlignmentLeft;
            labTitle.text = @"发票抬头";
            [_contentScroll addSubview:labTitle];
            yOffset += labTitle.frame.size.height;
            [labTitle release];
        }
        
        {
            yOffset += 5;
            UIImageView* divLine = [[UIImageView alloc] initWithFrame:CGRectMake(20,yOffset,_contentScroll.frame.size.width - 20 * 2,2)];
            divLine.image = [UIImage imageNamed:@"div_line.png"];
            [_contentScroll addSubview:divLine];
            yOffset += 2;
            [divLine release];
        }
        
        {
            yOffset += 2;
            UIButton* btncheck = [UIButton buttonWithType:UIButtonTypeCustom];
            btncheck.frame     = CGRectMake(20,yOffset,130,30);
            btncheck.tag       = tagPersonalCheckButton;
            [btncheck setImage:[UIImage imageNamed:@"btn_check_y.png"]
                      forState:UIControlStateNormal];
            UIEdgeInsets imgInset = UIEdgeInsetsMake(4,0,4,110);
            [btncheck setImageEdgeInsets:imgInset];
            [btncheck addTarget:self action:@selector(onCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_contentScroll addSubview:btncheck];
            
            UILabel* labContent = [[UILabel alloc] initWithFrame:CGRectMake(30,2,100,24)];
            labContent.backgroundColor = [UIColor clearColor];
            labContent.font     = [UIFont  systemFontOfSize:18];
            labContent.textColor= [UIColor darkTextColor];
            labContent.textAlignment = UITextAlignmentLeft;
            labContent.text      = @"个人";
            [btncheck addSubview:labContent];
            [labContent release];
            
        }
        
        {
            UIButton* btncheck = [UIButton buttonWithType:UIButtonTypeCustom];
            btncheck.frame     = CGRectMake(150,yOffset,130,30);
            btncheck.tag       = tagCompanyCheckButton;
            [btncheck setImage:[UIImage imageNamed:@"btn_check_n.png"]
                      forState:UIControlStateNormal];
            UIEdgeInsets imgInset = UIEdgeInsetsMake(4,0,4,110);
            [btncheck setImageEdgeInsets:imgInset];
            [btncheck addTarget:self action:@selector(onCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_contentScroll addSubview:btncheck];
            
            UILabel* labContent = [[UILabel alloc] initWithFrame:CGRectMake(30,2,100,24)];
            labContent.backgroundColor = [UIColor clearColor];
            labContent.font     = [UIFont  systemFontOfSize:18];
            labContent.textColor= [UIColor darkTextColor];
            labContent.textAlignment = UITextAlignmentLeft;
            labContent.text      = @"单位";
            [btncheck addSubview:labContent];
            yOffset             += CGRectGetHeight(btncheck.frame) + 4;
            [labContent release];
            
        }
        
        {
            UITextField* textfield = [[UITextField alloc] initWithFrame:CGRectMake(20, yOffset, CGRectGetWidth(_contentScroll.frame) - 40, 32)];
            textfield.placeholder  = @"请输入抬头";
            textfield.textColor    = [UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            textfield.font         = [UIFont systemFontOfSize:14];
            [textfield dwMakeRoundCornerWithRadius:5];
            textfield.backgroundColor = [UIColor colorWithRed:235/255. green:235/255. blue:235/255. alpha:1];
            textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textfield.returnKeyType = UIReturnKeyDone;
            textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
            textfield.delegate      = (id<UITextFieldDelegate>)self;
            {
                UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
                mView.backgroundColor = [UIColor clearColor];
                textfield.leftView = mView;
                textfield.leftViewMode = UITextFieldViewModeAlways;
                [mView release];
            }
            [_contentScroll addSubview:textfield];
            yOffset                 = CGRectGetMaxY(textfield.frame) + 20;
            _tfOrgName              = textfield;
            [textfield release];
        }
        
    }
    
    {
        // 发票内容改成与接口一致  modified by zy
        {
            UIImageView * imgBackground = [[UIImageView alloc] initWithFrame:CGRectMake(10, yOffset, _contentScroll.frame.size.width - 10 * 2, /*105*/70)];
            [imgBackground dwMakeRoundCornerWithRadius:5];
            imgBackground.backgroundColor = [UIColor whiteColor];
            [_contentScroll addSubview:imgBackground];
            [imgBackground release];
        }
        
        {
            yOffset += 5;
            UILabel*  labTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, yOffset, _contentScroll.frame.size.width / 2, 24)];
            labTitle.backgroundColor = [UIColor clearColor];
            labTitle.font     = [UIFont  systemFontOfSize:18];
            labTitle.textColor= [UIColor darkTextColor];
            labTitle.textAlignment = UITextAlignmentLeft;
            labTitle.text = @"发票内容";//@"非图书商品";
            [_contentScroll addSubview:labTitle];
            yOffset += labTitle.frame.size.height;
            [labTitle release];
        }
        
        {
            yOffset += 5;
            UIImageView* divLine = [[UIImageView alloc] initWithFrame:CGRectMake(20,yOffset,_contentScroll.frame.size.width - 20 * 2,2)];
            divLine.image = [UIImage imageNamed:@"div_line.png"];
            [_contentScroll addSubview:divLine];
            yOffset += 2;
            [divLine release];
        }
        
        {
            yOffset += 2;
            UIButton* btncheck = [UIButton buttonWithType:UIButtonTypeCustom];
            btncheck.frame     = CGRectMake(20,yOffset,130,30);
            btncheck.tag       = tagDetailCheckButton;
            [btncheck setImage:[UIImage imageNamed:@"btn_check_y.png"]
                      forState:UIControlStateNormal];
            UIEdgeInsets imgInset = UIEdgeInsetsMake(4,0,4,110);
            [btncheck setImageEdgeInsets:imgInset];
            [btncheck addTarget:self action:@selector(onCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_contentScroll addSubview:btncheck];
            
            UILabel* labContent = [[UILabel alloc] initWithFrame:CGRectMake(30,2,100,24)];
            labContent.backgroundColor = [UIColor clearColor];
            labContent.font     = [UIFont  systemFontOfSize:18];
            labContent.textColor= [UIColor darkTextColor];
            labContent.textAlignment = UITextAlignmentLeft;
            labContent.text      = @"通信器材";//@"明细";
            [btncheck addSubview:labContent];
            [labContent release];
            
        }
        
        {
            UIButton* btncheck = [UIButton buttonWithType:UIButtonTypeCustom];
            btncheck.frame     = CGRectMake(150,yOffset,130,30);
            btncheck.tag       = tagComputerFittingCheckButton;
            [btncheck setImage:[UIImage imageNamed:@"btn_check_n.png"]
                      forState:UIControlStateNormal];
            UIEdgeInsets imgInset = UIEdgeInsetsMake(4,0,4,110);
            [btncheck setImageEdgeInsets:imgInset];
            [btncheck addTarget:self action:@selector(onCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_contentScroll addSubview:btncheck];
            
            UILabel* labContent = [[UILabel alloc] initWithFrame:CGRectMake(30,2,100,24)];
            labContent.backgroundColor = [UIColor clearColor];
            labContent.font     = [UIFont  systemFontOfSize:18];
            labContent.textColor= [UIColor darkTextColor];
            labContent.textAlignment = UITextAlignmentLeft;
            labContent.text      = @"商品明细";//@"电脑配件";
            [btncheck addSubview:labContent];
            [labContent release];
            
        }
        
#if 0
        {
            yOffset += 34;
            UIButton* btncheck = [UIButton buttonWithType:UIButtonTypeCustom];
            btncheck.frame     = CGRectMake(20,yOffset,240,30);
            btncheck.tag       = tagSuppliesCheckButton;
            [btncheck setImage:[UIImage imageNamed:@"btn_check_n.png"]
                      forState:UIControlStateNormal];
            UIEdgeInsets imgInset = UIEdgeInsetsMake(4,0,4,220);
            [btncheck setImageEdgeInsets:imgInset];
            [btncheck addTarget:self action:@selector(onCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_contentScroll addSubview:btncheck];
            
            UILabel* labContent = [[UILabel alloc] initWithFrame:CGRectMake(30,2,210,24)];
            labContent.backgroundColor = [UIColor clearColor];
            labContent.font     = [UIFont  systemFontOfSize:18];
            labContent.textColor= [UIColor darkTextColor];
            labContent.textAlignment = UITextAlignmentLeft;
            labContent.text      = @"办公用品(附购物清单)";
            [btncheck addSubview:labContent];
            [labContent release];
            
        }
#endif
        
    }
    
    
    {
        yOffset += 45;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, yOffset, _contentScroll.frame.size.width - 60, 44);
        button.tag       = tagSaveInfoButton;
        button.backgroundColor = [UIColor colorWithRed:39/255. green:169/255. blue:37/255. alpha:1];
//        kRGBUIColor(39, 169, 37, 1);
        [button dwMakeRoundCornerWithRadius:5];
        [button setTitle:@"储存发票信息" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onSaveInvoiceInfo:) forControlEvents:UIControlEventTouchUpInside];
        yOffset += button.frame.size.height;
        [_contentScroll addSubview:button];

    }
    
    [self setInitInvoiceinfo];  // added by zy
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    _greyBgView = nil;
    _contentScroll = nil;


}

- (void)dealloc
{
    [_invoiceItem release];
    
    if (_salesProductInfoDict)
    {
        [_salesProductInfoDict release];
    }
    
    if (_orderInfoDict)
    {
        [_orderInfoDict release];
    }
    
    if (_deliveryInfo)
    {
        [_deliveryInfo release];
    }
    
    if (_customerInfo)
    {
        [_customerInfo release];
    }
    
    self.invoiceInfo = nil;
    self.PackageInfoDict = nil;
    self.ContractInfo = nil;

    [super dealloc];
}

-(void)setProductOrderInfo:(NSDictionary *)saleDict
                 orderInfo:(NSDictionary *)orderDict
               deliverInfo:(NSDictionary *)deliveryDict
              customerInfo:(NSDictionary *)customerDict
{
    if (saleDict)
    {
        self._salesProductInfoDict = saleDict;
    }
    
    if (orderDict)
    {
        self._orderInfoDict = orderDict;
    }
    
    if (deliveryDict)
    {
        self._deliveryInfo = deliveryDict;
    }
    
    if (customerDict)
    {
        self._customerInfo = customerDict;
    }
}

-(NSDictionary*)getInvoiceInfo
{
   NSDictionary* info = [[[NSDictionary alloc] initWithObjectsAndKeys:
                          ([_tfOrgName.text length] ? _tfOrgName.text : @""), @"InvoiceInfo",  // added by zy 发票抬头
                          [NSString stringWithFormat:@"%d", _invoiceItem._invoiceType],@"InvoiceType",
                          [NSString stringWithFormat:@"%d", _invoiceItem._invoiceTitle], @"InvoiceInfoType",
                          [NSString stringWithFormat:@"%d", _invoiceItem._itemListType], @"InvoiceContentType",nil] autorelease];
    return info;
}

#pragma mark private

-(void)onCheckBtn:(id)sender
{
    UIButton* btnCheck = (UIButton *)sender;
    if (!btnCheck) {
        return;
    }
    
    switch (btnCheck.tag)
    {
        case tagInvoiceTypeCheckButton:
        {
            //[btnCheck setImage:[UIImage imageNamed:@"btn_check_n.png"] forState:UIControlStateNormal];
        }
            break;
        case tagPersonalCheckButton:
        {
            _invoiceItem._invoiceTitle = 0;
            for (int i = 0; i < 2; i++)
            {
                UIButton* btnCheck = (UIButton*)[_contentScroll viewWithTag:(tagPersonalCheckButton + i)];
                if (_invoiceItem._invoiceTitle == i)
                {
                    [btnCheck setImage:[UIImage imageNamed:@"btn_check_y.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnCheck setImage:[UIImage imageNamed:@"btn_check_n.png"] forState:UIControlStateNormal];
                }
            }
        }
            break;
        case tagCompanyCheckButton:
        {
            _invoiceItem._invoiceTitle = 1;
            
            for (int i = 0; i < 2; i++)
            {
                UIButton* btnCheck = (UIButton*)[_contentScroll viewWithTag:(tagPersonalCheckButton + i)];
                if (_invoiceItem._invoiceTitle == i)
                {
                    [btnCheck setImage:[UIImage imageNamed:@"btn_check_y.png"] forState:UIControlStateNormal];
                }
                else
                {
                     [btnCheck setImage:[UIImage imageNamed:@"btn_check_n.png"] forState:UIControlStateNormal];
                }
            }
        }
            break;
        case tagDetailCheckButton:
        {
            _invoiceItem._itemListType = 0;
            for (int i = 0; i < 3; i++)
            {
                UIButton* btnCheck = (UIButton*)[_contentScroll viewWithTag:(tagDetailCheckButton + i)];
                if (_invoiceItem._itemListType == i)
                {
                    [btnCheck setImage:[UIImage imageNamed:@"btn_check_y.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnCheck setImage:[UIImage imageNamed:@"btn_check_n.png"] forState:UIControlStateNormal];
                }
            }
        }
            break;
        case tagComputerFittingCheckButton:
        {
            _invoiceItem._itemListType = 1;
            for (int i = 0; i < 3; i++)
            {
                UIButton* btnCheck = (UIButton*)[_contentScroll viewWithTag:(tagDetailCheckButton + i)];
                if (_invoiceItem._itemListType == i)
                {
                    [btnCheck setImage:[UIImage imageNamed:@"btn_check_y.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnCheck setImage:[UIImage imageNamed:@"btn_check_n.png"] forState:UIControlStateNormal];
                }
            }
        }
            break;
        case tagSuppliesCheckButton:
        {
            _invoiceItem._itemListType = 2;
            
            for (int i = 0; i < 3; i++)
            {
                UIButton* btnCheck = (UIButton*)[_contentScroll viewWithTag:(tagDetailCheckButton + i)];
                if (_invoiceItem._itemListType == i)
                {
                    [btnCheck setImage:[UIImage imageNamed:@"btn_check_y.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnCheck setImage:[UIImage imageNamed:@"btn_check_n.png"] forState:UIControlStateNormal];
                }
            }
        }
            break;
        case tagSaveInfoButton:
        {
            
        }
            break;
            
        default:
            break;
    } 

}

-(void)onSaveInvoiceInfo:(id)sender
{
    {
        NSDictionary *loginDict = [Global sharedInstance].loginInfoDict;
        NSString *Account = [loginDict objectForKey:@"UserLoginName"] ? [loginDict objectForKey:@"UserLoginName"] : @"";
        
        NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
        NSString * key = [NSString stringWithFormat:@"%@_%@", Account, kCacheInvoice];
        [def setObject:[self getInvoiceInfo] forKey:key];
        [def synchronize];
    }
    
    // added by zy
    if (self.isModifyInvoiceinfo)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:CTP_MSG_MODIFY_INVOICE_INFO object:[self getInvoiceInfo]];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    CTPOrderConfirmVCtler * vctler = [CTPOrderConfirmVCtler new];
    vctler.salesProductInfoDict = _salesProductInfoDict;
    vctler.orderInfoDict = _orderInfoDict;
    vctler.DeliveryInfo = _deliveryInfo;
    vctler.InvoiceInfo = [self getInvoiceInfo];
    vctler.CustomerInfo = _customerInfo;
    vctler.ContractInfo = self.ContractInfo;
    vctler.PackageInfoDict = self.PackageInfoDict;
    [self.navigationController pushViewController:vctler animated:YES];
    [vctler release];
}

#pragma mark --
- (void)setInitInvoiceinfo
{
    if (!self.invoiceInfo)
    {
        return;
    }
    
    NSString * aInvoiceInfo = [self.invoiceInfo objectForKey:@"InvoiceInfoType"] ? [self.invoiceInfo objectForKey:@"InvoiceInfoType"] : @"";
    NSString * InvoiceContentType  = [self.invoiceInfo objectForKey:@"InvoiceContentType"] ? [self.invoiceInfo objectForKey:@"InvoiceContentType"] : @"";
    NSString * orgname = [self.invoiceInfo objectForKey:@"InvoiceInfo"] ? [self.invoiceInfo objectForKey:@"InvoiceInfo"] : @"";
    _tfOrgName.text = orgname;
    
    if ([aInvoiceInfo intValue] == 0)
    {
        UIButton * btn = (UIButton *)[_contentScroll viewWithTag:tagPersonalCheckButton];
        [self onCheckBtn:btn];
    }
    else if ([aInvoiceInfo intValue] == 1)
    {
        UIButton * btn = (UIButton *)[_contentScroll viewWithTag:tagCompanyCheckButton];
        [self onCheckBtn:btn];
    }
    
    if ([InvoiceContentType intValue] == 0)
    {
        UIButton * btn = (UIButton *)[_contentScroll viewWithTag:tagDetailCheckButton];
        [self onCheckBtn:btn];
    }
    else if ([InvoiceContentType intValue] == 1)
    {
        UIButton * btn = (UIButton *)[_contentScroll viewWithTag:tagComputerFittingCheckButton];
        [self onCheckBtn:btn];
    }
}

#pragma mark UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
@end
