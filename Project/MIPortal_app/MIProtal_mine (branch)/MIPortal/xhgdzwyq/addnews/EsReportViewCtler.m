/*--------------------------------------------
 *Name：EsReportViewCtler.h
 *Desc：我的上报模块，部分复用说说模块
 *Date：2014/05/30
 *Auth：shanhq
 *--------------------------------------------*/

#import "EsReportViewCtler.h"
#import "CSTextField.h"
#import "CSTextView.h"
#import "CSButton.h"
#import "EsChooseListViewCtler.h"
#import "EsNetworkPredefine.h"
#import "SVProgressHUD.h"
#import "ToastAlertView.h"
#import "Global.h"
#import "BaseDataSource.h"
#import "esAppDelegate.h"

#define kTagRootScrollview 100

@interface EsReportViewCtler ()
{
    CGRect bodyFrame;
    UIScrollView *scrollView;
    CSTextField *txtTitle;
    CSTextView *txtContent;
    UIChooseImg *chooseImg;
    NSArray *pickerArray;
    UIPickerView *_reportPicker;
    UIView*      _pickerStatusView;
    NSArray *reportArr;
    NSString * reportTypeStr;
}

@end

@implementation EsReportViewCtler

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
    // Do any additional setup after loading the view.
    self.title = @"我的汇报";
    [self setRightButtonWidthTitle:@"发送"];
    [self setBackButton];
    [self initControl];
    [self getReportType];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 界面初始化
-(void)initControl
{
    CGSize mainSize = [[UIScreen mainScreen] bounds].size;
    scrollView = [[UIScrollView alloc]init];
    bodyFrame = scrollView.frame = CGRectMake(0, 0, mainSize.width, mainSize.height-64);
    [self.view addSubview:scrollView];
    scrollView.tag = kTagRootScrollview;
    
    CGFloat spitW = 10;
    CGFloat cx = spitW,cy = 20;
    CGFloat uWidth = mainSize.width-spitW*2,uHeight = 44;
    
    pickerArray = [NSArray arrayWithObjects:@"动物",@"植物",@"石头",@"天空", nil];
    
    
    UIImage* image = [UIImage imageNamed:@"report_combobox.png"];
    {
        txtTitle = [[CSTextField alloc]init];
        txtTitle.font = [UIFont boldSystemFontOfSize:14];
        txtTitle.text = [pickerArray objectAtIndex:0]?[pickerArray objectAtIndex:0]:@"";
        txtTitle.textColor = kUIColorFromRGB(0x333333);
        txtTitle.frame = CGRectMake(cx, cy, uWidth-image.size.width, uHeight);
        txtTitle.backgroundColor = kUIColorFromRGB(0xeeeeee);
        [scrollView addSubview:txtTitle];
        //txtTitle.enabled = NO;  //不可编辑
        txtTitle.userInteractionEnabled = NO;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor brownColor];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(onReportType) forControlEvents:UIControlEventTouchUpInside];
        CGRect rect = txtTitle.frame;
        rect.size = image.size;
        rect.origin.x = rect.origin.x+CGRectGetWidth(txtTitle.frame);
        button.frame = rect;
