//
//  BBTopViewManager.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  顶部视图的逻辑管理

#import "BBTopViewManager.h"
#import "AppDelegate.h"
#import "BBTopItemDataModel.h"
#import "BBTRequestParamModel.h"
#import "UIColor+Category.h"
@interface BBTopViewManager()
@property(strong,nonatomic)UIView *dataView;
@property(weak,nonatomic)UIView *statusView;
@property(weak,nonatomic)UIPickerView *pickerView;

@property(strong,nonatomic)NSArray *provinces;
@property(weak,nonatomic)BBTopItemDataModel *currentP;

@property(strong,nonatomic)NSArray *citys;
@property(weak,nonatomic)BBTopItemDataModel *currentC;

@property(strong,nonatomic)NSArray *regions;
@property(weak,nonatomic)BBTopItemDataModel *currentR;

@property(weak,nonatomic)NSArray *datas;
//请求类型，省份还是城市，还是地区
@property(assign,nonatomic)BBTop_Type topTypes;
//请求参数
@property(strong,nonatomic)BBTRequestParamModel *rModel;
//选中的数据
@property(weak,nonatomic)  BBTopItemDataModel *selectItem;
@property(strong,nonatomic) UIColor *tipColor;
@end
@implementation BBTopViewManager
-(instancetype)init
{
    self=[super init];
    if (self) {
        _rModel=[[BBTRequestParamModel alloc] init];
        _rModel.ProvinceCode=nil;
        _rModel.CityCode=nil;
        _tipColor=[UIColor colorWithR:212 G:212 B:212 A:1];
    }
    return self;
}
#pragma mark - IBAction
-(IBAction)provinceClick:(UIButton*)sender
{
    self.topTypes=BBT_P;
    self.datas=self.provinces;
    [self showPicker];
}
-(IBAction)cityClick:(UIButton*)sender
{
    if (self.currentP==nil) {
        [self provinceClick:nil];//请求省份数据
        return;
    }
    self.topTypes=BBT_C;
    if (self.citys&&self.citys.count>0) {
        self.datas=self.citys;
        [self showPicker];
    }
    else
    {
        [self requestData];
    }
}
-(IBAction)regionClick:(UIButton*)sender
{
    if (self.currentC==nil) {
        [self cityClick:nil];
        return;
    }
    
    self.topTypes=BBT_R;
    if (self.regions &&self.regions.count>0){
        self.datas=self.regions;
        [self showPicker];
    }
    else
    {
        [self requestData];
    }
}

#pragma mark - method
-(void)initial;
{
    self.topTypes=BBT_P;
    [self requestData];
    
    [self addArrowImage:self.provinceButton];
    [self addArrowImage:self.cityButton];
    [self addArrowImage:self.regionButton];
}
-(void)addArrowImage:(UIButton*)btn
{
    UIImage *pimage=[UIImage imageNamed:@"prettyNum_arrow_icon"];
    UIImageView *pimageView=[[UIImageView alloc] initWithImage:pimage];
    CGSize psize=pimage.size;
    CGFloat px=  CGRectGetWidth(btn.frame)-psize.width;
    CGFloat py=  (CGRectGetHeight(btn.frame)-psize.height)/2;
    CGRect prect=CGRectMake(px, py, psize.width, psize.height);
    pimageView.frame=prect;
   [btn addSubview:pimageView];
}

