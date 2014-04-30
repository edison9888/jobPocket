//
//  CTBdSalesPictureTextDetailCell.m
//  CTPocketV4
//
//  Created by Y W on 14-3-21.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import "CTBdSalesPictureTextDetailCell.h"

#import "ThreeSubView.h"

#import "UIColor+Category.h"

#define TitleHeight 40
#define XDistance 10
#define YDistance 5

@interface FileterWebView : UIWebView
@property(nonatomic,assign)UITableView *tableView;
@property(nonatomic,assign)BOOL isFilter;
@end
@implementation FileterWebView

// 重写hitTest:withEvent:将整个UIView的移动量重定位给UIScrollView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.isFilter)
    {
        return [super hitTest:point withEvent:event];
    }else
    {
        return self.tableView;
    }
   
}

@end
static NSUInteger YOffset = TitleHeight + YDistance;
static NSUInteger webviewHieght = 0;

@interface CTBdSalesPictureTextDetailCell () <UIWebViewDelegate,UIScrollViewDelegate>
{
    CGFloat height_cell;
    CGFloat width_cell;
    NSMutableArray *_heightObject;
    UITableView *_tableView;
    UIActivityIndicatorView *indicatorView;
}
@property (nonatomic, strong) FileterWebView *webView;

@property (nonatomic, assign) BOOL alreadyLoad;

@property (nonatomic, strong) NSArray *urlArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property(nonatomic,weak)UIView *actionView;
@end


@implementation CTBdSalesPictureTextDetailCell

+ (CGFloat)cellHeight
{
    return YOffset;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tableView:(UITableView*)tableView withHeight:(NSMutableArray*)heightObject
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        {
            height_cell=CGRectGetHeight(tableView.frame);
            width_cell=CGRectGetWidth(tableView.frame);
            _heightObject=heightObject;
            
            ThreeSubView *threeSubView = [[ThreeSubView alloc] initWithFrame:CGRectMake(XDistance, 0, 0, TitleHeight) leftButtonSelectBlock:nil centerButtonSelectBlock:nil rightButtonSelectBlock:nil];
            [threeSubView.leftButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            
            [threeSubView.centerButton setTitleColor:[UIColor colorWithR:49 G:49 B:49 A:1] forState:UIControlStateNormal];
            [threeSubView.centerButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [threeSubView.centerButton setTitle:@"商品图文详情" forState:UIControlStateNormal];
            
            [threeSubView.rightButton setTitleColor:[UIColor colorWithR:160 G:160 B:160 A:1] forState:UIControlStateNormal];
            [threeSubView.rightButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
            [threeSubView.rightButton setTitle:@"(点击查看完整版详情可能产生较多流量)" forState:UIControlStateNormal];
            
            [threeSubView autoLayout];
            [self.contentView addSubview:threeSubView];

            _tableView=tableView;
            
            self.alreadyLoad = NO;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadHtml)];
            [self.contentView addGestureRecognizer:tap];
        }
    }
    return self;
}
- (void)dealloc
{
    self.webView=nil;
    YOffset = TitleHeight + YDistance;
}
#pragma mark - func

-(void)setActionView2WebView
{
//    self.actionView=self.webView;
    self.actionView=nil;
    self.webView.scrollView.scrollEnabled=YES;
    _tableView.scrollEnabled=NO;
    self.webView.isFilter=YES;
    
}
- (void)loadHtml
{
    /*
    if (self.webView.loading)
    {
        return;
    }
    **/
    
    if (self.alreadyLoad)
    {
        if (self.webView )
        {
            _tableView.scrollEnabled=YES;
            self.alreadyLoad=NO;
            YOffset = TitleHeight + YDistance;
            [_heightObject removeAllObjects];
            [_heightObject addObject:@48];
            [self.webView removeFromSuperview];
            self.webView=nil;
            [ _tableView reloadData];
            [ _tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:9] atScrollPosition:UITableViewScrollPositionTop animated:YES]; 
            if (self.didFinishLoadBlock)
            {
                self.didFinishLoadBlock();
            }
            
        }
        return;
    }

    
   
    if (self.webView == nil) {
        
        self.webView = [[FileterWebView alloc] initWithFrame:CGRectMake(0, TitleHeight + YDistance,width_cell , height_cell-48)];
        self.webView.scrollView.scrollEnabled = YES;
        self.webView.opaque = YES;
        self.webView.backgroundColor = [UIColor clearColor];
        self.webView.scrollView.delegate=self;
        self.webView.delegate = self;
        //        self.webView.scalesPageToFit=YES;
        [self.contentView addSubview:self.webView];
        
        
//        [self performSelectorOnMainThread:@selector(addIndicator) withObject:Nil waitUntilDone:YES];
    }
    self.alreadyLoad=YES;
    [_heightObject removeAllObjects];
    [_heightObject addObject:[NSNumber numberWithFloat:height_cell]];
    [ _tableView reloadData];
    [ _tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:9] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    NSString *html = [NSString stringWithFormat:@"<html><body>%@</body></html>", self.Detail];
    [self.webView loadHTMLString:html baseURL:nil];
    //    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com/"];
    //    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}