//        CGRect rect = button.frame;
//        rect.origin.x = 8;
//        rect.origin.y = ceilf((button.frame.size.height - rect.size.height) / 2);
//        button.frame = rect;
        [scrollView addSubview:button];
        //txtTitle.rightView = button;
        //txtTitle.rightViewMode = UITextFieldViewModeAlways;
        
        cy = CGRectGetMaxY(txtTitle.frame)+10;
    }
    
    txtContent = [[CSTextView alloc]initWithFrame:CGRectMake(cx, cy, uWidth, 120)];
    txtContent.placeholder = @"汇报概要...";
    txtContent.layer.borderColor = [RGB(180,180,180,1) CGColor];
    txtContent.backgroundColor = kUIColorFromRGB(0xeeeeee);
    [scrollView addSubview:txtContent];
    cy = CGRectGetMaxY(txtContent.frame)+15;
    
    chooseImg = [[UIChooseImg alloc]initWithFrame:CGRectMake(cx, cy, uWidth, 80)];
    chooseImg.imgNum = 1;
    chooseImg.ImgDelegate = self;
    [scrollView addSubview:chooseImg];
    cy = CGRectGetMaxY(chooseImg.frame)+15;
    
    scrollView.contentSize = CGSizeMake(0, cy);
    
    //选项栏 项目类型
    UIView *pickerSelView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(MyAppDelegate.window.frame), CGRectGetWidth(self.view.frame), 40)];
    pickerSelView.backgroundColor = [UIColor colorWithRed:(9*16+7)/255. green:(9*16+7)/255. blue:(9*16+7)/255. alpha:1];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [MyAppDelegate.window addSubview:pickerSelView];
        _pickerStatusView = pickerSelView ;
    }
    {
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        cancelBtn.frame = CGRectMake(0, 0, 80, 40);
        [cancelBtn addTarget:self action:@selector(hiddenPicker) forControlEvents:UIControlEventTouchUpInside];
        [pickerSelView addSubview:cancelBtn] ;
        
        
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setTitle:@"完成" forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        okBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        okBtn.frame = CGRectMake(320-80, 0, 80, 40);
        [okBtn addTarget:self action:@selector(hiddenPicker) forControlEvents:UIControlEventTouchUpInside];
        [pickerSelView addSubview:okBtn] ;
    }
    
    // picker
    UIPickerView * picker = [[UIPickerView alloc] init];
    picker.dataSource     = (id<UIPickerViewDataSource>)self;
    picker.delegate       = (id<UIPickerViewDelegate>)self;
    [picker setBackgroundColor:[UIColor whiteColor]];
    picker.showsSelectionIndicator = YES;
    _reportPicker           = picker;
    
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


#pragma mark - 事件操作
/*
 @method 发表文本
 */
