//
//  CTPProtocolFillVCtler.m
//  CTPocketv3
//
//  Created by apple on 13-5-8.
//
//

#import "CTPProtocolFillVCtler.h"
#import "UIView+RoundRect.h"
#import "UIView+BounceAnimation.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "CTPNewAddrVCtler.h"
#import "ToastAlertView.h"
#import "SIAlertView.h"

#define kBarHeight 49
@interface CTPProtocolFillVCtler ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *bottomView;

- (void)onChekupBtn:(id)sender;
- (void)onSaveBtn:(id)sender;
- (void)onBgBtn:(id)sender;
- (void)onNavigationBarPrevBtn:(id)sender;
- (void)onNavigationBarNextBtn:(id)sender;
- (void)onNavigationBarConfirmBtn:(id)sender;

@end

@implementation CTPProtocolFillVCtler

@synthesize SalesproductInfoDict;
@synthesize PackageInfoDict;
@synthesize orderInfoDict;
@synthesize ContractInfo;
@synthesize NumberInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
//        if (!((AppDelegate *)[UIApplication sharedApplication].delegate).mainVctler.isTabbarHidden)
//        {
//            [[NSNotificationCenter defaultCenter] postNotificationName:CTP_MSG_HIDE_TABBAR object:nil];
//        }
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%@ dealloc", [self class]);
    self.SalesproductInfoDict = nil;
    self.PackageInfoDict = nil;
    self.orderInfoDict = nil;
    self.ContractInfo = nil;
    self.NumberInfo = nil;
    [_textfieldNaviBar release], _textfieldNaviBar = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"入网信息";
    [self setLeftButton:[UIImage imageNamed:@"btn_back_recharge.png"]];
    self.view.backgroundColor = [UIColor whiteColor];

    {
        UIImage * img   = [UIImage imageNamed:@"huidi.png"];
        UIImageView * bgview = [[UIImageView alloc] initWithImage:[img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height/2, img.size.width/2, img.size.height/2, img.size.width/2)]];
        bgview.frame    = CGRectMake(10,0, CGRectGetWidth(self.view.frame) - 20, CGRectGetHeight(self.view.frame) - 35 - 49);
        [self.view addSubview:bgview];
        _greyBgView     = bgview;
        
        UIScrollView * scrollview = [[UIScrollView alloc] initWithFrame:CGRectInset(bgview.frame, 5, 5)];
        scrollview.backgroundColor = [UIColor clearColor];
        [self.view addSubview:scrollview];
        _contentScroll = scrollview;
        
        [bgview release];
        [scrollview release];
    }
    {
#define kTextfieldTag   10
        int tftag    = kTextfieldTag;
        int interval = 10;
        int originX = interval;
        int originY = 10;
        int height  = 38;
        {
            UILabel * lab       = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, CGRectGetWidth(_contentScroll.frame) - 2*originX, 18)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font            = [UIFont systemFontOfSize:14];
            lab.textColor       = [UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            lab.textAlignment   = UITextAlignmentLeft;
            lab.numberOfLines   = 0;
            lab.text            = @"为了顺利完成入网操作，请准确填写机主信息(注: 如果机主不是您本人，请填写机主信息，而非您的信息)";
            [lab sizeToFit];
            lab.frame           = CGRectMake(lab.frame.origin.x, lab.frame.origin.y, lab.frame.size.width, MAX(18, lab.frame.size.height));
            [_contentScroll addSubview:lab];
            originY             = CGRectGetMaxY(lab.frame) + 10;
            [lab release];
        }
        {
            originX             = interval;
            UILabel * lab       = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, 68, height)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font            = [UIFont systemFontOfSize:14];
            lab.textColor       = [UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            lab.textAlignment   = UITextAlignmentRight;
            lab.text            = @"客户姓名: ";
            [_contentScroll addSubview:lab];
            originX             = CGRectGetMaxX(lab.frame) + 5;
            [lab release];
            
            UITextField* textfield = [[UITextField alloc] initWithFrame:CGRectMake(originX, originY, CGRectGetWidth(_contentScroll.frame) - originX - interval, height)];
            textfield.placeholder  = @"请输入真实姓名";
            textfield.textColor    = [UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            textfield.font         = [UIFont systemFontOfSize:14];
            [textfield dwMakeRoundCornerWithRadius:5];
            textfield.backgroundColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1];
            textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textfield.returnKeyType = UIReturnKeyNext;
            textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
            textfield.delegate      = (id<UITextFieldDelegate>)self;
            textfield.tag           = tftag++;
            {
                UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
                mView.backgroundColor = [UIColor clearColor];
                textfield.leftView = mView;
                textfield.leftViewMode = UITextFieldViewModeAlways;
                [mView release];
            }
            [_contentScroll addSubview:textfield];
            originY                 = CGRectGetMaxY(textfield.frame) + 10;
            _nameText               = textfield;
            [textfield release];
        }
        {
            originX             = interval;
            UILabel * lab       = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, 68, height)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font            = [UIFont systemFontOfSize:14];
            lab.textColor       = [UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            lab.textAlignment   = UITextAlignmentRight;
            lab.text            = @"身份证: ";
            [_contentScroll addSubview:lab];
            originX             = CGRectGetMaxX(lab.frame) + 5;
            [lab release];
            
            UITextField* textfield = [[UITextField alloc] initWithFrame:CGRectMake(originX, originY, CGRectGetWidth(_contentScroll.frame) - originX - interval, height)];
            textfield.placeholder  = @"请输入对应的身份证号码";
            textfield.textColor    = [UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            textfield.font         = [UIFont systemFontOfSize:14];
            textfield.keyboardType = UIKeyboardTypeASCIICapable;
            [textfield dwMakeRoundCornerWithRadius:5];
            textfield.backgroundColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1];
            textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textfield.returnKeyType = UIReturnKeyNext;
            textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
            textfield.delegate      = (id<UITextFieldDelegate>)self;
            textfield.tag           = tftag++;
            textfield.keyboardType  = UIKeyboardTypeNumbersAndPunctuation;  // added by zy, 2014-02-19
            {
                UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
                mView.backgroundColor = [UIColor clearColor];
                textfield.leftView = mView;
                textfield.leftViewMode = UITextFieldViewModeAlways;
                [mView release];
            }
            [_contentScroll addSubview:textfield];
            originY                 = CGRectGetMaxY(textfield.frame) + 10;
            _idText                 = textfield;
            [textfield release];
        }
        {
            originX             = interval;
            UILabel * lab       = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, 68, height)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font            = [UIFont systemFontOfSize:14];
            lab.textColor       = [UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            lab.textAlignment   = UITextAlignmentRight;
            lab.text            = @"联系地址: ";
            [_contentScroll addSubview:lab];
            originX             = CGRectGetMaxX(lab.frame) + 5;
            [lab release];
            
            UITextField* textfield = [[UITextField alloc] initWithFrame:CGRectMake(originX, originY, CGRectGetWidth(_contentScroll.frame) - originX - interval, height)];
            textfield.placeholder  = @"请输入联系地址";
            textfield.textColor    = [UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            textfield.font         = [UIFont systemFontOfSize:14];
            [textfield dwMakeRoundCornerWithRadius:5];
            textfield.backgroundColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1];
            textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textfield.returnKeyType = UIReturnKeyNext;
            textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
            textfield.delegate      = (id<UITextFieldDelegate>)self;
            textfield.tag           = tftag++;
            {
                UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
                mView.backgroundColor = [UIColor clearColor];
                textfield.leftView = mView;
                textfield.leftViewMode = UITextFieldViewModeAlways;
                [mView release];
            }
            [_contentScroll addSubview:textfield];
            originY                 = CGRectGetMaxY(textfield.frame) + 10;
            _addrText               = textfield;
            [textfield release];
        }
        {
            originX             = interval;
            UILabel * lab       = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, 68, height)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font            = [UIFont systemFontOfSize:14];
            lab.textColor       = [UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            lab.textAlignment   = UITextAlignmentRight;
            lab.text            = @"邮政编码: ";
            [_contentScroll addSubview:lab];
            originX             = CGRectGetMaxX(lab.frame) + 5;
            [lab release];
            
            UITextField* textfield = [[UITextField alloc] initWithFrame:CGRectMake(originX, originY, CGRectGetWidth(_contentScroll.frame) - originX - interval, height)];
            textfield.placeholder  = @"请输入邮政编码";
            textfield.textColor    = [UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            textfield.font         = [UIFont systemFontOfSize:14];
            textfield.keyboardType = UIKeyboardTypeNumberPad;
            [textfield dwMakeRoundCornerWithRadius:5];
            textfield.backgroundColor = [UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:1];
            textfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            textfield.returnKeyType = UIReturnKeyNext;
            textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
            textfield.delegate      = (id<UITextFieldDelegate>)self;
            textfield.tag           = tftag++;
            {
                UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
                mView.backgroundColor = [UIColor clearColor];
                textfield.leftView = mView;
                textfield.leftViewMode = UITextFieldViewModeAlways;
                [mView release];
            }
            [_contentScroll addSubview:textfield];
            originY                 = CGRectGetMaxY(textfield.frame) + 10;
            _postcodeText               = textfield;
            [textfield release];
        }
        {
        
            originX           = interval;
            UIImage * img_en  = [UIImage imageNamed:@"btn_check_n.png"];
            UIImage * img_sel = [UIImage imageNamed:@"btn_check_y.png"];
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame      = CGRectMake(originX, originY, 60, 38);
            [btn addTarget:self action:@selector(onChekupBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            [btn setImage:img_en forState:UIControlStateNormal];
            [btn setImage:img_sel forState:UIControlStateSelected];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, (CGRectGetHeight(btn.frame) - 15) - 5, CGRectGetWidth(btn.frame) - 15)];
            [_contentScroll addSubview:btn];
            _checkBtn       = btn;
            _checkBtn.selected = YES;
            
            UILabel * lab       = [[UILabel alloc] initWithFrame:CGRectMake(40, originY, CGRectGetWidth(_contentScroll.frame) - 40 - interval, height)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font            = [UIFont systemFontOfSize:14];
            lab.textColor       =  [UIColor blueColor] ;//[UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            lab.textAlignment   = UITextAlignmentLeft;
            lab.numberOfLines   = 0;
            lab.text            = @"阅读并同意入网协议《中国电信股份有";
            [lab sizeToFit];
            lab.frame           = CGRectMake(lab.frame.origin.x, lab.frame.origin.y, lab.frame.size.width, lab.frame.size.height);
            [_contentScroll addSubview:lab];
            originY             = MAX(CGRectGetMaxY(btn.frame), CGRectGetMaxY(lab.frame)) + 10;
            
            
            UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lab.frame)+1, CGRectGetWidth(_contentScroll.frame) - 40 - interval, 1)];
            sepView.backgroundColor = [UIColor blueColor];
            [_contentScroll addSubview:sepView];
            
            UILabel * lab1       = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lab.frame)+3, CGRectGetWidth(_contentScroll.frame) - 40 - interval, height)];
            lab1.backgroundColor = [UIColor clearColor];
            lab1.font            = [UIFont systemFontOfSize:14];
            lab1.textColor       =  [UIColor blueColor] ;//[UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            lab1.textAlignment   = UITextAlignmentLeft;
            lab1.numberOfLines   = 0;
            lab1.text            = @"限公司业务服务协议》";
            [lab1 sizeToFit];
            lab1.frame           = CGRectMake(lab1.frame.origin.x, lab1.frame.origin.y, lab1.frame.size.width, lab1.frame.size.height);
            [_contentScroll addSubview:lab1];
            originY             = MAX(CGRectGetMaxY(btn.frame), CGRectGetMaxY(lab.frame)) + 10;
            
            UIView *sepView1 = [[UIView alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(lab1.frame)+1, CGRectGetWidth(_contentScroll.frame) - 40 - interval - 100, 1)];
            sepView1.backgroundColor = [UIColor blueColor];
            [_contentScroll addSubview:sepView1];
            
            UIButton *btnpro = [UIButton buttonWithType:UIButtonTypeCustom];
