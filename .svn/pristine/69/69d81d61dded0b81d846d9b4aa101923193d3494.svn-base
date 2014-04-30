//
//  SelectPackagesVCtler.m
//  CTPocketv3
//
//  Created by Y W on 13-5-29.
//
//

#import "SelectPackagesVCtler.h"
#import "UIView+RoundRect.h"
#import <QuartzCore/QuartzCore.h>
#import "RegexKitLite.h"
#import "SelectPackagesDetailVCtler.h"
#import "SVProgressHUD.h"
#import "ToastAlertView.h"
#import "CserviceOperation.h" 
#import "AppDelegate.h"
#import "CTPNumberPickerVCtler.h"
#import "SIAlertView.h"

#define kSelectPackagesCellSelected @"kSelectPackagesCellSelected"

@implementation SelectPackagesCell

@synthesize info = _info;
@synthesize detailAction;
@synthesize selectAction;

+ (float)cellHeight
{
    return 40;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        {
            CGRect rect = self.frame;
            rect.size.height = [SelectPackagesCell cellHeight];
            self.frame = rect;
        }
        self.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIColor *textColor = [UIColor colorWithRed:39/255. green:39/255. blue:39/255. alpha:1];

        {
            UIImage *image1 = [UIImage imageNamed:@"Recharge_moneyBg1.png"];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
            [button setBackgroundImage:[image1 stretchableImageWithLeftCapWidth:image1.size.width/2 topCapHeight:image1.size.height/2] forState:UIControlStateNormal];
            [button setTitleColor:textColor forState:UIControlStateNormal];
            [button setTitleColor:textColor forState:UIControlStateSelected];
            [button setTitleColor:textColor forState:UIControlStateHighlighted];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
            [button.titleLabel setMinimumFontSize:12];
            [self.contentView addSubview:button];
            button.enabled = NO;
            _packageButton = button;
            
            CGRect rect = CGRectZero;
            rect.size = image1.size;
            rect.origin.x = 0;
            rect.origin.y = ceilf((self.frame.size.height - rect.size.height)/2);
            button.frame = rect;
        }
        
        {
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = textColor;
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = UITextAlignmentCenter;
            [self.contentView addSubview:label];
            [label release];
            _voiceLabel = label;
        }
        
        {
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = textColor;
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = UITextAlignmentCenter;
            [self.contentView addSubview:label];
            [label release];
            _flowLabel = label;
        }
        
        {
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = textColor;
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = UITextAlignmentCenter;
            [self.contentView addSubview:label];
            [label release];
            _msgLabel = label;
        }
        
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor colorWithRed:39/255. green:169/255. blue:37/255. alpha:1];//kRGBUIColor(39, 169, 37, 1);
            [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [button dwMakeRoundCornerWithRadius:5];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitle:@"详情" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(detailAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
            _detailButton = button;
        }
        
        {
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
            tapGestureRecognizer.delegate = self;
            [self.contentView addGestureRecognizer:tapGestureRecognizer];
            [tapGestureRecognizer release];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellSelected:) name:kSelectPackagesCellSelected object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.detailAction = nil;
    self.selectAction = nil;
    self.info = nil;
    
    [super dealloc];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int xOffset = 15, width = ceilf((self.contentView.frame.size.width - xOffset * 2)/5);
    
    {
        CGRect rect = _packageButton.frame;
        rect.size.width = width - 12;
        rect.size.height = self.contentView.frame.size.height - 16;
        rect.origin.x = xOffset + 8;
        rect.origin.y = 8;
        _packageButton.frame = rect;
        
        xOffset += width;
    }
    
    {
        _voiceLabel.frame = CGRectMake(xOffset, 0, width, self.contentView.frame.size.height);
        
        xOffset += width;
    }
    
    {
        _flowLabel.frame = CGRectMake(xOffset, 0, width, self.contentView.frame.size.height);
        
        xOffset += width;
    }
    
    {
        _msgLabel.frame = CGRectMake(xOffset, 0, width, self.contentView.frame.size.height);
        
        xOffset += width;
    }
    
    {
        _detailButton.frame = CGRectMake(xOffset, 8, width - 12, self.contentView.frame.size.height - 16);
    }
}

- (void)setCustomSelect
{
    [self tapGestureRecognizerAction:nil];
}

