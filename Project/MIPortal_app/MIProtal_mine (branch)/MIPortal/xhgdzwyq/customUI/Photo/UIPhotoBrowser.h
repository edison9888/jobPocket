/*--------------------------------------------
 *Name：UIPickerImg
 *Desc：用于图片缩放
 *--------------------------------------------
 *Name：UIPhotoBrowser
 *Desc：用于多张图片浏览和删除图片
 *--------------------------------------------
 *Date：2014/05/23
 *Auth：lip
 *--------------------------------------------*/

#import <UIKit/UIKit.h>

@interface UIPickerImg : UIScrollView

@property (strong, nonatomic) UIImage *image;//显示的图片
@property (assign, nonatomic) NSInteger index;//图片下标标示

@end


@protocol UIPhotoBrowserDelegate <NSObject>

-(void)dataFinish:(BOOL) isChange;

@end


@interface UIPhotoBrowser : UIControl<UIScrollViewDelegate>

@property (strong, nonatomic) NSMutableArray *imgDatas;//图片数组
@property (assign, nonatomic) NSInteger pageIndex;//当前显示的是第几张图片
@property (weak, nonatomic) id<UIPhotoBrowserDelegate> delegate;

/**
 *	@method	显示图层
 */
-(void)show;

@end
