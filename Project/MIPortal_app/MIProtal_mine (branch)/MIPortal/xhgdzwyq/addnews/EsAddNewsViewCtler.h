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

//#import "BaseNavViewCtler.h"
#import "UIChooseImg.h"

@interface CSCheckBox : UIControl
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL checked;
@end

@interface EsAddNewsViewCtler : BaseViewCtler<ImgBtnDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

@end
