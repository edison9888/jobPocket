/*--------------------------------------------
 *Name：EsAddNewsViewCtler.h
 *Desc：随手拍，发布新闻的界面
 *--------------------------------------------
 *Name：CSCheckBox
 *Desc：勾选框
 *--------------------------------------------
 *Date：2014/05/21
 *Auth：lip
 *--------------------------------------------*/

#import "EsAddNewsViewCtler.h"
#import "CSTextField.h"
#import "CSTextView.h"
#import "CSButton.h"
#import "EsChooseListViewCtler.h"
#import "EsNetworkPredefine.h"
#import "SVProgressHUD.h"
#import "ToastAlertView.h"
#import "Global.h"
#import "BaseDataSource.h"

#pragma mark - CSCheckBox
@implementation CSCheckBox
{
    UILabel *labTitle;
    UIImageView *iconV;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initControl];
    }
    return self;
}

/**
 *	@method	初始化控件
 */
-(void)initControl
{
    CGFloat cx=0,cy=0,iconWH = 35;
    labTitle = [[UILabel alloc]init];
    labTitle.backgroundColor = [UIColor clearColor];
    labTitle.font = [UIFont boldSystemFontOfSize:14];
    labTitle.frame = CGRectMake(cx, cy, 60, self.frame.size.height);
    labTitle.textAlignment = NSTextAlignmentRight;
    [self addSubview:labTitle];
    cx = CGRectGetMaxX(labTitle.frame)+5;
    
    cy = (self.frame.size.height-iconWH)/2;
    iconV = [[UIImageView alloc]init];
    iconV.image = [UIImage imageNamed:@"hide_name_off.png"];
    iconV.frame = CGRectMake(cx, cy, iconWH, iconWH);
    [self addSubview:iconV];
    
    [self addTarget:self action:@selector(checBox_touch) forControlEvents:UIControlEventTouchUpInside];
    _checked = NO;
}

-(void)checBox_touch
{
    self.checked = !self.checked;
}

-(void)setChecked:(BOOL)checked
{
    _checked = checked;
    if(_checked)
        iconV.image = [UIImage imageNamed:@"hide_name_on.png"];
    else
        iconV.image = [UIImage imageNamed:@"hide_name_off.png"];
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    labTitle.text = _title;
}

@end

#pragma mark - EsAddNewsViewCtler
@interface EsAddNewsViewCtler ()
{
    CGRect bodyFrame;
    UIScrollView *scrollView;
    CSTextField *txtTitle;
    CSTextView *txtContent;
    UIChooseImg *chooseImg;
    CSCheckBox *box;
    CSButton *btnSelect;
}
@property (nonatomic, strong) CSButton *btnSelect;
@end

@implementation EsAddNewsViewCtler
@synthesize btnSelect = btnSelect;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = @"说说";
    [self setTitle:@"说说"];
    [self setRightButtonWidthTitle:@"发送"];
    [self setBackButton];
    [self initControl];
    
//    [self getNewList]; //二期接口测试
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initControl
{
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    scrollView = [[UIScrollView alloc]init];
    bodyFrame = scrollView.frame = CGRectMake(0, 0, mainSize.width, mainSize.height-64);
    [self.view addSubview:scrollView];
    
    CGFloat spitW = 10;
    CGFloat cx = spitW,cy = 20;
    CGFloat uWidth = mainSize.width-spitW*2,uHeight = 35;
    
    txtTitle = [[CSTextField alloc]init];
    txtTitle.font = [UIFont boldSystemFontOfSize:14];
    txtTitle.placeholder = @"我的标题";
    txtTitle.text = @"";
    txtTitle.textColor = kUIColorFromRGB(0x333333);
    txtTitle.frame = CGRectMake(cx, cy, uWidth, uHeight);
    txtTitle.backgroundColor = kUIColorFromRGB(0xeeeeee);
    [scrollView addSubview:txtTitle];
    cy = CGRectGetMaxY(txtTitle.frame)+10;
    
    txtContent = [[CSTextView alloc]initWithFrame:CGRectMake(cx, cy, uWidth, 120)];
    txtContent.placeholder = @"我要话要说";
    txtContent.layer.borderColor = [RGB(180,180,180,1) CGColor];
    txtContent.backgroundColor = kUIColorFromRGB(0xeeeeee);
    [scrollView addSubview:txtContent];
    cy = CGRectGetMaxY(txtContent.frame)+15;
    
    chooseImg = [[UIChooseImg alloc]initWithFrame:CGRectMake(cx, cy, uWidth, 80)];
    //chooseImg = [[UIChooseImg alloc]initWithFrame:CGRectMake(cx, cy, uWidth, 160)];
    chooseImg.imgNum = 1;
    chooseImg.ImgDelegate = self;
    [scrollView addSubview:chooseImg];
    cy = CGRectGetMaxY(chooseImg.frame)+15;
    
    btnSelect = [[CSButton alloc]init];
    btnSelect.title = @"我要分享";
    btnSelect.titleDetail = @"只限项目组";
    btnSelect.backgroundColor = RGB(238, 238, 238, 1);
    btnSelect.frame = CGRectMake(cx, cy, uWidth, 40);
    [btnSelect addTarget:self action:@selector(btnSelect_touch) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:btnSelect];
    cy = CGRectGetMaxY(btnSelect.frame)+10;
    
    CGFloat boxW = 100;
    cx = mainSize.width-boxW-spitW;
    box = [[CSCheckBox alloc]initWithFrame:CGRectMake(cx, cy, boxW, 35)];
    box.checked = NO;
    box.title = @"匿名发布";
    [scrollView addSubview:box];
    cy = CGRectGetMaxY(box.frame)+10;

    scrollView.contentSize = CGSizeMake(0, cy);
    
    //添加页码触摸事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onHideKeyboardTap)];
    tapGesture.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGesture];

    //注册键盘事件
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(KeyboardWillShow:)
                   name:UIKeyboardWillShowNotification
                 object:nil];
    [center addObserver:self
               selector:@selector(KeyboardWillHide:)
                   name:UIKeyboardWillHideNotification
                 object:nil];
    
    //上传图片大于四，改变高度
    [center addObserver:self
               selector:@selector(photoHeight:) name:@"chooseImg" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    btnSelect.titleDetail = [Global sharedSingleton].chooseModes?[Global sharedSingleton].chooseModes:@"只限项目组";
}