-(BOOL)validate
{
    if(txtTitle.text == nil || [txtTitle.text length] <= 0)
    {
        ToastAlertView* alert = [ToastAlertView new];
        [alert showAlertMsg:@"上报类型不能为空"];
        return NO;
    }
    
    if(txtContent.text == nil || [txtContent.text length] <= 0)
    {
        if([chooseImg.imgDatas count]<= 0)
        {
            ToastAlertView* alert = [ToastAlertView new];
            [alert showAlertMsg:@"请输入上报内容"];
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
    return YES;
}

/*
 @method 发表上报
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
                             @"reportName" : txtTitle.text,
                             @"reportContent" : txtContent.text,
                             @"reportFile"  : [jsonAppend length]?jsonAppend:@"",
                             @"styleId"  :reportTypeStr?reportTypeStr:[[reportArr objectAtIndex:0]objectForKey:@"styleId"]
                             };
    
    __weak typeof(self) wself = self;
    BaseDataSource* net = [BaseDataSource new];
    [SVProgressHUD showWithStatus:@"发送中..." maskType:SVProgressHUDMaskTypeGradient];
    [net startPostRequestWithParamsAndUrl:params method:@"uploadReport" upFiles:nil completion:^(id responsedict) {
        [wself onSendFinish:net response:responsedict];
    }];
}

/*
 点击按钮响应，左按钮默认返回
 */
- (void)onLeftBtnAction:(id)sender
{
    [self hiddenPicker];
    [self.navigationController popViewControllerAnimated:YES];
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
        
    }
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
    [self hiddenPicker];
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
    [self hiddenPicker];
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

#pragma mark - 图片大于四张，自动调整图片边框

- (void)photoHeight:(NSNotification*)notification
{
    CGRect rect = chooseImg.frame;
    rect.size.height = 154;
    chooseImg.frame = rect;
    CGFloat cy = CGRectGetMaxY(chooseImg.frame)+15;
    
    
    scrollView.contentSize = CGSizeMake(0, cy);
    
    
}

#pragma mark - 选择上报类型
- (void)onReportType
{
    if ([pickerArray count] <= 0) {
        //[self getProvinceList];
        return;
    }
    
    if ([_reportPicker isDescendantOfView:MyAppDelegate.window])
    {
        return;
    }else{
        _reportPicker.frame = CGRectMake(0, CGRectGetHeight(MyAppDelegate.window.frame), CGRectGetWidth(_reportPicker.frame), CGRectGetHeight(_reportPicker.frame)-40);
        _pickerStatusView.frame = CGRectMake(0, CGRectGetHeight(MyAppDelegate.window.frame), CGRectGetWidth(_reportPicker.frame), 40);
        
        [MyAppDelegate.window addSubview:_reportPicker];
        [MyAppDelegate.window addSubview:_pickerStatusView];
        
        [UIView animateWithDuration:0.25 animations:^{
            _reportPicker.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(_reportPicker.frame));
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            {
                CGRect rect ;
                rect = _pickerStatusView.frame ;
                rect.origin.y = CGRectGetHeight(MyAppDelegate.window.frame)-CGRectGetHeight(_reportPicker.frame) - 40 ;
                _pickerStatusView.frame = rect ;
            }
        } completion:^(BOOL finished) {
        }];
    }
}
#pragma mark - hiddenPicker
-(void)hiddenPicker{
    EsAppDelegate * app = (EsAppDelegate *)[UIApplication sharedApplication].delegate;
    if (![_reportPicker isDescendantOfView:app.window]){
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _reportPicker.transform = CGAffineTransformIdentity;
        CGRect rect ;
        rect = _pickerStatusView.frame ;
        rect.origin.y = CGRectGetHeight(MyAppDelegate.window.frame);
        _pickerStatusView.frame = rect ;
        
    } completion:^(BOOL finished) {
        [_reportPicker removeFromSuperview];
        [_pickerStatusView removeFromSuperview];
    }];
}

#pragma mark - UIPickerView DataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    txtTitle.text = [pickerArray objectAtIndex:row];
    reportTypeStr = [[reportArr objectAtIndex:row]objectForKey:@"styleId"];
}

#pragma mark - 获取上报类型

- (void)getReportType
{
    //    NSDictionary* params = @{@"token" : [Global sharedSingleton].userVerify.user.token,
    //                             @"reportName" : @"上报2",
    //                             @"reportContent" : @"上报2内容",
    //                             @"reportFile" : @"",
    //                             @"styleId":@"13"};
    
    NSDictionary* params = @{@"token" : [Global sharedSingleton].userVerify.user.token};
    BaseDataSource* net = [BaseDataSource new];
    [SVProgressHUD showWithStatus:@"查询中..." maskType:SVProgressHUDMaskTypeGradient];
    [net startPostRequestWithParamsAndUrl:params method:@"getReportStyle" upFiles:nil completion:^(id responsedict){
        [SVProgressHUD dismiss];
        NSString *errMsg = net.errorMsg;
        if(!net.errorCode)
        {
            NSDictionary *reportDic = responsedict;
            NSArray *arr = [reportDic objectForKey:@"resultlist"];
            reportArr = arr;
            NSMutableArray *arry = [[NSMutableArray alloc]init];
            for (int i=0;i < arr.count;i++) {
                NSDictionary *dic =[arr objectAtIndex:i];
                if ([dic respondsToSelector:@selector(objectForKey:)]) {
                    
                    [arry addObject:[dic objectForKey:@"styleName"]];
                }
            }
            pickerArray = arry;
            txtTitle.text = [pickerArray objectAtIndex:0]?[pickerArray objectAtIndex:0]:@"";
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:errMsg];
            
        }
    }];
}

@end
