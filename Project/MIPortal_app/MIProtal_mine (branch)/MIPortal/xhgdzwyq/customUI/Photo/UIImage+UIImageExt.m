/*--------------------------------------------
 *Name：UIImage+UIImageExt.h
 *Desc：图片等比缩放
 *Date：2014/05/23
 *Auth：lip
 *--------------------------------------------*/

#import "UIImage+UIImageExt.h"

@implementation UIImage (UIImageExt)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        //center the image
        if(widthFactor > heightFactor)
            thumbnailPoint.y = (targetHeight -scaledHeight)*0.5;
        else if(widthFactor < heightFactor)
            thumbnailPoint.x = (targetWidth - scaledWidth)*0.5;
    }
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thnumbnailRect = CGRectZero;
    thnumbnailRect.origin = thumbnailPoint;
    thnumbnailRect.size.width = scaledWidth;
    thnumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thnumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end
