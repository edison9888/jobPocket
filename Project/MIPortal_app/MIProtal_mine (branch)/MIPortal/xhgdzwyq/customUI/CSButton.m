/*--------------------------------------------
 *Name：CSButton
 *Desc：自定义的页面跳转按钮
 *Date：2014/05/23
 *Auth：lip
 *--------------------------------------------*/

#import "CSButton.h"

@implementation CSButton
{
    UILabel *labTitle,*labTitleDetail;
    UIImageView *iconV;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        [self initControl];
    }
    return self;
}

/**
 *	@method	初始化控件
 */
-(void)initControl
{
    //self.layer.borderWidth = 1;
    //self.layer.borderColor = [RGB(190,190,190,1) CGColor];
    
    labTitle = [[UILabel alloc]init];
    labTitle.backgroundColor = [UIColor clearColor];
    labTitle.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:labTitle];
    
    labTitleDetail = [[UILabel alloc]init];
    labTitleDetail.backgroundColor = [UIColor clearColor];
    labTitleDetail.font = [UIFont boldSystemFontOfSize:14];
    labTitleDetail.textColor = RGB(168, 168, 168, 1);
    labTitleDetail.textAlignment = NSTextAlignmentRight;
    [self addSubview:labTitleDetail];
    
    iconV = [[UIImageView alloc]init];
    iconV.image = [UIImage imageNamed:@"arrows_right.png"];
    [self addSubview:iconV];
}

/**
 *	@method 绘制界面
 */
-(void)layoutSubviews
{
    CGFloat spitW= 5;
    CGFloat labH = 30,iconw = 20;
    CGFloat labw = (self.frame.size.width-spitW*2-iconw)/2;
    CGFloat cx = spitW,cy = (self.frame.size.height-labH)/2;
    
    labTitle.frame = CGRectMake(cx , cy, labw, labH);
    cx = CGRectGetMaxX(labTitle.frame);
    
    labTitleDetail.frame = CGRectMake(cx , cy, labw, labH);
    cx = CGRectGetMaxX(labTitleDetail.frame)+5;
    
    iconV.frame = CGRectMake(cx , cy, iconw, labH);
}

/**
 *	@method 设置主标题
 */
-(void)setTitle:(NSString *)title
{
    _title = title;
    labTitle.text = _title;
}

/**
 *	@method 设置副标题
 */
-(void)setTitleDetail:(NSString *)titleDetail
{
    _titleDetail = titleDetail;
    labTitleDetail.text = _titleDetail;
}


@end