//            btnpro.backgroundColor = [UIColor redColor];
            [btnpro addTarget:self action:@selector(showProtocol) forControlEvents:UIControlEventTouchUpInside];
            btnpro.frame = CGRectMake(40, CGRectGetMinY(lab.frame),CGRectGetWidth(_contentScroll.frame) - 40 - interval, 40);
            [_contentScroll addSubview:btnpro];
            
            [lab release];
            [sepView release];
            [sepView1 release];
            [lab1 release];
        }
        {
            originY             += 5;
            UIImage * img       = [UIImage imageNamed:@"query_btn.png"];
            UIImage * himg      = [UIImage imageNamed:@"query_btn_highlight.png"];
            UIButton * btn      = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame           = CGRectMake(30, originY, CGRectGetWidth(_contentScroll.frame) - 60, height);
            [btn setBackgroundImage:[img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height/2, img.size.width/2, img.size.height/2, img.size.width/2)] forState:UIControlStateNormal];
            [btn setBackgroundImage:[himg resizableImageWithCapInsets:UIEdgeInsetsMake(himg.size.height/2, himg.size.width/2, himg.size.height/2, himg.size.width/2)] forState:UIControlStateHighlighted];
            [btn setBackgroundImage:[himg resizableImageWithCapInsets:UIEdgeInsetsMake(himg.size.height/2, himg.size.width/2, himg.size.height/2, himg.size.width/2)] forState:UIControlStateDisabled];
            [btn setTitle:@"保存入网信息" forState:UIControlStateNormal];
            [btn setTitle:@"" forState:UIControlStateDisabled];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
            [btn addTarget:self action:@selector(onSaveBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_contentScroll addSubview:btn];
            originY             = CGRectGetMaxY(btn.frame) + 15;
        }
        {
            UILabel * lab       = [[UILabel alloc] initWithFrame:CGRectMake(originX, originY, CGRectGetWidth(_contentScroll.frame) - 2*originX, 18)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font            = [UIFont systemFontOfSize:12];
            lab.textColor       = [UIColor colorWithRed:36/255. green:36/255. blue:36/255. alpha:1];
            lab.textAlignment   = UITextAlignmentLeft;
            lab.numberOfLines   = 0;
            lab.text            = @"注意: 您在签收时必须提供本人身份证原件和复印件，复印件作为入网资料在配送时收回";
            [lab sizeToFit];
            lab.frame           = CGRectMake(lab.frame.origin.x, lab.frame.origin.y, lab.frame.size.width, MAX(18, lab.frame.size.height));
            [_contentScroll addSubview:lab];
            originY             = CGRectGetMaxY(lab.frame) + 10;
            [lab release];
        }
        
        {
            UIButton * btn      = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame           = CGRectMake(0, 0, CGRectGetWidth(_contentScroll.frame), MAX(CGRectGetHeight(_contentScroll.frame), originY));
            [btn addTarget:self action:@selector(onBgBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_contentScroll addSubview:btn];
            [_contentScroll sendSubviewToBack:btn];
        }
        
        {
            UINavigationBar * navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            navbar.barStyle = UIBarStyleBlackTranslucent;
            //add by liuruxian 2014-02-28
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            {
                navbar.barTintColor = [UIColor colorWithRed:(9*16+7)/255. green:(9*16+7)/255. blue:(9*16+7)/255. alpha:1];
            }
            _textfieldNaviBar = navbar;
            
#define kBarItemTag     100
            int bartag = kBarItemTag;
            UINavigationItem * navitems = [[UINavigationItem alloc] init];
            UIBarButtonItem * prevbtn = [[UIBarButtonItem alloc] initWithTitle:@"上一项" style:UIBarButtonItemStyleBordered target:self action:@selector(onNavigationBarPrevBtn:)];
            prevbtn.tag               = bartag++;
            //add by liuruxian 2014-02-28
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
                prevbtn.tintColor = [UIColor whiteColor];
            }
            
            UIBarButtonItem * nextbtn = [[UIBarButtonItem alloc] initWithTitle:@"下一项" style:UIBarButtonItemStyleBordered target:self action:@selector(onNavigationBarNextBtn:)];
            nextbtn.tag               = bartag++;
            //add by liuruxian 2014-02-28
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
                nextbtn.tintColor = [UIColor whiteColor];
            }
            
            UIBarButtonItem * confirmbtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(onNavigationBarConfirmBtn:)];
            confirmbtn.tag            = bartag++;
            //add by liuruxian 2014-02-28
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            {
                confirmbtn.tintColor = [UIColor whiteColor];
            }
            
            [navitems setLeftBarButtonItems:[NSArray arrayWithObjects:prevbtn, nextbtn, nil]];
            [navitems setRightBarButtonItems:[NSArray arrayWithObjects:confirmbtn, nil]];
            [navbar pushNavigationItem:navitems animated:NO];
            
            [navitems release];
            [confirmbtn release];
            [prevbtn release];
            [nextbtn release];
        }
        
        _contentScroll.contentSize  = CGSizeMake(CGRectGetWidth(_contentScroll.frame), originY+30);
    }
    
    [self addProtocolView];
