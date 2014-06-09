/*--------------------------------------------
 *Name：CsHeadViewCtler.h
 *Desc：自定义的头部展示模块
 *Date：2014/06/03
 *Auth：hehx
 *--------------------------------------------*/
#import "EsHeadView.h"

@implementation EsHeadView

- (id)initBlock:(ButtonSelectBlock)block
{
    self.block = block;
    return [self init];
}
- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame Block:nil];
}
- (id)initWithFrame:(CGRect)frame Block:(ButtonSelectBlock)block
{
    self.view.frame = frame;
    self.block = block;
    return [self initWithNibName:nil bundle:nil];
}

-(id)init
{
    self.view.frame = CGRectMake(0, 0, 320, 180);
    return [self initWithNibName:nil bundle:nil];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        CGFloat padding = 10;
        CGFloat iconH;
        
        //右下角的人物头像图标
        UIImage *icon = [UIImage imageNamed:@"mine_head_icon"];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:icon];
        iconH = icon.size.height;
        CGFloat iconW = icon.size.width;
        CGFloat iconX = CGRectGetWidth(self.view.frame) - iconW - padding;
        CGFloat iconY = CGRectGetHeight(self.view.frame)- iconH;
        iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
        
        //整个背景图
        CGFloat bgH = self.view.frame.size.height - iconH * 0.5;
        //减去半个icon的高度
        UIImage *bg = [UIImage imageNamed:@"mine_head_bg"];
        UIImageView *bgView = [[UIImageView alloc] initWithImage:bg];
        bgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), bgH);
        [self.view addSubview:bgView];
        
        //多加一个大大的透明按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = bgView.frame;
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        //用户姓名
        NSString *name = @"用户名";
        CGSize nameSize = [name sizeWithFont:[UIFont systemFontOfSize:18]];
        
        UILabel *label = [UILabel new];
        label.text = name;
        CGFloat labW = nameSize.width;
        CGFloat labH = nameSize.height;
        CGFloat labY = CGRectGetMaxY(bgView.frame) - labH;
        CGFloat labX = CGRectGetMinX(iconView.frame) - labW;
        label.frame = CGRectMake(labX, labY, labW, labH);
        label.backgroundColor  = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        [self.view addSubview:label];
        
        [self.view addSubview:iconView];
    }
    return self;
}

- (void)btnClick:(UIButton *)btn
{
    //替换背景
    UIActionSheet *actionSheet = nil;
    //检测是否有摄像头
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]
                       initWithTitle:nil
                       delegate:(id<UIActionSheetDelegate>)self
                       cancelButtonTitle:@"取消"
                       destructiveButtonTitle:nil
                       otherButtonTitles:@"从相册选择", @"拍照",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    }else
    {
        actionSheet = [[UIActionSheet alloc]
                       initWithTitle:nil
                       delegate:(id<UIActionSheetDelegate>)self
                       cancelButtonTitle:@"取消"
                       destructiveButtonTitle:nil
                       otherButtonTitles:@"从相册选择",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    }
    [actionSheet showInView:self.parentViewController.view];
}

#pragma mark - 处理相册相机按钮选中事件
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



@end