#pragma mark - action

- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSelectPackagesCellSelected object:self];
}

- (void)cellSelected:(NSNotification *)notification
{
    id obj = [notification object];
    if (obj == self) {
        UIImage *image2 = [UIImage imageNamed:@"Recharge_moneyBg2.png"];
        [_packageButton setBackgroundImage:image2 forState:UIControlStateNormal];
        if (self.selectAction) {
            selectAction(self.info);
        }
    } else {
        UIImage *image1 = [UIImage imageNamed:@"Recharge_moneyBg1.png"];
        [_packageButton setBackgroundImage:image1 forState:UIControlStateNormal];
    }
}

- (void)detailAction:(UIButton *)button
{
    if (self.detailAction) {
        detailAction(self.info);
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.contentView];
    if (CGRectContainsPoint(_detailButton.frame, point)) {
        return NO;
    }
    return YES;
}

- (void)setInfo:(NSDictionary *)info
{
    if (_info) {
        [_info release];
    }
    _info = [info retain];
    
    if (info == nil || ![info isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSDictionary *dictionary = [info objectForKey:@"Services"];
    if (dictionary == nil || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *ContractName = [dictionary objectForKey:@"ContractName"];
    if (ContractName) {
        ContractName = [ContractName stringByMatching:@"\\d*\\.?\\d+元"];
        if (ContractName && ContractName.length > 1) {
            ContractName = [ContractName substringToIndex:[ContractName length] - 1];
            [_packageButton setTitle:ContractName forState:UIControlStateNormal];
        }
    }
    
    NSString *Properties = [dictionary objectForKey:@"Properties"];
    if (Properties) {
        NSString *voice = [Properties stringByMatching:@"\\d*\\.?\\d+分钟"];
        if (voice && [voice length] > 1) {
            _voiceLabel.text = [voice substringToIndex:[voice length] - 1];
        }
        
        NSString *flow = [Properties stringByMatching:@"\\d*\\.?\\d+[MGK]B"];
        if (flow && [flow length] > 1) {
            _flowLabel.text = [flow substringToIndex:[flow length] - 1];
        }
        
        NSString *msg = [Properties stringByMatching:@"\\d*\\.?\\d+条"];
        if (msg) {
            _msgLabel.text = msg;
        }
    }
}

@end



//************************************************华丽丽的分割线******************************************************





@interface ItemButton ()

@property (nonatomic, retain)UIImage *normalImage;
@property (nonatomic, retain)UIImage *selectImage;

@end


@implementation ItemButton

@synthesize normalImage;
@synthesize selectImage;

@synthesize info;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.normalImage = [UIImage imageNamed:@"Recharge_input3.png"];
        self.selectImage = [UIImage imageNamed:@"Recharge_input4.png"];
        
        int xOffset = 0;
        {
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:self.normalImage];
            imageView.backgroundColor = [UIColor clearColor];
            CGRect rect = imageView.bounds;
            rect.origin.x = xOffset;
            rect.origin.y = ceilf((frame.size.height - rect.size.height)/2);
            imageView.frame = rect;
            [self addSubview:imageView];
            _imageView = imageView;
            
            xOffset += imageView.frame.size.width;
        }
        
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, 0, frame.size.width - xOffset, frame.size.height)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithRed:83/255. green:83/255. blue:83/255. alpha:1];
//            kRGBUIColor(83, 83, 83, 1);
            label.font = [UIFont systemFontOfSize:14];
            label.adjustsFontSizeToFitWidth = YES;
            label.minimumFontSize = 12;
            [self addSubview:label];
            [label release];
            _titleLabel = label;
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        _imageView.image = self.selectImage;
    } else {
        _imageView.image = self.normalImage;
    }
}

- (void)setItem:(NSDictionary *)item
{
    self.info = item;
    
    if (item == nil || ![item isKindOfClass:[NSDictionary class]]) {
        assert(0);
        return;
    }
    
    NSString *Name = [item objectForKey:@"Name"];
    if (Name && [Name isKindOfClass:[NSString class]]) {
        _titleLabel.text = Name;
    } else {
        _titleLabel.text = @"";
    }
}

- (void)dealloc
{
    self.info = nil;
    self.normalImage = nil;
    self.selectImage = nil;
    [super dealloc];
}

@end