//     [self.view bringSubviewToFront:protocolView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    _greyBgView = nil;
    _contentScroll = nil;
    [_textfieldNaviBar release], _textfieldNaviBar = nil;
    _nameText = nil;
    _idText = nil;
    _addrText = nil;
    _checkBtn = nil;
    _clickView = nil;
    _postcodeText = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// 判断是否有效身份证号码
- (BOOL)isIDNumberValid:(NSString*)idnumber
{
	if ([idnumber length] != 15 &&
		[idnumber length] != 18)
	{
		return NO;
	}
	
	NSLog(@"%@",idnumber);
	int provCode = [[idnumber substringToIndex:2] intValue];
	if ( provCode < 11  ||
		(provCode > 15	&&	provCode < 21)	||
		(provCode > 23	&&	provCode < 31)	||
		(provCode > 37	&&	provCode < 41)	||
		(provCode > 46	&&	provCode < 50)	||
		(provCode > 54	&&	provCode < 61)	||
		(provCode > 65)	)
	{
		// 行政区码错误
		NSLog(@"province code error");
		return NO;
	}
	
	int len = [idnumber length];
	int year = 0;
	int month = 0;
	int day = 0;
	if (len == 15)
	{
		year = [[idnumber substringWithRange:NSMakeRange(6, 2)] intValue];
		if (year > 20)
		{
			year = 1900 + year;
		}
		else
		{
			year = 2000 + year;
		}
		
		month = [[idnumber substringWithRange:NSMakeRange(8, 2)] intValue];
		day = [[idnumber substringWithRange:NSMakeRange(10, 2)] intValue];
	}
	else if (len == 18)
	{
		year = [[idnumber substringWithRange:NSMakeRange(6, 4)] intValue];
		month = [[idnumber substringWithRange:NSMakeRange(10, 2)] intValue];
		day = [[idnumber substringWithRange:NSMakeRange(12, 2)] intValue];
	}
	if (year < 1900 ||
		year > 2200)
	{
		// 年份错误
		NSLog(@"year error");
		return NO;
	}
	
	if (month < 1 ||
		month > 12)
	{
		// 月份错误
		NSLog(@"month error");
		return NO;
	}
	
	if (day < 1 ||
		day > 31)
	{
		// 日期错误
		NSLog(@"day error");
		return NO;
	}
	
	// 检查最后一位
	NSRange xrange = [idnumber rangeOfString:@"x"];
	NSRange Xrange = [idnumber rangeOfString:@"X"];
	if ((xrange.length == 1 && xrange.location != len - 1)	||
		(Xrange.length == 1 && Xrange.location != len - 1))
	{
		NSLog(@"x position error");
		return NO;
	}
	
	if (len == 15)
	{
		return YES;
	}
	
	int Wi[17] = {7, 9, 10, 5, 8 ,4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
	int lastBit[11] = {1, 0, 'x', 9, 8, 7, 6, 5, 4, 3, 2};
	int sum = 0;
	NSMutableString * idnum18 = [[NSMutableString alloc] initWithString:idnumber];
    
	for (int i = 0; i < 17; i++)
	{
		int nVal = [[idnum18 substringWithRange:NSMakeRange(i, 1)] intValue];
		sum += nVal*Wi[i];
	}
    
	int ret = sum%11;
	NSLog(@"ret=%d",ret);
	if ((ret == 2 && [[[idnum18 substringWithRange:NSMakeRange(17, 1)] lowercaseString] isEqualToString:@"x"])	||
        lastBit[ret] == [[idnum18 substringWithRange:NSMakeRange(17, 1)] intValue])
	{
        //		[idnum18 release];
		return YES;
	}
	else
	{
		// 校验码错误
		NSLog(@"verify code error");
        //		[idnum18 release];
		return NO;
	}
	
    //	[idnum18 release];
	return NO;
}

#pragma mark -
#pragma mark - CTPNavBarDelegate
#if 0   // modified by zy, 2014-02-28
-(void)onleftBtnAction:(id)sender
#else
- (void)onLeftBtnAction:(id)sender
#endif
{
    [self onNavigationBarConfirmBtn:sender];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark private

- (void)onChekupBtn:(id)sender
{
    _checkBtn.selected = !_checkBtn.selected;
    [self onBgBtn:nil];
}

//保存地址
- (void)onSaveBtn:(id)sender
{
    [self onBgBtn:nil];
    
    NSString * UserName = _nameText.text;
    if ([UserName length] <= 0)
    {
        ToastAlertView * alert = [ToastAlertView new];
        [alert showAlertMsg:@"亲，别忘记填写姓名"];
        [alert release];
        [_nameText bounceStart];
        return;
    }
    
    NSString * custid = _idText.text;
    if ([custid length] <= 0)
    {
        ToastAlertView * alert = [ToastAlertView new];
        [alert showAlertMsg:@"请输入正确的身份证信息"];
        [alert release];
        [_idText bounceStart];
        return;
    }
    
    if (![self isIDNumberValid:custid])
    {
        ToastAlertView * alert = [ToastAlertView new];
        [alert showAlertMsg:@"请输入正确的身份证信息"];
        [alert release];
        [_idText bounceStart];
        return;
    }
    
    NSString * Address = _addrText.text;
    if ([Address length] <= 0)
    {
        ToastAlertView * alert = [ToastAlertView new];
        [alert showAlertMsg:@"亲，别忘记填写证件地址"];
        [alert release];
        [_addrText bounceStart];
        return;
    }
    
    NSString * PostCode = _postcodeText.text;
    if ([PostCode length] < 6)
    {
        ToastAlertView * alert = [ToastAlertView new];
        [alert showAlertMsg:@"请输入正确的邮政编码"];
        [alert release];
        [_postcodeText bounceStart];
        return;
    }
    
    if (!_checkBtn.selected)
    {
//        ToastAlertView * alert = [ToastAlertView new];
//        [alert showAlertMsg:@"请同意入网协议"];
//        [alert release];
        [_checkBtn bounceStart];
        return;
    }
    
    NSString * PhoneNumber  = @"";
    if ([self.NumberInfo objectForKey:@"PhoneNumber"])
    {
        PhoneNumber = [self.NumberInfo objectForKey:@"PhoneNumber"];
    }
    
    NSString * OrderId      = @"";
    if ([self.orderInfoDict objectForKey:@"OrderId"])
    {
        OrderId     = [self.orderInfoDict objectForKey:@"OrderId"];
    }
    
    if(_checkBtn.selected)
    {
        
        NSDictionary * params   = [NSDictionary dictionaryWithObjectsAndKeys:
                                   UserName, @"Cust_Name",
                                   custid, @"Idcardno",
                                   Address, @"Cust_Affress",
                                   PostCode, @"Idcard_Postcode",
                                   PhoneNumber, @"Phone_Number",
                                   OrderId, @"Order_Id",
                                   nil];
        
        CTPNewAddrVCtler * vctler   = [CTPNewAddrVCtler new];
        vctler.isSalesproduct       = YES;
        vctler.salesProductInfoDict = self.SalesproductInfoDict;
        vctler.orderInfoDict        = self.orderInfoDict;
        vctler.ContractInfo         = self.ContractInfo;
        vctler.PackageInfoDict      = self.PackageInfoDict;
        vctler.CustomerInfo         = params;
        [self.navigationController pushViewController:vctler animated:YES];
        
        [vctler release];

    }else{
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"亲,请阅读并同意入网协议"];
        alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
        
        [alertView addButtonWithTitle:@"取消"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  
                                  NSLog(@"重试");
                              }];
        
        [alertView addButtonWithTitle:@"确定"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  
                                  NSLog(@"取消");
                              }];
    }
    
    
