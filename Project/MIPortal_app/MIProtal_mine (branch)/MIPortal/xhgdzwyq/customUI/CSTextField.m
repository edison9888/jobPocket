/*--------------------------------------------
 *Name：CSTextField
 *Desc：自定义的textfield
 *Date：2014/05/21
 *Auth：lip
 *--------------------------------------------*/

#import "CSTextField.h"

@implementation CSTextField

- (id)init
{
    self = [super init];
    if (self) {
        self.font = [UIFont boldSystemFontOfSize:14];
        //self.layer.borderWidth = 1;
        //self.layer.borderColor = [RGB(190,190,190,1) CGColor];
        //self.layer.cornerRadius = 3;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    bounds.origin.x +=5;
    bounds.size.width -= 10;
    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    bounds.origin.x +=5;
    bounds.size.width -= 10;
    return bounds;
}


@end
