/*--------------------------------------------
 *Name：ImgBtn
 *Desc：用于带事件的存储图片容器
 *--------------------------------------------
 *Name：UIChooseImg
 *Desc：用于存储多张图片的容器
 *--------------------------------------------
 *Date：2014/05/23
 *Auth：lip
 *--------------------------------------------*/

#import <UIKit/UIKit.h>
#import "UIPhotoBrowser.h"

@class ImgBtn;

#pragma mark - ImgBtnDelegate-------------------------------------------------
@protocol ImgBtnDelegate <NSObject>

-(void)imgBtnTouchCallBak:(ImgBtn*)sender;

@end

typedef NS_ENUM(NSInteger, ImgBtnType) {
    ImgBtnTypeImg     = 0,
    ImgBtnTypeBtn     = 1
};

#pragma mark - ImgBtn-------------------------------------------------
@interface ImgBtn : UIControl

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) ImgBtnType btnType;
@property (assign, nonatomic) NSInteger index;

@end

#pragma mark - UIChooseImg-------------------------------------------------
@interface UIChooseImg : UIScrollView<UIPhotoBrowserDelegate>

@property (assign, nonatomic) int imgNum;
@property (strong, nonatomic,getter = isImageDtas) NSArray *imgDatas;
@property (weak, nonatomic) id<ImgBtnDelegate> ImgDelegate;

//添加图片
-(void)addImage:(UIImage*)image;

@end
