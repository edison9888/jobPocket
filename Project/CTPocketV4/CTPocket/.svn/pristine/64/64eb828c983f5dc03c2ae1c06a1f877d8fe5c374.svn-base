//
//  SearchView.m
//  CTPocketv3
//
//  Created by apple on 13-5-9.
//
//

#import "SearchView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+RoundRect.h"


@interface SearchView()<UISearchBarDelegate>
{
  
}

@end
@implementation SearchView

@synthesize _searchBar;
@synthesize delegate;
@synthesize _searchInfo;
- (id)initWithFrame:(CGRect)frame coverView:(UIView *)view
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _coverView = view;
        
        self.backgroundColor = [UIColor colorWithRed:230/255. green:230/255. blue:230/255. alpha:1];
        //设置textfiled
        int OriginalX = 0;
        {
            UISearchBar *bar = [[UISearchBar alloc]initWithFrame:CGRectMake(24, 6, 221, self.frame.size.height - 12)];
            bar.backgroundColor = [UIColor clearColor];
            [bar dwMakeRoundCornerWithRadius:5];
            bar.delegate = self;
            [[bar.subviews objectAtIndex:0]removeFromSuperview]; //取出背景框
            for (UIView *subview in bar.subviews) {
                
                if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                    
                    [subview removeFromSuperview];
                    
                    break;  
                    
                }  
                
            }
            UIView *bgImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0,bar.frame.size.width,bar.frame.size.height)];
            bgImage.layer.cornerRadius = 4;
            bgImage.backgroundColor = [UIColor whiteColor];
            [bar setSearchFieldBackgroundImage:[self getImageFromView:bgImage] forState:UIControlStateNormal];
            //[segment addSubview:bgImage];
            
            bar.keyboardType = UIKeyboardAppearanceDefault;
            bar.showsCancelButton = NO;
            bar.placeholder = @"  请输入搜索内容";
            _searchBar = bar;
            [self addSubview:_searchBar];

            OriginalX = CGRectGetMaxX(_searchBar.frame) + 15;
            
            UIImage  *img       = [UIImage imageNamed:@"query_btn.png"];
            UIImage * himg      = [UIImage imageNamed:@"query_btn_highlight.png"];
            UIButton * btn      = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame           = CGRectMake(OriginalX,(self.frame.size.height - img.size.height)/2,50,img.size.height);
            [btn setBackgroundImage:[img resizableImageWithCapInsets:UIEdgeInsetsMake(img.size.height/2, img.size.width/2, img.size.height/2, img.size.width/2)] forState:UIControlStateNormal];
            [btn setBackgroundImage:[himg resizableImageWithCapInsets:UIEdgeInsetsMake(himg.size.height/2, himg.size.width/2, himg.size.height/2, himg.size.width/2)] forState:UIControlStateHighlighted];
            [btn setTitle:@"搜索" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:12 ]];
            [btn addTarget:self action:@selector(favorites:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
        }
        //添加触屏事件
        _coverView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchView)];
        [_coverView addGestureRecognizer:tap];//添加view的点击事件
    }
    return self;
}
-(void)touchView
{
    _coverView.hidden = YES;
    [_searchBar resignFirstResponder];
}
-(void)favorites:(UIButton *)sender
{
    if (delegate && [delegate respondsToSelector:@selector(searchPhoneInfo:)]) {
        [delegate searchPhoneInfo:self];
        _coverView.hidden = YES;
        [_searchBar resignFirstResponder];
    }
}
//网络请求
-(void)favoritesNetRequest
{

}
#pragma mark - UITextFiled delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;{
 //   NSString *info;
    if (searchText == nil) {
//        *info = [[NSString alloc]initWithFormat:@",nil];
    }else{
//        *info = [[NSString alloc]initWithFormat:searchText,nil];
    }
    self._searchInfo =  searchText;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self._searchBar resignFirstResponder];// 放弃第一响应者
    [self favorites:nil];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _coverView.hidden = NO;
    return YES;
}
//编辑结束
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return NO;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_searchBar resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}
-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
