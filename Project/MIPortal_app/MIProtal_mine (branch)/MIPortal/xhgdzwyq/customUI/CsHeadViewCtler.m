/*--------------------------------------------
 *Name：CsHeadViewCtler.m
 *Desc：自定义的头部展示模块,包括背景图，姓名，和人物照片
 *Date：2014/06/03
 *Auth：hehx
 *--------------------------------------------*/

#import "CsHeadViewCtler.h"

@interface CsHeadViewCtler ()

@end

@implementation CsHeadViewCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat padding = 20;
    CGFloat iconH;

    //右下角的人物头像图标
    UIImage *icon = [UIImage imageNamed:@"mine_head_icon"];
    UIImageView *iconView = [[UIImageView alloc] initWithImage:icon];
    iconH = icon.size.height;
    CGFloat iconW = icon.size.width;
    CGFloat iconX = CGRectGetWidth(self.view.frame) - iconW - padding;
    CGFloat iconY = CGRectGetHeight(self.view.frame)- iconH;
    iconView.frame = CGRectMake(iconX, iconY, iconW, iconH);
    [self.view addSubview:iconView];
    
    
    //整个背景图
    CGFloat bgH = (_custHeight == 0? 160 : _custHeight) - iconH * 0.5;
    //减去半个icon的高度
    UIImage *bg = [UIImage imageNamed:@"mine_head_bg"];
    UIImageView *bgView = [[UIImageView alloc] initWithImage:bg];
    bgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), bgH);
    [self.view addSubview:bgView];
    
    //多加一个大大的透明按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = bgView.frame;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    //用户姓名
    NSString *name = @"用户名";
    CGSize nameSize = [name sizeWithFont:[UIFont systemFontOfSize:18]];
    
    UILabel *label = [UILabel new];
    label.text = name;
    CGFloat labW = nameSize.width;
    CGFloat labH = nameSize.height;
    CGFloat labY = CGRectGetHeight(bgView.frame) - labH;
    CGFloat labX = CGRectGetWidth(bgView.frame) - labW - CGRectGetMinX(iconView.frame) - padding;
    label.frame = CGRectMake(labX, labY, labW, labY);
    [self.view addSubview:label];
}

-(void)btnClick:(UIButton *) btn
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
