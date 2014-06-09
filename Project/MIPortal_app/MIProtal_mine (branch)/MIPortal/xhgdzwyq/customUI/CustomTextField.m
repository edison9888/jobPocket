/*--------------------------------------------
 *Name：EsAddNewsViewCtler.h
 *Desc：自定义的textfield,改变了placeholder等一些属性
 *Date：2014/05/21
 *Auth：hehx
 *--------------------------------------------*/
#import "CustomTextField.h"

@implementation CustomTextField
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - 文字左右缩进20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 3);
}

-(void)drawPlaceholderInRect:(CGRect)rect
{
    //[self.placeholderFontColor setFill];
    [[self placeholder]drawInRect:CGRectZero withFont:[UIFont systemFontOfSize:self.placeholderFontSize]];
}
@end
