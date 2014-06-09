/*--------------------------------------------
 *Name：EsMineViewCtler.h
 *Desc：我的界面模块
 *Date：2014/05/30
 *Auth：shanhq
 *--------------------------------------------*/

#import "EsMineViewCtler.h"
#import "ToastAlertView.h"
#import "EsMineDetailViewCtler.h"

@interface EsMineViewCtler ()
{
    UIScrollView *_contentScroll;
}
@end

@implementation EsMineViewCtler

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的";
        [self setBackButton];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    {
        UIScrollView* v = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        v.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        v.backgroundColor = [UIColor clearColor];
        v.showsVerticalScrollIndicator = NO;
        [self.view addSubview:v];
        _contentScroll = v;
    }
    
    {
        int originX = 15;
        int originY = 24;
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        if ( IOS7_OR_LATER )
        {
            originY += 20;
        }
#endif
        
        NSArray *array = @[@"个人信息", @"我的项目", @"我的说说", @"工作日志"];
        NSArray *imgArr = @[@"mine_person", @"mine_project", @"mine_saySay", @"mine_workLog"];
        
        for (NSString *string in array) {
            
            UIButton *btn = [[UIButton alloc]init];
            btn.backgroundColor = [UIColor clearColor];
            [btn setTitleColor:kUIColorFromRGB(0x333333) forState:UIControlStateNormal];
            UIImage *image = [UIImage imageNamed:@"mine_bg"];
            CGRect rect;
            rect.size = image.size;
            rect.origin.x = originX;
            rect.origin.y = originY;
            btn.frame = rect;
            [btn setTitle:string forState:UIControlStateNormal];
            [btn setTitleEdgeInsets:UIEdgeInsetsMake(71, -btn.titleLabel.bounds.size.width-45, 0, 0)];//设置title在button上的位置（上top，左left，下bottom，右right）
            UIImage *iconImg = [UIImage imageNamed:[imgArr objectAtIndex:[array indexOfObject:string]]];
            [btn setImage:iconImg forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(5,13,21,btn.titleLabel.bounds.size.width)];//设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 33, 20, -33)];//
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//设置button的内容横向居中。。设置content是title和image一起变化
            btn.tag = [array indexOfObject:string];
            [btn addTarget:self action:@selector(onMineBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_contentScroll addSubview:btn];
            //计算下一个图形的位置
            if (CGRectGetMaxX(btn.frame) + CGRectGetWidth(btn.frame) > CGRectGetWidth(self.view.frame)) {
                //换行
                originX = 15;
                originY = CGRectGetMaxY(btn.frame) + 8;
            }
            else
            {
                originX = CGRectGetMaxX(btn.frame) + 8;
                if ([array indexOfObject:string] == array.count - 1)
                {
                    originY = CGRectGetMaxY(btn.frame) + 18;
                }
            }
            
            _contentScroll.contentSize = CGSizeMake(0, CGRectGetMaxY(btn.frame)+8);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onMineBtn:(id)sender
{
    NSInteger btnTag = ((UIButton *)sender).tag;
    EsMineDetailViewCtler *vc = [EsMineDetailViewCtler new];
    vc.selectTag = btnTag;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
