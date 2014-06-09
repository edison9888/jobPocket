/*--------------------------------------------
 *Name：UIPickerImg
 *Desc：用于图片缩放
 *--------------------------------------------
 *Name：UIPhotoBrowser
 *Desc：用于多张图片浏览和删除图片
 *--------------------------------------------
 *Date：2014/05/23
 *Auth：lip
 *--------------------------------------------*/

#import "UIPhotoBrowser.h"
#import "UIChooseImg.h"

#pragma mark - UIPickerImg
@implementation UIPickerImg
{
    UIImageView *imgV;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initControl];
    }
    return self;
}

/**
 *	@method	初始化控件
 */
-(void)initControl
{
    [self setUserInteractionEnabled:YES];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.minimumZoomScale = 1.0; // 最小倍数
    self.maximumZoomScale = 3.0; // 最大倍数
    imgV = [[UIImageView alloc]init];
    [self addSubview:imgV];
}

/**
 *	@method 设置图片
 */
-(void)setImage:(UIImage *)image
{
    _image = image;
    imgV.image = _image;
    CGRect tempRect = self.frame;
    CGSize tempSize = [self autoResizeImage:tempRect.size imgSize:_image.size];
    imgV.frame = CGRectMake((tempRect.size.width-tempSize.width)/2,
                            (tempRect.size.height-tempSize.height)/2,
                            tempSize.width, tempSize.height);
    self.contentSize = tempSize;
}

/**
 *  @method	等比例缩放
 *  @param  viewSize 缩放大小
 *  @param  imgSize  图片大小
 */
-(CGSize)autoResizeImage:(CGSize)viewSize imgSize:(CGSize)imgSize
{
    CGFloat RatioW = 0;
    CGFloat RatioH = 0;
    CGFloat Ratio = 0;
    
    CGFloat widthFactor = viewSize.width / imgSize.width;
    CGFloat heightFactor = viewSize.height / imgSize.height;
    
    if((widthFactor > heightFactor && widthFactor != 1) || heightFactor == 1)
        Ratio = widthFactor;
    else
        Ratio = heightFactor;
    
    if (imgSize.width <= viewSize.width && imgSize.height <= viewSize.height)
    {
        RatioW = imgSize.width;
        RatioH = imgSize.height;
    } else
    {
        RatioW = imgSize.width * Ratio;
        RatioH = imgSize.height * Ratio;
    }
    if(RatioH > viewSize.height || RatioW > viewSize.width)
    {
        return [self autoResizeImage:viewSize imgSize:CGSizeMake(RatioW, RatioH)];
    }
    return CGSizeMake(RatioW,RatioH);
}
@end


#pragma mark - UIPhotoBrowser
@implementation UIPhotoBrowser
{
    CGRect minRect;
    CGRect maxRect;
    UIScrollView *scrV;
    UILabel *labInfo;
    BOOL isChange;
    UIChooseImg *chooseImg;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        maxRect = [UIScreen mainScreen].bounds;
        CGSize mainSize = maxRect.size;
        self.frame = CGRectMake(mainSize.width/2, mainSize.height/2, 0, 0);
        minRect = self.frame;
        isChange = NO;
        [self initControl];
    }
    return self;
}

/**
 *	@method	初始化控件
 */
-(void)initControl
{
    self.backgroundColor = [UIColor blackColor];
    self.clipsToBounds = YES;
    scrV = [[UIScrollView alloc]init];
    scrV.showsHorizontalScrollIndicator = NO;
    scrV.showsVerticalScrollIndicator = NO;
    scrV.frame = maxRect;
    scrV.pagingEnabled = YES;
    scrV.clipsToBounds = YES;
    scrV.delegate = self;
    [self addSubview:scrV];

    
    CGFloat spitW = 10,vH = 40,btnW = 60,btnH = 25;
    CGFloat cy = (vH-btnH)/2,cx = spitW;
    UIView *headView = [[UIView alloc]init];
    headView.frame = CGRectMake(0, maxRect.size.height-vH, maxRect.size.width, vH);
    headView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self addSubview:headView];
    
    UIButton *btnClose = [[UIButton alloc]init];
    btnClose.backgroundColor = [UIColor blueColor];
    [btnClose setImage:[UIImage imageNamed:@"photo_cancel.png"] forState:UIControlStateNormal];
    //[btnClose setTitle:@"关闭" forState:UIControlStateNormal];
    btnClose.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    btnClose.frame = CGRectMake(cx, cy, btnW, btnH);
    [btnClose addTarget:self action:@selector(btnClose_touch) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:btnClose];
    
    CGFloat labW = 100;
    cx = (maxRect.size.width-labW)/2;
    labInfo = [[UILabel alloc]init];
    labInfo.backgroundColor = [UIColor clearColor];
    labInfo.textColor = [UIColor whiteColor];
    labInfo.font = [UIFont boldSystemFontOfSize:14];
    labInfo.textAlignment = NSTextAlignmentCenter;
    labInfo.frame = CGRectMake(cx, cy, labW, btnH);
    [headView addSubview:labInfo];
    
    cx = maxRect.size.width-spitW-btnW;
    UIButton *btnDelete = [[UIButton alloc]init];
    btnDelete.backgroundColor = [UIColor blueColor];
    btnDelete.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [btnDelete setImage:[UIImage imageNamed:@"photo_delete.png"] forState:UIControlStateNormal];
    //[btnDelete setTitle:@"删除" forState:UIControlStateNormal];
    btnDelete.frame = CGRectMake(cx, cy, btnW, btnH);
    [btnDelete addTarget:self action:@selector(btnDelete_touch) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:btnDelete];
}

