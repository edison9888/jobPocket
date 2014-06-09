/*--------------------------------------------
 *Name：PhotoVCtler
 *Desc：用于测试选择图片控件的代码示例(代码参考示例)
 *Date：2014/05/23
 *Auth：lip
 *--------------------------------------------*/

#import "PhotoVCtler.h"

@interface PhotoVCtler ()
{
    UIChooseImg *chooseImg;
}

@end

@implementation PhotoVCtler

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
    [self initControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化控件
-(void)initControl
{
    CGSize mainSize = [UIScreen mainScreen].bounds.size;
    chooseImg = [[UIChooseImg alloc]initWithFrame:CGRectMake(5, 50, mainSize.width-10, 80)];
    chooseImg.imgNum = 7;
    chooseImg.ImgDelegate = self;
    
    [self.view addSubview:chooseImg];
}

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

@end
