//
//  SearchView.h
//  CTPocketv3
//
//  Created by apple on 13-5-9.
//
//

#import <UIKit/UIKit.h>
@class SearchView;
@protocol searchPhoneInfodelgate <NSObject>

@optional
-(void)searchPhoneInfo:(SearchView *)searchView;
@end


@interface SearchView : UIView
{
     UIView *_coverView;
}
- (id)initWithFrame:(CGRect)frame coverView:(UIView *)view;
@property (nonatomic,assign)UISearchBar *_searchBar;
@property(nonatomic) UIControlContentVerticalAlignment contentVerticalAlignment;     // how to position content vertically inside control. default is center
@property(nonatomic) UIControlContentHorizontalAlignment contentHorizontalAlignment;
@property(nonatomic,assign) id<searchPhoneInfodelgate>delegate;
@property (nonatomic,retain) NSString *_searchInfo;
@end
