/*--------------------------------------------
 *Name：ImgBtn
 *Desc：用于带事件的存储图片容器
 *--------------------------------------------
 *Name：UIChooseImg
 *Desc：用于存储多张图片的容器
 *--------------------------------------------
 *Date：2014/05/23
 *Auth：lip
 *--------------------------------------------*/

#import "UIChooseImg.h"
#import "UIImage+UIImageExt.h"

#pragma mark - ImgBtn
@implementation ImgBtn
{
    UIImageView *imgView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initControl];
    }
    return self;
}

//初始化控件
-(void)initControl
{
    imgView = [[UIImageView alloc]init];
    imgView.frame = self.bounds;
    [self addSubview:imgView];
    
}

//设置图片
-(void)setImage:(UIImage *)image
{
    _image = image;
    imgView.image = _image;
}
@end

#pragma mark - UIChooseImg
#define IMGW 65
#define IMGH 65
#define SPITW 8


@implementation UIChooseImg
{
    ImgBtn *btnImg;
    CGRect curRect;
    NSMutableArray *imageDatas;
    CGFloat yOffset;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageDatas = [[NSMutableArray alloc]init];
        curRect = CGRectZero;
        [self initControl];
        yOffset = SPITW;
    }
    return self;
}

//初始化控件
-(void)initControl
{
    CGRect tempRect = self.frame;
    //tempRect.size.height = IMGH+SPITW*2;
    //tempRect.size.height = IMGH*2+SPITW*3;
    self.frame = tempRect;
    self.layer.borderWidth = 1;
    //self.layer.borderColor = [RGB(179,179,179,1) CGColor];
    self.layer.borderColor = [kUIColorFromRGB(0xb3b3b3) CGColor];
    //self.layer.cornerRadius = 3;
    
    btnImg = [[ImgBtn alloc]initWithFrame:CGRectMake(SPITW, SPITW, IMGW, IMGH)];
    btnImg.image = [UIImage imageNamed:@"add_icon.png"];
    btnImg.btnType = ImgBtnTypeBtn;
    btnImg.index = 0;
    [btnImg addTarget:self action:@selector(imgBtn_Touch:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnImg];
    //self.contentSize = CGSizeMake(1000, 0);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBtnImg) name:@"showBtnImg" object:nil];
}

//图片点击事件
-(void)imgBtn_Touch:(id)sender
{
    ImgBtn *tempBtn = (ImgBtn*)sender;
    if(tempBtn.btnType == ImgBtnTypeImg)
    {   //浏览图片
        UIPhotoBrowser *pb = [[UIPhotoBrowser alloc]init];
        pb.delegate = self;
        pb.imgDatas = imageDatas;
        pb.pageIndex = tempBtn.index;
        [pb show];
    }
    else
    {//选取图片
        if([self.ImgDelegate respondsToSelector:@selector(imgBtnTouchCallBak:)])
        {
            [self.ImgDelegate imgBtnTouchCallBak:sender];
        }
    }
    
    [Global sharedSingleton].photoNum = self.imgNum;
}

//添加图片
-(void)addImage:(UIImage*)image
{
    [imageDatas addObject:image];
    
    CGFloat cx =CGRectGetMaxX(curRect)+SPITW;
    //ImgBtn *cellImg = [[ImgBtn alloc]initWithFrame:CGRectMake(cx, SPITW, IMGW, IMGH)];
    ImgBtn *cellImg = [[ImgBtn alloc]initWithFrame:CGRectMake(cx, yOffset, IMGW, IMGH)];
    cellImg.image = [image imageByScalingAndCroppingForSize:CGSizeMake(IMGW*2, IMGH*2)];
    cellImg.btnType = ImgBtnTypeImg;
    cellImg.index = [imageDatas count];
    [cellImg addTarget:self action:@selector(imgBtn_Touch:) forControlEvents:UIControlEventTouchUpInside];
    curRect = cellImg.frame;
    [self addSubview:cellImg];
    
    //加按钮外后移动
    cx = CGRectGetMaxX(curRect)+SPITW;
    //btnImg.frame = CGRectMake(cx, SPITW, IMGW, IMGH);
    btnImg.frame = CGRectMake(cx, yOffset, IMGW, IMGH);
    //达到指定的数量就就隐藏
    if([imageDatas count] == self.imgNum)
    {
        btnImg.hidden = YES;
    }else
    {
        if (!imageDatas.count>3) {
            self.contentSize = CGSizeMake(CGRectGetMaxX(btnImg.frame)+SPITW, 0);
        }
    }
    
    //图片四张换行显示
    if (imageDatas.count == 4) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseImg" object:nil];
        curRect = CGRectZero;
        yOffset = CGRectGetMaxY(btnImg.frame)+SPITW;
        cx = CGRectGetMaxX(curRect)+SPITW;
        btnImg.frame = CGRectMake(cx, yOffset, IMGW, IMGH);
    }
    
    //显示完整添加按钮
    if (self.contentSize.width>=320) {
        CGPoint offSet = self.contentOffset;
        offSet.x = self.contentSize.width - self.frame.size.width;
        self.contentOffset = offSet;
    }
    
}

-(void)dataFinish:(BOOL)isChange
{
    if(!isChange) return;
    for(UIView *v in self.subviews)
    {
        if(![v isKindOfClass:[ImgBtn class]]) continue;
        
        ImgBtn *ib = (ImgBtn*)v;
        if(ib.btnType == ImgBtnTypeImg)
           [ib removeFromSuperview];
        
        CGFloat cx = 0;
        curRect = CGRectZero;
        for(UIImage *image in imageDatas)
        {
            cx =CGRectGetMaxX(curRect)+SPITW;
            ImgBtn *cellImg = [[ImgBtn alloc]initWithFrame:CGRectMake(cx, SPITW, IMGW, IMGH)];
            cellImg.image = [image imageByScalingAndCroppingForSize:CGSizeMake(IMGW*2, IMGH*2)];
            cellImg.btnType = ImgBtnTypeImg;
            cellImg.index = [imageDatas count];
            [cellImg addTarget:self action:@selector(imgBtn_Touch:) forControlEvents:UIControlEventTouchUpInside];
            curRect = cellImg.frame;
            [self addSubview:cellImg];
        }
        //加按钮外后移动
        cx = CGRectGetMaxX(curRect)+SPITW;
        btnImg.frame = CGRectMake(cx, SPITW, IMGW, IMGH);
        //达到指定的数量就就隐藏
        if([imageDatas count] == self.imgNum)
        {
            btnImg.hidden = YES;
        }else
        {
            self.contentSize = CGSizeMake(CGRectGetMaxX(btnImg.frame)+SPITW, 0);
        }
        
    }
}

//返回图片数组
-(NSArray*)isImageDtas
{
    NSMutableArray *arrData = [[NSMutableArray alloc]init];
    for(UIImage *img in imageDatas)
    {
        //压缩图片
        NSData *data = UIImageJPEGRepresentation(img,0.2);
        [arrData addObject:data];
    }
    return arrData;
}

- (void)showBtnImg
{
    btnImg.hidden = NO;
}

@end
