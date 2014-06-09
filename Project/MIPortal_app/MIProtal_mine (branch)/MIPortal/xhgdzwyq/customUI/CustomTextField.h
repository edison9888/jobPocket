/*--------------------------------------------
 *Name：EsAddNewsViewCtler.h
 *Desc：自定义的textfield,改变了placeholder等一些属性
 *Date：2014/05/21
 *Auth：hehx
 *--------------------------------------------*/
#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField

@property(nonatomic, assign)CGFloat placeholderFontSize;
@property(nonatomic, assign)UIColor *placeholderFontColor;
@property(nonatomic, assign)CGRect placeholderRect;
@end