//    NSDictionary * params   = [NSDictionary dictionaryWithObjectsAndKeys:
//                               UserName, @"Cust_Name",
//                               custid, @"Idcardno",
//                               Address, @"Cust_Affress",
//                               PostCode, @"Idcard_Postcode",
//                               PhoneNumber, @"Phone_Number",
//                               OrderId, @"Order_Id",
//                               nil];
//    
//    CTPNewAddrVCtler * vctler   = [CTPNewAddrVCtler new];
//    vctler.isSalesproduct       = YES;
//    vctler.salesProductInfoDict = self.SalesproductInfoDict;
//    vctler.orderInfoDict        = self.orderInfoDict;
//    vctler.ContractInfo         = self.ContractInfo;
//    vctler.PackageInfoDict      = self.PackageInfoDict;
//    vctler.CustomerInfo         = params;
//    [self.navigationController pushViewController:vctler animated:YES];
//    
//    [vctler release];
}
//add by lrx

- (void) addProtocolView
{
    UIView *bottomView = [[UIView alloc] initWithFrame:MyAppDelegate.window.bounds];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.5;
    bottomView.hidden = YES ;
    self.bottomView  = bottomView ;
    [MyAppDelegate.window addSubview:bottomView];
    [bottomView release];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(5, 40, MyAppDelegate.window.frame.size.width-10, MyAppDelegate.window.frame.size.height - 80)];
    bgView.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1];
    bgView.hidden = YES ;
   
    [MyAppDelegate.window addSubview:bgView];

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, 30)];
    titleView.backgroundColor = [UIColor colorWithRed:214 green:215 blue:220 alpha:1];
    [bgView addSubview:titleView];
    self.bgView = bgView;
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(titleView.frame), CGRectGetHeight(titleView.frame))];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"入网协议";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14];
        [titleView addSubview:label];
        
        [titleView release];
        [label release];
    }
    
    UIScrollView *protocolView = [[UIScrollView alloc] initWithFrame:CGRectMake(5, 30, CGRectGetWidth(bgView.frame)-10, CGRectGetHeight(bgView.frame)-80)];
    protocolView.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1];
    protocolView.alpha = 0.5 ;
    [bgView addSubview:protocolView];
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, protocolView.frame.size.width-20, protocolView.frame.size.height-20)];
        label.numberOfLines = 0;
        label.lineBreakMode = UILineBreakModeWordWrap;
        label.text = @"   中国电信股份有限公司增值业务运营中心业务服务协议\n\n   为维护双方利益，根据相关法律、法规的规定，双方在平等、自愿、公平、诚实信用的基础上，中国电信股份有限公司增值业务运营中心（以下简称“电信公司”）与客户就电信业务服务的相关事宜达成如下协议：\n\n第一条 服务范围\n\n1.1 电信公司以通信网络与设施向客户提供其所选择的服务，客户按照本协议约定的条件接受服务。\n\n第二条 业务登记\n\n2.1 客户进行业务登记时，应提交以下资料：\n2.1.1 个人客户：提供真实有效的本人身份证件原件。委托他人办理业务的，代办人应同时提供委托人、代办人的有效身份证件原件。\n2.1.2 单位客户：提供真实有效的本单位注册登记证照资料，并提供经办人有效身份证件原件。\n 2.2 客户使用客户密码通过10000号、网上服务中心、自助服务终端等登记业务时，可以不提供2.1中的资料，另有约定除外。\n\n第三条 客户资料\n\n3.1 客户登记办理业务时，应向电信公司提供真实、有效的客户资料，本协议有效期内客户资料变更时应及时通知电信公司。\n3.2 电信公司对客户资料依法保密，但为建立与客户沟通渠道，改善服务工作，电信公司可以使用本协议涉及的客户资料。\n3.3 客户密码是客户的重要资料，客户应及时修改初始密码，并注意保密。客户密码遗失或被盗时，应及时进行修改或挂失。因客户原因造成的客户密码丢失或被他人获取造成的损失，电信公司不承担责任。\n\n第四条 业务使用\n\n4.1 客户有权自主选择使用电信公司提供的各类电信业务，有权自主选择取得入网许可的终端设备。\n4.2 客户使用电信业务时，应遵守国家法律、法规、规章等相关规定。\n4.3 未经电信公司同意并办理有关手续，客户将本协议的全部或部分转让给第三方的，对电信公司不发生法律效力。\n4.4 本协议终止后，电信公司有权收回客户原使用的业务号码，并在一定期限后分配给其他客户使用。\n\n第五条 费用标准和费用交纳\n\n5.1 电信公司按照依法确定的资费标准向客户收取电信费用，客户应及时、足额支付各项费用。\n5.2 根据选择的电信业务种类，客户按预付费或后付费方式支付电信费用。除特殊约定外，后付费方式下客户按月支付费用，预付费方式下客户需预存金额，当帐户余额不足以支付客户拟使用的业务费用时，需及时充值。\n5.3 客户如选择或终止银行托收、银行代扣等方式支付电信费用时，需到银行等托收机构办理相应手续。\n5.4 客户逾期不交纳电信费用的，电信公司有权要求补交电信费用，并可以按照所欠费用每日加收3‰的违约金。\n5.5 客户在欠费情况下，应补交欠费和相应的违约金后才能办理其它业务。\n5.6 如遇国家调整电信费用标准的，自国家规定的调整时间起按新标准执行。如遇电信公司发布费用优惠方案的，自优惠方案规定的时间起按优惠标准执行。\n\n第六条 服务质量与客户服务\n\n6.1 电信公司在承诺的网络覆盖范围内，按照不低于《电信服务规范》的标准向客户提供服务。\n6.2 电信公司在营业场所公布电信业务的服务项目、服务时限、服务范围、资费标准、使用规则、交费规定等内容。\n6.3 电信公司通过10000号客户服务热线、营业厅等多种渠道提供业务受理、咨询、查询、障碍申告等服务。\n6.4 电信公司负责其提供的网络及设备的安装调测和维护，客户负责自带入网终端设备的安装、调测和维护。\n6.5 电信公司在本协议外以公告等形式公开做出的服务承诺，自动成为本协议的组成部份，但为客户设定义务或不合理地加重责任的除外。\n\n第七条 协议中止和解除\n\n7.1 除另有约定外，客户在交清电信费用后，可以暂停所使用的电信业务，但应办理有关手续和支付暂停期间的有关费用。\n7.2 客户有下列情形之一的，电信公司可以暂停向客户提供本协议约定的部分或全部服务，并收取暂停期间发生的费用：提供客户资料不真实或无效的；安装未取得入网许可，或可能影响网络安全或网络服务质量设备的；未办理相关手续，自行改变电信业务使用性质的；对于后付费业务，超过交费期限30日、经通知后仍未交费 的；对于预付费业务，帐户余额低于0元，或超过约定有效期的。\n7.3 除另有约定外，客户在交清相关电信费用及相应的违约金后，可办理业务注销或过户手续，本协议相应解除。\n7.4 客户有下列情形之一的，电信公司可以终止服务并终止本协议：擅自利用电信业务非法进行电信业务经营的；出现7.2所述情形，暂停服务超过60日的。\n7.5 客户在电信业务使用过程中如有违反相关法律、法规、规章规定的行为，电信公司可以暂停或终止提供电信服务。\n\n第八条 不可抗力\n\n8.1 由于不可抗力，如战争、自然灾害等，导致本协议不能履行的，双方均不需承担违约责任。\n\n第九条 争议解决 \n\n9.1 所有因本协议引起的或与本协议有关的争议，本着互让互利的原则，通过协商解决。协商不成的，客户可向电信管理部门申诉或向消费者协会等有关部门投诉。\n9.2按照9.1的约定，仍无法解决争议的，双方均可向北京仲裁委员会提起仲裁解决，仲裁裁决是终局的，对双方均有约束力。\n\n 第十条 附则 \n\n10.1客户登记单为本协议的组成部份，客户登记单内容与上述协议条款内容冲突时，以业务登记单为准。\n10.2 电信公司保留因技术进步或国家政策变动等原因对电信业务的服务功能、操作方法、业务号码等做出调整的权利，但调整时应提前告知客户并提供相应解决方案。\n10.3 电信公司可以采用电话、广播、短信、电视、公开张贴、信函、报纸或互联网等方式进行业务公告及业务通知。\n10.4 本协议自电信公司与客户或经办人在客户登记单上签字或盖章之日起生效。";
        
        label.textColor = [UIColor blackColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12];
        
        [protocolView addSubview:label];
        [label sizeToFit];
        
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(protocolView.frame), CGRectGetWidth(bgView.frame), 50)];
        btnView.backgroundColor = [UIColor clearColor];
        [bgView addSubview:btnView];
        
        UIImage * img       = [UIImage imageNamed:@"query_btn.png"];
        UIImage * himg      = [UIImage imageNamed:@"query_btn_highlight.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(agreeProtocalAction) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake((CGRectGetWidth(btnView.frame)-100)/2,(btnView.frame.size.height - 30)/2, 100, 30);
        [button setBackgroundImage:[img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height/2, img.size.width/2, img.size.height/2, img.size.width/2)] forState:UIControlStateNormal];
        [button setBackgroundImage:[himg resizableImageWithCapInsets:UIEdgeInsetsMake(himg.size.height/2, himg.size.width/2, himg.size.height/2, himg.size.width/2)] forState:UIControlStateHighlighted];
        [btnView addSubview:button];
        
        protocolView.contentSize = CGSizeMake(CGRectGetWidth(protocolView.frame), label.frame.size.height+10);
        
        
        [label release];
        [protocolView release];
        [btnView release];
        [bgView release];
    }
}

