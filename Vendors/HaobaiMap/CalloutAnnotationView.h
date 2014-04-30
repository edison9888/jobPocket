//
//  CalloutAnnotationView
//  
//
//
#import "MAMapKit.h"

@interface CalloutAnnotationView : MAAnnotationView
{
    UILabel *_nameLabel;
    UILabel *_phoneNumberLabel;
    UILabel *_addressLabel;
    
    UIImageView *_leftImageView;
    UIImageView *_rightImageView;
}

@property (strong, nonatomic) NSDictionary *info;

+ (UIImage *)getCharImageByIndex:(int)index;

@end