-(void)addIndicator
{
     if (self.webView == nil)
     {
         [indicatorView removeFromSuperview];
         indicatorView=nil;
         return;
     }
    if (indicatorView.isAnimating)
    {
        return;
    }
    if (self.alreadyLoad)
    {
        return;
    }
    /***/
    indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGPoint centerPoint=self.webView.center;
    indicatorView.center=centerPoint;
    [indicatorView startAnimating];
    [self.contentView addSubview:indicatorView];
}
 -(void)removeWebView
{
    [_heightObject removeAllObjects];
    [_heightObject addObject:@48];
    [self.webView removeFromSuperview];
    self.webView=nil;
    [indicatorView removeFromSuperview];
    indicatorView=nil;
}
- (void)setDetail:(NSString *)Detail
{
    if (_Detail == Detail) {
        return;
    }
    _Detail = Detail;
    
    YOffset = TitleHeight + YDistance;
    
    self.alreadyLoad = NO;
    
    return;
    /**
     if (self.imageArray) {
     [self.imageArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
     }
     self.imageArray = [NSMutableArray array];
     
     self.urlArray = [Detail componentsSeparatedByString:@";"];
     for (NSString *urlString in self.urlArray) {
     [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:urlString] options:SDWebImageLowPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
     if (finished && image) {
     [self addImage:image];
     }
     }];
     }
     */
}
/**
 - (void)addImage:(UIImage *)image
 {
 UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
 imageView.backgroundColor = [UIColor clearColor];
 CGRect rect = imageView.frame;
 rect.origin = CGPointMake(0, YOffset);
 rect.size.width = CGRectGetWidth(self.contentView.frame);
 imageView.frame = rect;
 [self.contentView addSubview:imageView];
 [self.imageArray addObject:imageView];
 
 YOffset = CGRectGetMaxY(imageView.frame) + YDistance;
 
 if (self.didFinishLoadBlock)
 {
 self.didFinishLoadBlock();
 }
 }
 */
#pragma mark implement
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesMoved:touches withEvent:event];
//    UITouch *touch=[touches anyObject];
//}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    self.alreadyLoad = YES;
    
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
//    CGRect frame = webView.frame;
//    webView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height);
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    self.webView.scrollView.contentSize=CGSizeMake(width_cell, height);
    webviewHieght=height;
    YOffset += webviewHieght;
    [indicatorView removeFromSuperview];
    indicatorView=nil;
    if (self.didFinishLoadBlock)
    {
        self.didFinishLoadBlock();
    }
}

-(void)removeFilter
{
    if (self.webView)
    {
        self.webView.isFilter=NO;
    }
     _tableView.scrollEnabled=YES;
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY=scrollView.contentOffset.y;
    if (offsetY<8)
    {
          _tableView.scrollEnabled=YES;
    }
    if (offsetY<=0)
    {
        scrollView.contentOffset=CGPointZero;
        self.actionView=_tableView;
//        self.webView.scrollView.scrollEnabled=NO;
        self.webView.isFilter=NO;
      
        CGPoint offsetPoint=_tableView.contentOffset;
        offsetPoint.y+=offsetY;
        _tableView.contentOffset=offsetPoint;
//        CGRect visibleRect=CGRectMake(offsetPoint.x, offsetPoint.y, CGRectGetWidth(_tableView.frame), 1);
//        [_tableView scrollRectToVisible:visibleRect animated:YES];
//       CGRect rect=[_tableView rectForSection:9];
//        NSLog(@"rect---%@",NSStringFromCGRect(rect));
//      CGPoint point= _tableView.contentOffset;
//        NSLog(@"point---%@",NSStringFromCGPoint(point));
//        [_tableView scroll];
    }
//    [_tableView ];
}

@end
