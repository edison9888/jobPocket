/*--------------------------------------------
 *Name：CSMineHeadView.h
 *Desc：自定义的头部展示模块
 *Date：2014/06/03
 *Auth：shanhq
 *--------------------------------------------*/

#import "CSMineHeadView.h"

@implementation CSMineHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

// 初始化头部view写死的方法，用于mine模块头部
- (id)initWithLeftButtonSelectBlock:(ButtonSelectBlock)backButtonSelectBlock
{
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height = 190;
    self = [super initWithFrame:rect];
    if (self) {
        [self setLeftButtonSelectBlock:backButtonSelectBlock];
    }
    return self;
}

- (void)setLeftButtonSelectBlock:(ButtonSelectBlock)backButtonSelectBlock
{
    self.leftBlock = backButtonSelectBlock;
    
    if (!self.leftButton) {
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (!self.centerButton) {
        self.centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (!self.rightButton) {
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (!self.leftBlock) {
        //        self.leftButton.enabled = NO;
        //self.leftButton.userInteractionEnabled = NO;
        self.leftButton.adjustsImageWhenHighlighted = NO;
    }
    
    if (!self.centerBlock) {
        //self.centerButton.userInteractionEnabled = NO;
        self.centerButton.adjustsImageWhenHighlighted = NO;
    }
    
    if (!self.rightBlock) {
        //self.rightButton.userInteractionEnabled = NO;
        self.rightButton.adjustsImageWhenHighlighted = NO;
    }
    
    [self.leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerButton addTarget:self action:@selector(centerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImage *headImg = [UIImage imageNamed:@"mine_head_bg"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"MineHeadBgView"];
    UIImage *ChangeImg = [UIImage imageWithData:data];
    [self.leftButton setImage:ChangeImg?ChangeImg:headImg forState:UIControlStateNormal];
    
    NSString *string  = [[[[Global sharedSingleton]userVerify]user]clientName];
    [self.centerButton setTitle:string forState:UIControlStateNormal];
    [self.centerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.centerButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
    
    UIImage *iconImg = [UIImage imageNamed:@"mine_head_icon"];
    [self.rightButton setImage:iconImg forState:UIControlStateNormal];
    
    [self autoFit];
    
    [self addSubview:self.leftButton];
    [self addSubview:self.centerButton];
    [self addSubview:self.rightButton];
}

// 自定义view，可以使用很多场合的自定义

- (id)initWithFrame:(CGRect)frame leftButtonSelectBlock:(ButtonSelectBlock)leftButtonSelectBlock centerButtonSelectBlock:(ButtonSelectBlock)centerButtonSelectBlock  rightButtonSelectBlock:(ButtonSelectBlock)rightButtonSelectBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLeftButtonSelectBlock:leftButtonSelectBlock centerButtonSelectBlock:centerButtonSelectBlock rightButtonSelectBlock:rightButtonSelectBlock];
    }
    return self;
}


- (void)setLeftButtonSelectBlock:(ButtonSelectBlock)leftButtonSelectBlock centerButtonSelectBlock:(ButtonSelectBlock)centerButtonSelectBlock  rightButtonSelectBlock:(ButtonSelectBlock)rightButtonSelectBlock
{
    self.leftBlock = leftButtonSelectBlock;
    self.centerBlock = centerButtonSelectBlock;
    self.rightBlock = rightButtonSelectBlock;
    
    if (!self.leftButton) {
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (!self.centerButton) {
        self.centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (!self.rightButton) {
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    if (!self.leftBlock) {
//        self.leftButton.enabled = NO;
        self.leftButton.userInteractionEnabled = NO;
    }
    
    if (!self.centerBlock) {
        self.centerButton.userInteractionEnabled = NO;
    }
    
    if (!self.rightBlock) {
        self.rightButton.userInteractionEnabled = NO;
    }
    
    [self.leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.centerButton addTarget:self action:@selector(centerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.leftButton];
    [self addSubview:self.centerButton];
    [self addSubview:self.rightButton];
}

- (void)leftAction:(UIButton *)button
{
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)centerAction:(UIButton *)button
{
    if (self.centerBlock) {
        self.centerBlock();
    }
}

- (void)rightAction:(UIButton *)button
{
    if (self.rightBlock) {
        self.rightBlock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mrak - 专门用于mine模块头部自定义view的方法
- (void)autoFit
{
    CGRect rect = self.frame;
    UIImage *headImg = [UIImage imageNamed:@"mine_head_bg"];
    rect.size = headImg.size;
    
    self.leftButton.frame = rect;
    
    rect.origin.x = rect.size.width /2.0 + 30;
    rect.origin.y = rect.size.height - 28;
    rect.size = CGSizeMake(40, 30);
    self.centerButton.frame = rect;
    
    UIImage *iconImg = [UIImage imageNamed:@"mine_head_icon"];
    rect.origin.y = self.frame.size.height - iconImg.size.height;
    rect.size = iconImg.size;
    rect.origin.x = CGRectGetMaxX(self.centerButton.frame);
    self.rightButton.frame = rect;
    
}

@end