//************************************************华丽丽的分割线******************************************************



@interface SelectPackagesVCtler () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    
//    CTPBaseDataSource *_networking;
    
    NSMutableArray *_responseData;
    
    BOOL _noData;
    
    //下面那一块的
    UIView *_giftView; //整体背景view
    UILabel *_giftNameLabel; //业务名字label;
    UIScrollView *_giftTypeScrollView; //赠送业务列表的背景scrollview
    UILabel *_selectGiftLabel; //选择的业务
    UIButton *_nextButton;
}

@property (nonatomic, retain)NSDictionary *selectPackagesInfo; //选择的套餐的
@property (nonatomic, retain)NSMutableArray *selectItems; //选择的业务赠书的
@property (nonatomic, assign)int maxCount;
@property (nonatomic, strong) CserviceOperation *packageOpt;

@end

@implementation SelectPackagesVCtler

@synthesize SalesproductId;
@synthesize ContractId;
@synthesize selectItems;
@synthesize selectPackagesInfo;
@synthesize maxCount;
@synthesize SalesproductInfoDict;
@synthesize ContractInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"选择套餐";
    [self setLeftButton:[UIImage imageNamed:@"btn_back_recharge.png"]];
    self.view.backgroundColor = [UIColor whiteColor];
    _responseData = [[NSMutableArray alloc] init];
    
    _noData = NO;
    
    self.selectItems = [[[NSMutableArray alloc] init] autorelease];
    
    {
        int yOffset = 0, xOffset = 0;
        {
            UIImage *image = [UIImage imageNamed:@"div_line.png"];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - image.size.width)/2, yOffset, image.size.width, image.size.height)];
            imageView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:imageView];
            
            yOffset += image.size.height;
            xOffset = imageView.frame.origin.x;
            [imageView release];
        }
        {
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(xOffset, yOffset, self.view.bounds.size.width - 2 * xOffset, self.view.bounds.size.height - yOffset)];
            bgView.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1];
            [self.view addSubview:bgView];
            [bgView release];
        }
        
        {
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(xOffset, yOffset, self.view.bounds.size.width - 2 * xOffset, iPhone5? 268:180) style:UITableViewStylePlain];
            tableView.showsVerticalScrollIndicator = NO;
            tableView.showsHorizontalScrollIndicator = NO;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.backgroundView = nil;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.dataSource = self;
            tableView.delegate = self;
            [self.view addSubview:tableView];
            _tableView = tableView;
            [tableView release];
        }
        
        {
            UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 40)];
            mView.backgroundColor = [UIColor clearColor];
            _tableView.tableHeaderView = mView;
            [mView release];
            
            UIImage *image = [UIImage imageNamed:@"packages_mark1.png"];
            int xSet = 22, width = ceilf(image.size.width) - 5, xDistance = (mView.frame.size.width - width * 5 - xSet * 2)/4, height = ceilf(image.size.height),  ySet = ceilf((mView.frame.size.height - height)/2);
            for (int i = 0; i < 5; i++) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.backgroundColor = [UIColor clearColor];
                button.frame = CGRectMake(xSet + (width + xDistance) * i, ySet + 5, width, height);
                button.enabled = NO;
                [button setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2] forState:UIControlStateNormal];
                NSString *title = nil;
                switch (i) {
                    case 0:
                    {
                        title = @"套餐";
                    }
                        break;
                    case 1:
                    {
                        title = @"语音";
                    }
                        break;
                    case 2:
                    {
                        title = @"流量";
                    }
                        break;
                    case 3:
                    {
                        title = @"短信";
                    }
                        break;
                    case 4:
                    {
                        title = @"详情";
                    }
                        break;
                    default:
                        break;
                }
                
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
                [button setTitle:title forState:UIControlStateNormal];
                [button setTitleEdgeInsets:UIEdgeInsetsMake(4, 0, 11, 0)];
                
                [mView addSubview:button];
            }
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (0) {
        if (self.ContractId == nil || 1) {
            self.ContractId = @"00000000D14411769A8D7971E043AE1410ACFE81";
        }
        
        if (self.SalesproductId == nil || 1) {
            self.SalesproductId = @"00000000DDD3961C556B4E4BE043AA1410AC9EE0";
        }
    }
    
    if (self.ContractId == nil || [self.ContractId isKindOfClass:[NSNull class]]) {
        if ([self.ContractInfo respondsToSelector:@selector(objectForKey:)]) {
            self.ContractId = [self.ContractInfo objectForKey:@"ContractsId"];
        }
    }
    
    if (self.SalesproductId == nil || [self.SalesproductId isKindOfClass:[NSNull class]]) {
        if ([self.SalesproductInfoDict respondsToSelector:@selector(objectForKey:)]) {
            self.SalesproductId = [self.SalesproductInfoDict objectForKey:@"SalesProdId"];
        }
    }
    
    if (_responseData.count > 0) {
        
        [_tableView setContentOffset:CGPointZero animated:YES];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        SelectPackagesCell *cell = (SelectPackagesCell *)[_tableView cellForRowAtIndexPath:indexPath];
        if (cell && [cell respondsToSelector:@selector(setCustomSelect)]) {
            [cell setCustomSelect];
        }
        
    } else {
        [self qryContractPackage];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    if (self.packageOpt) {
        [self.packageOpt cancel];
        self.packageOpt = nil;
    }
    _giftView = nil;
    _tableView = nil;
    
    [_responseData release];
    _responseData = nil;
    self.selectPackagesInfo = nil;
    self.selectItems = nil;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.packageOpt) {
        [self.packageOpt cancel];
        self.packageOpt = nil;
    }
    
    //网络对象要cancel 并赋值
    if (self.packageOpt) {
        [self.packageOpt cancel];
        self.packageOpt = nil;
    }

    
    self.SalesproductId = nil;
    self.ContractId = nil;
    
    self.selectItems = nil;
    self.selectPackagesInfo = nil;
    
    self.SalesproductInfoDict = nil;
    self.ContractInfo = nil;
    
    [_responseData release];

    [super dealloc];
}

