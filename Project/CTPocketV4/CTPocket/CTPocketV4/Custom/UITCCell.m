/*--------------------------------------------
 *Name：UITCCell
 *Desc：套餐变更套餐数据控件
 *Date：2014/07/04
 *Auth：lip
 *--------------------------------------------*/

#import "UITCCell.h"

/**
 *  获取套餐数据控件
 */
@implementation UITCCell
{
    CGSize mainSize;
    UIImageView *iconV;
    UILabel *labTile;
    UITextField *txtValue;
    UILabel *labUnit;
    UILabel *labCost;
    UILabel *labxf;
    UISlider *sliderA;
    UILabel *labMin;
    UILabel *labMax;
    UILabel *labUnitTile;
    CGFloat rightW;
    CGFloat spitW;
}

-(id)initWithPoint:(CGPoint)point
{
    mainSize = [UIScreen mainScreen].bounds.size;
    self = [super initWithFrame:CGRectMake(point.x,point.y, mainSize.width, 120)];
    if(self)
    {
        spitW = 15;
        [self initControl];
    }
    return self;
}

-(void)initControl
{
    CGFloat top=10,labH = 25, iconWH = 20;
    CGFloat cx =spitW,cy=top;
    UIFont *font12 = [UIFont systemFontOfSize:12];
    
    iconV = [[UIImageView alloc]initWithFrame:CGRectMake(cx, cy+(labH-iconWH)/2, iconWH, iconWH)];
    iconV.backgroundColor = RGB(115, 193, 69, 1);
    [self addSubview:iconV];
    cx = CGRectGetMaxX(iconV.frame)+3;
    
    labTile = [self createLab];
    labTile.frame = CGRectMake(cx, cy, 40, labH);
    [self addSubview:labTile];
    cx = CGRectGetMaxX(labTile.frame);
    
    txtValue = [[UITextField alloc]initWithFrame:CGRectMake(cx, cy, 60, labH)];
    txtValue.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    txtValue.textAlignment = NSTextAlignmentCenter;
    txtValue.keyboardType = UIKeyboardTypeNumberPad;
    txtValue.layer.borderColor = RGB(216, 216, 216, 1).CGColor;
    txtValue.layer.borderWidth = 1;
    txtValue.font = [UIFont systemFontOfSize:14];
    txtValue.backgroundColor = [UIColor whiteColor];
    txtValue.delegate = self;
    [self addSubview:txtValue];
    cx = CGRectGetMaxX(txtValue.frame)+3;
    
    labUnit = [self createLab];
    labUnit.font = font12;
    labUnit.frame = CGRectMake(cx, cy, 45, labH);
    [self addSubview:labUnit];
    
    CGFloat labyuanW = 15;
    cx = mainSize.width-spitW-labyuanW;
    UILabel *labYuan = [self createLab];
    labYuan.font = font12;
    labYuan.frame = CGRectMake(cx, cy, labyuanW, labH);
    labYuan.text = @"元";
    [self addSubview:labYuan];
    rightW = cx = CGRectGetMinX(labYuan.frame);
    
    labCost = [self createLab];
    labCost.font = [UIFont boldSystemFontOfSize:16];
    labCost.textColor = RGB(115, 193, 69, 1);
    labCost.text = @"0";
    CGFloat labCostW = [Utils widthForString:labCost.text font:labCost.font];
    cx = rightW-labCostW;
    labCost.frame = CGRectMake(cx, cy, labCostW, labH);
    [self addSubview:labCost];
    cx = CGRectGetMinX(labCost.frame);
    
    labxf = [self createLab];
    labxf.font = font12;
    labxf.text = @"消费";
    CGFloat labxfW = [Utils widthForString:labxf.text font:labxf.font];
    cx = cx-labxfW;
    labxf.frame = CGRectMake(cx, cy, labxfW, labH);
    [self addSubview:labxf];
    
    
    //左右轨的图片
    //    UIImage *stetchLeftTrack= [UIImage imageNamed:@"brightness_bar.png"];
    //    UIImage *stetchRightTrack = [UIImage imageNamed:@"brightness_bar.png"];
    //    //滑块图片
    //    UIImage *thumbImage = [UIImage imageNamed:@"mark.png"];
    cx = spitW;
    cy = CGRectGetMaxY(labTile.frame)+10;
    sliderA=[[UISlider alloc]initWithFrame:CGRectMake(cx, cy, mainSize.width-spitW*2, 20)];
    sliderA.backgroundColor = [UIColor clearColor];
    sliderA.value=10;
    sliderA.minimumValue=0;
    sliderA.maximumValue=100;
    
    sliderA.minimumTrackTintColor = RGB(114, 195, 66, 1);
    sliderA.maximumTrackTintColor = RGB(221, 221, 221, 1);
    sliderA.thumbTintColor = RGB(114, 195, 66, 1);
    //    [sliderA setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    //    [sliderA setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    //    //注意这里要加UIControlStateHightlighted的状态，否则当拖动滑块时滑块将变成原生的控件
    //    [sliderA setThumbImage:thumbImage forState:UIControlStateHighlighted];
    //    [sliderA setThumbImage:thumbImage forState:UIControlStateNormal];
    //滑块拖动时的事件
    [sliderA addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    //滑动拖动后的事件
    [sliderA addTarget:self action:@selector(sliderDragUp:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:sliderA];
    
    cy = CGRectGetMaxY(sliderA.frame)+3;
    labMin = [self createLab];
    labMin.font = font12;
    labMin.text = @"0";
    labMin.frame = CGRectMake(cx, cy, 60, labH);
    [self addSubview:labMin];
    
    cx = mainSize.width-spitW-60;
    labMax = [self createLab];
    labMax.font = font12;
    labMax.text = @"1240M";
    labMax.textAlignment = NSTextAlignmentRight;
    labMax.frame = CGRectMake(cx, cy, 60, labH);
    [self addSubview:labMax];
    
    cx = spitW;
    cy = CGRectGetMaxY(labMin.frame);
    labUnitTile = [self createLab];
    labUnitTile.font = font12;
    labUnitTile.text = @"平均单价：0.126元/条";
    labUnitTile.frame = CGRectMake(cx, cy, mainSize.width-spitW*2, labH);
    [self addSubview:labUnitTile];
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = RGB(216, 216, 216, 1).CGColor;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    labTile.text = self.title;
    labUnit.text = [NSString stringWithFormat:@"%@/月", self.unitTile];
    [self changeCost];
    
    sliderA.minimumValue = self.minValue;
    sliderA.maximumValue = self.maxValue;
    labMax.text = [NSString stringWithFormat:@"%d", self.minValue];
    labMax.text = [NSString stringWithFormat:@"%d%@", self.maxValue,self.unitTile];
    labUnitTile.text = [NSString stringWithFormat:@"平均单价：%.3f元/%@", self.unitPrice,self.unitTile];
}

-(void)changeCost
{
    labCost.text = [NSString stringWithFormat:@"%.1f", (_cvalue*self.unitPrice)];
    CGRect tempRect = labCost.frame;
    CGFloat tempW = [Utils widthForString:labCost.text font:labCost.font];
    tempRect.origin.x = rightW - tempW;
    tempRect.size.width = tempW;
    labCost.frame = tempRect;
    
    tempRect = labxf.frame;
    tempRect.origin.x = rightW-tempW-tempRect.size.width;
    labxf.frame = tempRect;
}

-(UILabel*)createLab
{
    UILabel *lab = [[UILabel alloc]init];
    lab.font = [UIFont systemFontOfSize:14];
    lab.backgroundColor = [UIColor clearColor];
    //lab.layer.borderWidth = 1;
    return lab;
}

#pragma mark - 事件操作
-(void)setCvalue:(int)cvalue
{
    _cvalue = cvalue;
    txtValue.text = [NSString stringWithFormat:@"%d", _cvalue];
    sliderA.value = _cvalue;
}

/**
 *  获取消费金额
 *
 *  @return 金额
 */
-(double)getCost
{
    return _cvalue*self.unitPrice;
}

/**
 *  值改变事件
 *
 *  @param sender object
 */
-(void)sliderValueChanged:(id)sender
{
    self.cvalue = sliderA.value;
    [self changeCost];
    if([self.delegate respondsToSelector:@selector(changeValue:index:)])
        [self.delegate changeValue:self.cvalue index:self.index];
}

-(void)sliderDragUp:(id)sender
{
    [txtValue resignFirstResponder];
}

-(BOOL)resignFirstResponder
{
    return [txtValue resignFirstResponder];
}
#pragma mark - UITextFiledDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    int tValue = [textField.text integerValue];
    if(tValue > self.maxValue)
        tValue = self.maxValue;
    else if(tValue < self.minValue)
        tValue = self.minValue;
    self.cvalue = tValue;
    
    if([self.delegate respondsToSelector:@selector(changeValue:index:)])
        [self.delegate changeValue:self.cvalue index:self.index];
    
}
@end