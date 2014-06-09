/*--------------------------------------------
 *Name：CSTextField
 *Desc：自定义的textfield
 *Date：2014/05/21
 *Auth：lip
 *--------------------------------------------*/

#import "CSTextView.h"

@implementation CSTextView
{
    UILabel *labPlaceholder;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initControl];
    }
    return self;
}

//初始化控件
-(void)initControl
{
    self.font = [UIFont boldSystemFontOfSize:14];
    //self.layer.borderWidth = 1;
    //self.layer.borderColor = [RGB(190,190,190,1) CGColor];
    //self.layer.cornerRadius = 3;
    
    CGFloat spitW = 5;
    CGFloat labw = CGRectGetWidth(self.frame)-spitW*2;
    labPlaceholder = [[UILabel alloc]init];
    labPlaceholder.textColor = RGB(185, 185, 191, 1);
    labPlaceholder.frame = CGRectMake(spitW, 3, labw, 25);
    labPlaceholder.backgroundColor = [UIColor clearColor];
    labPlaceholder.font = self.font;
    [self addSubview:labPlaceholder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(TextDidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
}

#pragma mark - notification function
- (void)TextDidChange:(NSNotification *)notification
{
    if(self.text != nil && [self.text length] > 0)
        labPlaceholder.hidden = YES;
    else
        labPlaceholder.hidden = NO;
}

#pragma mark - property function
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    labPlaceholder.text = _placeholder;
}

-(void)setFont2:(UIFont *)font2
{
    self.font = font2;
    labPlaceholder.font = self.font;
}


@end