#pragma mark - functions
- (void)loadGiftViewWithInfo:(NSDictionary *)info //load业务赠送的view
{
    if (info == nil || ![info isKindOfClass:[NSDictionary class]]) {
        assert(0);
        return;
    }
    if (_giftView == nil) {
        UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0,iPhone5?_tableView.frame.size.height:_tableView.frame.size.height, self.view.bounds.size.width, 205)];
        mView.backgroundColor = [UIColor colorWithRed:208/255. green:208/255. blue:208/255. alpha:1];
        [mView dwMakeHeaderRoundCornerWithRadius:5];
        [self.view addSubview:mView];
        [mView release];
        _giftView = mView;
        
        UIImage *image = [UIImage imageNamed:@"icon_home_pakeg.png"];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = image;
        imageView.frame = CGRectMake(12, 0, ceilf(image.size.width * 0.6), ceilf(image.size.height * 0.6));
        [mView addSubview:imageView];
        [imageView release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) - 5, imageView.frame.origin.y, 200, imageView.frame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14];
        [mView addSubview:label];
        [label release];
        _giftNameLabel = label;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(imageView.frame), mView.bounds.size.width - 14 * 2, 65)];
        scrollView.backgroundColor = [UIColor whiteColor];
        scrollView.layer.cornerRadius = 4;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [mView addSubview:scrollView];
        [scrollView release];
        _giftTypeScrollView = scrollView;
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame) + 6, CGRectGetMaxY(scrollView.frame) + 9, mView.frame.size.width - (CGRectGetMinX(imageView.frame) + 8) * 2, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14];
        [mView addSubview:label];
        [label release];
        _selectGiftLabel = label;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor colorWithRed:39/255. green:169/255. blue:37/255. alpha:1];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button dwMakeRoundCornerWithRadius:5];
        button.frame= CGRectMake(14, 145, mView.frame.size.width - 14 * 2, 30);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"下一步" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        [mView addSubview:button];
    }
    
    [[_giftTypeScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.selectItems removeAllObjects];
    
    NSDictionary *Services = [info objectForKey:@"Services"];
    if (Services == nil || ![Services isKindOfClass:[NSDictionary class]]) {
        assert(0);
        return;
    }
    
    id MaxValueAddedServiceCount = [Services objectForKey:@"MaxValueAddedServiceCount"];
    self.maxCount = -1;
    if (MaxValueAddedServiceCount && [MaxValueAddedServiceCount respondsToSelector:@selector(floatValue)]) {
        maxCount = [MaxValueAddedServiceCount intValue];
    }
    
    NSArray *Items = [[Services objectForKey:@"Items"]objectForKey:@"Item"];
    
    if (Items && [Items isKindOfClass:[NSArray class]]) {
        int itemCount = [Items count];
        _giftNameLabel.text = [NSString stringWithFormat:@"业务赠送(%d选%d)", itemCount, maxCount];
        
        [self loadItems:Items inScrollView:_giftTypeScrollView];
    }
    
    NSString *ContractName = [Services objectForKey:@"ContractName"];
    if (ContractName && [ContractName isKindOfClass:[NSString class]]) {
        _selectGiftLabel.text = [NSString stringWithFormat:@"您选择：%@套餐", ContractName];
    }
}