/**
 *	@method	显示图层
 */
-(void)show
{
    labInfo.text = [NSString stringWithFormat:@"%d/%d",self.pageIndex,[self.imgDatas count]];
    [[UIApplication sharedApplication].keyWindow addSubview:self] ;
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof (weakSelf) strongSelft = weakSelf;
        strongSelft.frame = maxRect;
        strongSelft.alpha = 1;
    } completion:^(BOOL finished) {
        __strong typeof (weakSelf) strongSelft = weakSelf;
        CGRect tempRect = strongSelft.frame;
        CGFloat cx = 0;
        NSInteger i = 1;
        for(UIImage *img in strongSelft.imgDatas)
        {
            tempRect.origin.x = cx;
            UIPickerImg *imgScroll = [[UIPickerImg alloc]initWithFrame:tempRect];
            imgScroll.image = img;
            imgScroll.index = i;
            imgScroll.delegate = strongSelft;
            [scrV addSubview:imgScroll];
            
            cx = CGRectGetMaxX(imgScroll.frame);
            scrV.contentSize = CGSizeMake(cx, 0);
            i++;
        }
        //移动到指定的图片位置
        CGFloat index = (CGFloat)strongSelft.pageIndex;
        [scrV setContentOffset:CGPointMake((index-1)*maxRect.size.width, 0) animated:NO];
        
    }];
}

//删除图片
-(void)btnDelete_touch
{
    if(self.pageIndex <= 0)return;
    isChange = YES;
    
    BOOL isPass = NO;
    CGRect tempR = CGRectZero;
    for(UIView *v in scrV.subviews)
    {
        UIPickerImg *pi = (UIPickerImg*)v;
        if(pi.index == self.pageIndex && isPass == NO)
        {
            tempR = pi.frame;
            [pi removeFromSuperview];
            pi = nil;
            isPass = YES;
        }else if(isPass)
        {
            CGRect tempR2 = pi.frame;
            pi.index--;
            pi.frame = tempR;
            tempR = tempR2;
        }
    }
    scrV.contentSize = CGSizeMake(scrV.contentSize.width-scrV.frame.size.width, 0);
    [self.imgDatas removeObjectAtIndex:self.pageIndex-1];
    
    if(self.pageIndex >= [self.imgDatas count] && self.pageIndex > 1)
        self.pageIndex--;
    
    labInfo.text = [NSString stringWithFormat:@"%d/%d",self.pageIndex,[self.imgDatas count]];
    //图片全部删除，消失掉
    if([self.imgDatas count] == 0)
        [self dismiss];
    
    if (self.imgDatas.count < [Global sharedSingleton].photoNum) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showBtnImg" object:nil];
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


//消失
-(void)dismiss
{
    if([self.delegate respondsToSelector:@selector(dataFinish:)])
    {
        [self.delegate dataFinish:isChange];
    }
    
    __weak typeof (self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof (weakSelf) strongSelft = weakSelf;
        strongSelft.frame = minRect;
        strongSelft.alpha = 0;
    } completion:^(BOOL finished) {
        __strong typeof (weakSelf) strongSelft = weakSelf;
        [strongSelft removeFromSuperview];
    }];
}

//关闭
-(void)btnClose_touch
{
    [self dismiss];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if(![scrollView isKindOfClass:[UIPickerImg class]]) return nil;
    return [scrollView subviews][0]; //返回ScrollView上添加的需要缩放的视图
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    if(![scrollView isKindOfClass:[UIPickerImg class]]) return;
    //缩放结束后被调用
    [scrollView setZoomScale:scale animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //刷新数量信息
    if([scrollView isKindOfClass:[UIPickerImg class]]) return;
    CGPoint p = scrollView.contentOffset;
    self.pageIndex = 1+(NSInteger)(p.x/scrollView.frame.size.width);
    labInfo.text = [NSString stringWithFormat:@"%d/%d",self.pageIndex,[self.imgDatas count]];
    
}

@end