- (void) showProtocol
{
    for (int i=0; i<4; i++) {
        UITextField *textfield = (UITextField *)[_contentScroll viewWithTag:kTextfieldTag + i];
        [textfield resignFirstResponder];
        textfield.userInteractionEnabled = NO ;
    }
    self.bgView.hidden = NO;
    self.bottomView.hidden = NO;
}

-(void) agreeProtocalAction
{
    self.bgView.hidden = YES;
    self.bottomView.hidden = YES ;
    
    for (int i=0; i<4; i++) {
        UITextField *textfield = (UITextField *)[_contentScroll viewWithTag:kTextfieldTag + i];
        textfield.userInteractionEnabled = YES ;
    }
}

- (void)onBgBtn:(id)sender
{
    [_clickView resignFirstResponder];
}

- (void)onNavigationBarPrevBtn:(id)sender
{
    int tag = _clickView.tag;
    if (tag <= kTextfieldTag)
    {
        return;
    }
    UIView * nview = [_contentScroll viewWithTag:--tag];
    [nview becomeFirstResponder];
}

- (void)onNavigationBarNextBtn:(id)sender
{
    int tag = _clickView.tag;
    UIView * nview = [_contentScroll viewWithTag:++tag];
    [nview becomeFirstResponder];
}

- (void)onNavigationBarConfirmBtn:(id)sender
{
    [_clickView resignFirstResponder];
}