#pragma mark 请求数据
-(void)requestData
{
    self.rModel.Type=3;
    self.rModel.topType=self.topTypes;
    //重置显示的数据
    self.datas=nil;
    switch (self.topTypes) {
        case BBT_P:
        {
            
            self.rModel.ProvinceCode=@"1";
            self.rModel.CityCode=nil;
            if (self.provinces&&self.provinces.count>0)
            {
                self.topTypes=BBT_P;
                [self showPicker];
                return;
            }
        }
            break;
        case BBT_C:
        {
            self.rModel.CityCode=nil;
        }
            break;
        case BBT_R:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    [self.process requestTopWithParmaModel:self.rModel];
}
#pragma mark - 显示数据的界面
-(void)showPicker
{
    self.selectItem=nil;//重置选中项
    [self changeColor:[UIColor blackColor]];
    CGRect windowFrame= MyAppDelegate.window.frame;
    self.dataView=[[UIView alloc] initWithFrame:windowFrame];
    self.dataView.backgroundColor=[UIColor clearColor];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(hideDataView)];
    [self.dataView addGestureRecognizer:tap];
    [MyAppDelegate.window addSubview:self.dataView];
    
    //初始化picker
    {
        // picker
        UIPickerView * picker = [[UIPickerView alloc] init];
        picker.showsSelectionIndicator = YES;
        picker.dataSource     = (id<UIPickerViewDataSource>)self;
        picker.delegate       = (id<UIPickerViewDelegate>)self;
        [picker setBackgroundColor:[UIColor whiteColor]];
        picker.showsSelectionIndicator = YES;
        
        CGFloat pickerY=CGRectGetHeight(MyAppDelegate.window.frame)-CGRectGetHeight(picker.frame);
        picker.frame = CGRectMake(0, pickerY, CGRectGetWidth(picker.frame), CGRectGetHeight(picker.frame));
        [self.dataView addSubview:picker];
        self.pickerView=picker;
    }
    
    //初始化取消确认按钮
    {
        CGFloat selY=CGRectGetMinY(self.pickerView.frame)-40;
        UIView *pickerSelView = [[UIView alloc] initWithFrame:CGRectMake(0, selY, CGRectGetWidth(MyAppDelegate.window.frame), 40)];
        pickerSelView.backgroundColor = [UIColor colorWithRed:(9*16+7)/255. green:(9*16+7)/255. blue:(9*16+7)/255. alpha:1];
        [self.dataView addSubview:pickerSelView];
        self.statusView=pickerSelView;
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        cancelBtn.frame = CGRectMake(0, 0, 80, 40);
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [pickerSelView addSubview:cancelBtn] ;
        
        
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setTitle:@"完成" forState:UIControlStateNormal];
        [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        okBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        okBtn.frame = CGRectMake(320-80, 0, 80, 40);
        [okBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
        [pickerSelView addSubview:okBtn] ;
    }
    
    CGRect statusFrame= self.statusView.frame;
    CGRect sDescFrame=statusFrame;
    sDescFrame.origin.y=CGRectGetHeight(self.dataView.frame);
    self.statusView.frame=sDescFrame;
    
    CGRect pickerFrame= self.pickerView.frame;
    CGRect pDescFrame=pickerFrame;
    pDescFrame.origin.y=CGRectGetHeight(self.dataView.frame);
    self.pickerView.frame=pDescFrame;
    
    [UIView transitionWithView:self.dataView duration:.44 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionNone
                    animations:^(){
                        self.statusView.frame=statusFrame;
                        self.pickerView.frame=pickerFrame;
                    }
                    completion: ^(BOOL finished){ 
                    }];
    
}

-(void)changeColor:(UIColor*)color
{
    switch (self.topTypes) {
        case BBT_P:
        {
            [self.provinceButton setTitleColor:color forState:UIControlStateNormal];
        }
            break;
        case BBT_C:
        {
            [self.cityButton setTitleColor:color forState:UIControlStateNormal];
        }
            break;
        case BBT_R:
        {
            [self.regionButton setTitleColor:color forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

-(void)hideDataView
{
    CGRect statusFrame= self.statusView.frame;
    CGRect pickerFrame= self.pickerView.frame;
    
    [UIView transitionWithView:self.dataView duration:.44 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionNone
                    animations:^(){
                        CGRect sDescFrame=statusFrame;
                        sDescFrame.origin.y=CGRectGetHeight(self.dataView.frame);
                        self.statusView.frame=sDescFrame;
                        
                        CGRect pDescFrame=pickerFrame;
                        pDescFrame.origin.y=CGRectGetHeight(self.dataView.frame);
                        self.pickerView.frame=pDescFrame;
                    }
                    completion: ^(BOOL finished){
                        [self.dataView removeFromSuperview];
                        self.dataView=nil;
                        if (self.selectItem) {
                            [self changeColor:[UIColor blackColor]];
                        }else
                        {
                            [self changeColor:self.tipColor];
                        }
                    }];
}
-(void)cancelAction
{
    [self hideDataView];
}
-(void)doneAction
{
    [self hideDataView];
    if (self.selectItem==nil&&self.datas.count>0)
    {
        self.selectItem=[self.datas objectAtIndex:0];
    }
    switch (self.topTypes) {
        case BBT_P:
        {
            //如果选中的不是旧数据
            if (self.currentP.Freight_Area_Code!=self.selectItem.Freight_Area_Code)
            {
                self.rModel.ProvinceCode=self.selectItem.Freight_Area_Code;
                self.currentP=self.selectItem;
                self.rModel.CityCode=nil;
                self.rModel.RegionCode=nil;
                self.citys=nil;//如果更换省份，重置城市列表数据
                self.regions=nil;//如果更换省份，重置地区列表数据
                [self.provinceButton setTitle:self.currentP.Freight_Area_Name forState:UIControlStateNormal];
                [self.cityButton setTitle:@"选择城市" forState:UIControlStateNormal];
                [self.cityButton setTitleColor:self.tipColor forState:UIControlStateNormal];
                [self.regionButton setTitle:@"选择区域" forState:UIControlStateNormal];
                [self.regionButton setTitleColor:self.tipColor forState:UIControlStateNormal];
            }
        }
            break;
        case BBT_C:
        {
            //如果选中的不是旧数据
            if (self.currentC.Freight_Area_Code!=self.selectItem.Freight_Area_Code)
            {
                self.rModel.CityCode=self.selectItem.Freight_Area_Code;
                self.currentC=self.selectItem;
                self.rModel.RegionCode=nil;
                self.regions=nil;//如果更换省份，重置地区列表数据
                [self.cityButton setTitle:self.currentC.Freight_Area_Name forState:UIControlStateNormal];
                [self.regionButton setTitle:@"选择区域" forState:UIControlStateNormal];
                [self.regionButton setTitleColor:self.tipColor forState:UIControlStateNormal];
            }
            
        }
            break;
        case BBT_R:
        {
            //如果选中的不是旧数据
            if (self.currentR.Freight_Area_Code!=self.selectItem.Freight_Area_Code)
            {
                self.rModel.RegionCode=self.selectItem.Freight_Area_Code;
                self.currentR=self.selectItem;
                [self.regionButton setTitle:self.currentR.Freight_Area_Name forState:UIControlStateNormal];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark -网络请求完成后
-(void)updateProvince:(NSMutableArray*)ps
{
    self.provinces=[NSArray arrayWithArray:ps];
    self.datas=self.provinces;
     self.topTypes=BBT_P;
}
-(void)updateCinty:(NSMutableArray*)cs
{
    self.citys=[NSArray arrayWithArray:cs];
    self.datas=self.citys;
    self.topTypes=BBT_C;
    [self showPicker];
}
-(void)updateRegion:(NSMutableArray*)rs
{
    self.regions=[NSArray arrayWithArray:rs];
    self.datas=self.regions;
    self.topTypes=BBT_R;
    [self showPicker];
}
#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.datas.count;
}
#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    BBTopItemDataModel *item=[self.datas objectAtIndex:row];
    return item.Freight_Area_Name;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  self.selectItem=[self.datas objectAtIndex:row];
 
}

@end