#pragma mark - 事件操作
/*
 @method 发表文本
 */
-(BOOL)validate
{
    if(txtTitle.text == nil || [txtTitle.text length] <= 0)
    {
        ToastAlertView* alert = [ToastAlertView new];
        [alert showAlertMsg:@"请输入标题"];
        return NO;
    }
    
    if(txtContent.text == nil || [txtContent.text length] <= 0)
    {
        if([chooseImg.imgDatas count]<= 0)
        {
            ToastAlertView* alert = [ToastAlertView new];
            [alert showAlertMsg:@"请输入内容"];
            return NO;
        }
    }
    
    if([chooseImg.imgDatas count]<= 0)
    {
        if(txtContent.text == nil || [txtContent.text length] <= 0)
        {
            ToastAlertView* alert = [ToastAlertView new];
            [alert showAlertMsg:@"请选择图片"];
            return NO;
        }
    }
    
    if (![Global sharedSingleton].parentModes) {
        
        ToastAlertView* alert = [ToastAlertView new];
        [alert showAlertMsg:@"请选择项目组"];
        return NO;
    }
    
    return YES;
}

/*
 @method 发表文本
 */
-(void)onRightBtnAction:(id)sender
{
    if(![self validate]) return;
    
    NSMutableString *jsonAppend = [[NSMutableString alloc] init];
    
    if([chooseImg.imgDatas count]> 0)
    {
        [jsonAppend appendString:@"["];
        NSInteger i = 0;
        for(NSData *data in chooseImg.imgDatas)
        {//组装图片数据
            if(i != 0)
                [jsonAppend appendString:@","];
            [jsonAppend appendString:[NSString stringWithFormat:@"{\"name\":\"iPhone%ld\",\"type\":\"jpg\",",(long)i]];
            [jsonAppend appendString:[NSString stringWithFormat:@"\"content\":\"%@\"}",data.base64Encoding]];
            i++;
        }
        
        [jsonAppend appendString:@"]"];
    }
    
    NSDictionary* params = @{@"token" : [Global sharedSingleton].userVerify.user.token,
                             @"newsTitle" : txtTitle.text,
                             @"newsContent" : txtContent.text,
                             @"isAnonymous" : box.checked ? @"1" : @"0",
                             @"parentModes" : [Global sharedSingleton].parentModes,
                             @"picContent"  : [jsonAppend length]?jsonAppend:@""};
    
    __weak typeof(self) wself = self;
    BaseDataSource* net = [BaseDataSource new];
    [SVProgressHUD showWithStatus:@"发送中..." maskType:SVProgressHUDMaskTypeGradient];
    [net startPostRequestWithParamsAndUrl:params method:@"uploadNews" upFiles:nil completion:^(id responsedict) {
        [wself onSendFinish:net response:responsedict];
    }];
}

- (void)onSendFinish:(BaseDataSource* )net response:(NSDictionary* )response
{
    [SVProgressHUD dismiss];
    NSString *errMsg = @"发布成功！";
    if(![net.errorCode isEqualToString:NETWORK_OK])
    {
        errMsg = net.errorMsg;
        [SVProgressHUD showErrorWithStatus:errMsg];
    }
    else
    {
        [SVProgressHUD showSuccessWithStatus:errMsg];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [Global sharedSingleton].parentModes = nil;   //上传成功后我的项目选择清空
        [Global sharedSingleton].chooseModes = nil;
        
    }
}