#pragma mark UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyNext)
    {
        UITextField * next = (UITextField *)[_contentScroll viewWithTag:textField.tag+1];
        [next becomeFirstResponder];
        return YES;
    }
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _clickView = textField;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UINavigationItem * navitem = [_textfieldNaviBar topItem];
    NSArray * leftBarButtonItems = [navitem leftBarButtonItems];
    for (UIBarButtonItem * barbtn in leftBarButtonItems)
    {
        if (barbtn.tag == kBarItemTag)
        {
            barbtn.enabled = (_clickView.tag == kTextfieldTag) ? NO : YES;
        }
        else if (barbtn.tag == kBarItemTag + 1)
        {
            barbtn.enabled = (_clickView.tag == kTextfieldTag + 3) ? NO : YES;
        }
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (_clickView == textField)
    {
        _clickView = nil;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _postcodeText)
    {
        return ([string length] <= 0 || [textField.text length] < 6);
    }
    else if (textField == _idText)
    {
        return ([string length] <= 0 || [textField.text length] < 18);
    }
    
    return YES;
}

#pragma mark -
#pragma mark Notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25 animations:^{
        NSDictionary *userInfo = [notification userInfo];
        NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [aValue CGRectValue];
        int keyboadHeight = keyboardRect.size.height + CGRectGetHeight(_textfieldNaviBar.frame);
        
        CGRect rc = _contentScroll.frame;
        rc.size.height = CGRectGetHeight(self.view.frame) - CGRectGetMinY(_contentScroll.frame) - keyboadHeight + kBarHeight;
        _contentScroll.frame = rc;
        if (_clickView)
        {
            [_contentScroll scrollRectToVisible:CGRectInset(_clickView.frame, 0, -8) animated:YES];
        }
    } completion:^(BOOL finished) {
        if (![_textfieldNaviBar isDescendantOfView:self.view])
        {
            [self.view addSubview:_textfieldNaviBar];
        }
        _textfieldNaviBar.frame = CGRectMake(0, CGRectGetMaxY(_contentScroll.frame), CGRectGetWidth(_textfieldNaviBar.frame), CGRectGetHeight(_textfieldNaviBar.frame));
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    CGRect rc = _contentScroll.frame;
    rc.size.height = CGRectGetMaxY(_greyBgView.frame) - CGRectGetMinY(_contentScroll.frame);
    _contentScroll.frame = rc;
    
    if (_clickView)
    {
        [_contentScroll scrollRectToVisible:_clickView.frame animated:YES];
    }
    if ([_textfieldNaviBar isDescendantOfView:self.view])
    {
        [_textfieldNaviBar removeFromSuperview];
    }
}


@end
