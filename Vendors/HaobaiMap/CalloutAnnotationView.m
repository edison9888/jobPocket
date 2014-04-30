//
//  CalloutAnnotationView
//

#import "CalloutAnnotationView.h"
#import <QuartzCore/QuartzCore.h>
#import "Utils.h"

#define  Arror_height 10

static NSString *charArrayString = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";

@implementation CalloutAnnotationView

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.canShowCallout = YES;
        self.frame = CGRectMake(0, 0, 240, 100);
        
        {
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont boldSystemFontOfSize:15];
            label.textColor = [UIColor whiteColor];
            label.numberOfLines = 0;
            [self addSubview:label];
            
            _nameLabel = label;
        }
        
        {
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor whiteColor];
            label.numberOfLines = 0;
            [self addSubview:label];
            
            _phoneNumberLabel = label;
        }
        
        {
            UILabel *label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor whiteColor];
            label.numberOfLines = 0;
            [self addSubview:label];
            
            _addressLabel = label;
        }
        
        {
            UIImage *imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_left.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:13];
            UIImageView *leftBgd = [[UIImageView alloc] initWithImage:imageNormal];
            leftBgd.frame   = CGRectMake(0, 0, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame));
            [self addSubview:leftBgd];
            [self sendSubviewToBack:leftBgd];
            
            _leftImageView = leftBgd;
        }
        
        {
            UIImage *imageNormal = [[UIImage imageNamed:@"icon_paopao_middle_right.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:13];
            UIImageView *rightBgd = [[UIImageView alloc] initWithImage:imageNormal];
            rightBgd.frame   = CGRectMake(CGRectGetWidth(self.frame)/2, 0, CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame));
            [self addSubview:rightBgd];
            [self sendSubviewToBack:rightBgd];
            
            _rightImageView = rightBgd;
        }
        
    }
    return self;
}

- (void)setInfo:(NSDictionary *)info
{
    _info = info;
    
    id name = [info objectForKey:@"name"];
    _nameLabel.text = nil;
    if (name && [name isKindOfClass:[NSString class]] && [name length] > 0) {
        _nameLabel.text = name;
    } else {
        name = [info objectForKey:@"hp_name"];
        if (name && [name isKindOfClass:[NSString class]] && [name length] > 0) {
            _nameLabel.text = name;
        }
    }
    
    id tel = [info objectForKey:@"tel"];
    _phoneNumberLabel.text = nil;
    if (tel && [tel isKindOfClass:[NSString class]] && [tel length] > 0) {
        _phoneNumberLabel.text = [NSString stringWithFormat:@"电话：%@", tel];
    }
    
    id addr = [info objectForKey:@"addr"];
    if (addr && [addr isKindOfClass:[NSString class]] && [addr length] > 0) {
        _addressLabel.text = [NSString stringWithFormat:@"地址: %@", addr];
    } else {
        addr = [info objectForKey:@"hp_address"];
        if (addr && [addr isKindOfClass:[NSString class]] && [addr length] > 0) {
            _addressLabel.text = [NSString stringWithFormat:@"地址: %@", addr];
        }
    }
    
    [self autoLayoutSubViews];
}

- (void)autoLayoutSubViews
{
    int xOffset = 5, yOffset = 5, width = self.frame.size.width - 2 * xOffset, height = 1000;
    
    CGSize size = CGSizeZero;
    UILabel *label = nil;
    
    {
        label = _nameLabel;
        size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(width, height) lineBreakMode:UILineBreakModeWordWrap];
        label.frame = CGRectMake(xOffset, yOffset, width, size.height);
        
        yOffset += size.height + 3;
    }
    
    {
        label = _phoneNumberLabel;
        size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(width, height) lineBreakMode:UILineBreakModeWordWrap];
        label.frame = CGRectMake(xOffset, yOffset, width, size.height);
        
        yOffset += size.height + 2;
    }
    
    {
        label = _addressLabel;
        size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(width, height) lineBreakMode:UILineBreakModeWordWrap];
        label.frame = CGRectMake(xOffset, yOffset, width, size.height);
        
        yOffset += size.height;
    }
    
    CGRect rect = self.frame;
    rect.size.height = yOffset + Arror_height;
    self.frame = rect;
    
    _leftImageView.frame = CGRectMake(0, 0, ceilf(self.frame.size.width/2), self.frame.size.height);
    _rightImageView.frame = CGRectMake(CGRectGetMaxX(_leftImageView.frame), 0, ceilf(self.frame.size.width/2), self.frame.size.height);
    
    self.centerOffset = CGPointMake(-120, -1 * (rect.size.height + 15));
}

+ (UIImage *)getCharImageByIndex:(int)index
{
    UIImage *image = [UIImage imageNamed:@"annotation_map@2x.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height * 3 / 4)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:24];
    label.textColor = [UIColor whiteColor];
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumFontSize = 10;
    label.textAlignment = UITextAlignmentCenter;
    if (index < charArrayString.length) {
        label.text = [NSString stringWithFormat:@"%c", [charArrayString characterAtIndex:index]];
    } else {
        label.text = [NSString stringWithFormat:@"%d", index];
    }
    [imageView addSubview:label];
    
    image = [Utils imageWithView:imageView];
    
    return [UIImage imageWithCGImage:image.CGImage scale:2 orientation:image.imageOrientation];
}
@end
