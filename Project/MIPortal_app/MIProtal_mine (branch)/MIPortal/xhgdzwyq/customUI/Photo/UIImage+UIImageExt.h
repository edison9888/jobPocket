/*--------------------------------------------
 *Name：UIImage+UIImageExt.h
 *Desc：图片等比缩放
 *Date：2014/05/23
 *Auth：lip
 *--------------------------------------------*/

#import <UIKit/UIKit.h>

@interface UIImage (UIImageExt)

//图片等比缩放
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