- (void)loadItems:(NSArray *)items inScrollView:(UIScrollView *)scrollView
{
    [[scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.selectItems removeAllObjects];
    
    if (items == nil || ![items isKindOfClass:[NSArray class]]) {
        return;
    }
    
    int i = 0, ySet = 5, xSet = 5, width = ceilf((scrollView.frame.size.width - xSet * 2)/3), height = 25;
    
    for (NSDictionary *dic in items) {
        
        CGRect rect = CGRectMake(xSet + i % 3 * width, ySet + i / 3 * height, width - 5, height);
        ItemButton *button = [[ItemButton alloc] initWithFrame:rect];
        button.frame = rect;
        [button setItem:dic];
        [button addTarget:self action:@selector(selectItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        [button release];
        
        if (i < self.maxCount) {
            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        
        if (i == [items count] - 1) {
            scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, CGRectGetMaxY(button.frame) + ySet);
        }
        i++;
    }
}


#pragma mark - action
- (void)loginSuccess:(NSNotification *)notification
{
    if (_responseData.count == 0) {
        [self qryContractPackage];
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0) {
        if (self.modalViewController) {
            [self.modalViewController dismissModalViewControllerAnimated:YES];
        }
    } else {
        if (self.presentedViewController) {
            [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}


- (void)selectItemAction:(ItemButton *)button
{
    if (button == nil || ![button isKindOfClass:[ItemButton class]]) {
        assert(0);
        return;
    }
    
    if (self.maxCount <= 0) {
//        [self alert:@"该套餐无业务赠送"];
        
        return;
    }
    
    assert(button.info != nil);
    
    if (![self.selectItems containsObject:button]) {
        if (self.selectItems.count >= self.maxCount) { //判断已选择的个数
            ItemButton *button = [self.selectItems objectAtIndex:0];
            button.selected = NO;
            [self.selectItems removeObject:button];
        }
        button.selected = YES;
        [self.selectItems addObject:button];
    }
}

- (void)backAction:(UIButton *)button
{
    if (self.packageOpt) {
        [self.packageOpt cancel];
        self.packageOpt = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

//客服
- (void)talkAction:(UIButton *)button
{
//    CTPOnlineServiceVCtler * vctler = [CTPOnlineServiceVCtler new];
//    [self.navigationController pushViewController:vctler animated:YES];
//    [vctler release];
}

- (void)nextAction:(UIButton *)button
{
    if ([self.selectItems count] < self.maxCount) {
        return;
    }
    CTPNumberPickerVCtler *numberPickerVCtler = [[CTPNumberPickerVCtler alloc] init];
    numberPickerVCtler.PackageInfoDict = [self.selectPackagesInfo objectForKey:@"Services"];
    numberPickerVCtler.SalesproductInfoDict = self.SalesproductInfoDict;
    numberPickerVCtler.ContractInfo = self.ContractInfo;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (ItemButton *button in self.selectItems) {
        if ([button isKindOfClass:[ItemButton class]] && button.info) {
            [array addObject:button.info];
        }
    }
    numberPickerVCtler.OptPackageList = array;
    [array release];
    [self.navigationController pushViewController:numberPickerVCtler animated:YES];
    [numberPickerVCtler release];
}

#pragma mark - networking
- (void)qryContractPackage
{
    assert(self.SalesproductId != nil);
    assert(self.ContractId != nil);
    
    if (self.packageOpt) {
        [self.packageOpt cancel];
        self.packageOpt = nil;
    }
    
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.SalesproductId, @"SalesproductId", self.ContractId, @"ContractId", nil];
    self.packageOpt =   [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryContractPackage"
                                                               params:params
              onSucceeded:^(NSDictionary *dict)
                         {
                             if (dict && [dict respondsToSelector:@selector(objectForKey:)]) {
                                 id Data = [dict objectForKey:@"Data"];
                                 if (Data){
                                     if ([Data isKindOfClass:[NSArray class]]) {
                                         
                                         [_responseData addObjectsFromArray:Data];
                                     }else if([Data isKindOfClass:[NSDictionary class]]){
                                         [_responseData addObject:Data];
                                     }
                                 }
                             }
                              [_tableView reloadData];
                         
                             if (_responseData.count > 0) {
                                 [_tableView setContentOffset:CGPointZero animated:YES];
                                 NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                                 SelectPackagesCell *cell = (SelectPackagesCell *)[_tableView cellForRowAtIndexPath:indexPath];
                                 if (cell && [cell respondsToSelector:@selector(setCustomSelect)]) {
                                     [cell setCustomSelect];
                                 }
                             }
                             [SVProgressHUD dismiss];
              } onError:^(NSError *engineError)
                         {
                             [SVProgressHUD dismiss];
                             if ([engineError.userInfo objectForKey:@"ResultCode"])
                             {
                                 if ([engineError.userInfo[@"ResultCode"] isEqualToString:@"X104"])
                                 {
                                     // 取消掉全部请求和回调，避免出现多个弹框
                                     [MyAppDelegate.cserviceEngine cancelAllOperations];
                                     // 提示重新登录
                                     SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                                                      andMessage:@"长时间未登录，请重新登录。"];
                                     [alertView addButtonWithTitle:@"确定"
                                                              type:SIAlertViewButtonTypeDefault
                                                           handler:^(SIAlertView *alertView) {
                                                               [MyAppDelegate showReloginVC];
                                                               if (self.navigationController != nil)
                                                               {
                                                                   [self.navigationController popViewControllerAnimated:NO];
                                                               }
                                                           }];
                                     alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                     [alertView show];
                                     [alertView release];
                                 }
                             }
                             else{
                                 ToastAlertView *alert = [ToastAlertView new];
                                 [alert showAlertMsg:@"系统繁忙,请重新提交"];
                                 [alert release];
                             }
                         }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_noData) {
        return _responseData.count;
    } else {
        return 8;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_noData) {
        static NSString *cellIdentifier1 = @"Cell1";
        SelectPackagesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if (cell == nil) {
            cell = [[[SelectPackagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1] autorelease];
        }
        [cell setInfo:[_responseData objectAtIndex:indexPath.row]];
        
        __block SelectPackagesVCtler *weakSelf = self;
        [cell setDetailAction:^(NSDictionary *info){
            
            SelectPackagesDetailVCtler *selectPackagesDetailVCtler = [[SelectPackagesDetailVCtler alloc] init];
            selectPackagesDetailVCtler.info = weakSelf.selectPackagesInfo;
            
            NSMutableArray *items = [[NSMutableArray alloc] init];
            for (ItemButton *button in weakSelf.selectItems) {
                [items addObject:button.info];
            }
            selectPackagesDetailVCtler.selectDictionaryItems = items;
            [items release];
            
            selectPackagesDetailVCtler.SalesproductId = weakSelf.SalesproductId;
            selectPackagesDetailVCtler.ContractId = weakSelf.ContractId;
            
            selectPackagesDetailVCtler.SalesproductInfoDict = weakSelf.SalesproductInfoDict;
            selectPackagesDetailVCtler.ContractInfo = weakSelf.ContractInfo;
            
            [weakSelf.navigationController pushViewController:selectPackagesDetailVCtler animated:YES];
            [selectPackagesDetailVCtler release];
        }];
        
        [cell setSelectAction:^(NSDictionary *info){
            weakSelf.selectPackagesInfo = info;
            [weakSelf loadGiftViewWithInfo:info];
        }];
        
        return cell;
    } else {
        static NSString *cellIdentifier2 = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
        }
        
        if (indexPath.row == 3) {
            cell.textLabel.text = @"               该合约无套餐信息";
        } else {
            cell.textLabel.text = nil;
        }
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_noData) {
        return 44;
    } else {
        return 43;
    }
}
@end