- (void)onLeftBtnAction:(id)sender
{
    if([Global sharedSingleton].parentModes)
    {
        [Global sharedSingleton].parentModes = nil;
        [Global sharedSingleton].chooseModes = nil;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 @method 选择分享范围
 */
-(void)btnSelect_touch
{
    EsChooseListViewCtler *chooseList = [[EsChooseListViewCtler alloc]init];
    [self.navigationController pushViewController:chooseList animated:YES];
}

/*
 @method 键盘显示
 */
-(void)KeyboardWillShow:(NSNotification*)notification
{
    NSValue *keyboardEndRectObject = [notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndRect = CGRectMake(0, 0, 0, 0);
    [keyboardEndRectObject getValue:&keyboardEndRect];
    
    scrollView.frame = bodyFrame;
    CGRect tempFrame = scrollView.frame;
    tempFrame.size.height -= keyboardEndRect.size.height;
    scrollView.frame = tempFrame;
}

/*
 @method 键盘隐藏
 */
-(void)KeyboardWillHide:(NSNotification*)notification
{
    scrollView.frame = bodyFrame;
}
- (void)onHideKeyboardTap
{
    [txtTitle resignFirstResponder];
    [txtContent resignFirstResponder];
}

#pragma mark - ImgBtnDelegate
-(void)imgBtnTouchCallBak:(ImgBtn *)sender
{
    if(sender.btnType == ImgBtnTypeBtn)
    {
        //NSArray *
        UIActionSheet *actionSheet = nil;
        //检测是否有摄像头
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            actionSheet = [[UIActionSheet alloc]
                           initWithTitle:nil
                           delegate:self
                           cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                           otherButtonTitles:@"从相册选择", @"拍照",nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        }else
        {
            actionSheet = [[UIActionSheet alloc]
                           initWithTitle:nil
                           delegate:self
                           cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                           otherButtonTitles:@"从相册选择",nil];
            actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        }
        [actionSheet showInView:self.view];
        
    }
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {//从相册选择
        UIImagePickerController *pickCtler = [[UIImagePickerController alloc]init];
        pickCtler.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickCtler.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self;
        [self presentModalViewController:pickCtler animated:YES];
    }
    else if(buttonIndex == 1 && actionSheet.numberOfButtons > 2)
    {//拍照
        UIImagePickerController *pickCtler = [[UIImagePickerController alloc]init];
        pickCtler.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickCtler.delegate = (id<UINavigationControllerDelegate,UIImagePickerControllerDelegate>)self;
        [self presentModalViewController:pickCtler animated:YES];
    }
}

#pragma mark - UIImagePickerControllerDelegate
//获取图像
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    //    {
    //        //如果是 来自照相机的image，那么先保存
    //        UIImage* original_image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //        UIImageWriteToSavedPhotosAlbum(original_image, self,
    //                                       @selector(image:didFinishSavingWithError:contextInfo:),
    //                                       nil);
    //    }
    
    //获得编辑过的图片
    UIImage* image = [info objectForKey: @"UIImagePickerControllerOriginalImage"];
    [chooseImg addImage:image];
    
    [picker dismissModalViewControllerAnimated:YES];
}

//当用户取消时，调用该方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - photoHeight
//图片大于四张，自动调整图片边框
- (void)photoHeight:(NSNotification*)notification
{
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    CGFloat spitW = 10;
    CGFloat cx = spitW,cy = 20;
    CGFloat uWidth = mainSize.width-spitW*2;
    
    CGRect rect = chooseImg.frame;
    rect.size.height = 154;
    chooseImg.frame = rect;
    cy = CGRectGetMaxY(chooseImg.frame)+15;
    
    
    btnSelect.frame = CGRectMake(cx, cy, uWidth, 40);
    cy = CGRectGetMaxY(btnSelect.frame)+10;
    
    CGFloat boxW = 100;
    cx = mainSize.width-boxW-spitW;
    box.frame = CGRectMake(cx, cy, boxW, 35);
    cy = CGRectGetMaxY(box.frame)+10;
    
    scrollView.contentSize = CGSizeMake(0, cy);
    
    
}

#pragma mark - 测试二期接口，模拟请求

- (void)getNewList
{
//    NSDictionary* params = @{@"token" : [Global sharedSingleton].userVerify.user.token,
//                             @"reportName" : @"上报2",
//                             @"reportContent" : @"上报2内容",
//                             @"reportFile" : @"",
//                             @"styleId":@"13"};
    
    NSDictionary* params = @{@"token" : [Global sharedSingleton].userVerify.user.token};
    BaseDataSource* net = [BaseDataSource new];
    [SVProgressHUD showWithStatus:@"查询中..." maskType:SVProgressHUDMaskTypeGradient];
    [net startPostRequestWithParamsAndUrl:params method:@"getReport" upFiles:nil completion:^(id responsedict){
        [SVProgressHUD dismiss];
        NSString *errMsg = @"查询成功！";
        if(![net.errorCode isEqualToString:NETWORK_OK])
        {
            errMsg = net.errorMsg;
            [SVProgressHUD showErrorWithStatus:errMsg];
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:errMsg];
            
        }
    }];
}

@end
