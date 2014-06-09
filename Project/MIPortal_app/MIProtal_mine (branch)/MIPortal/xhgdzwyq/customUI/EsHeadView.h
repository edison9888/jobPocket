/*--------------------------------------------
 *Name：CsHeadViewCtler.h
 *Desc：自定义的头部展示模块
 *Date：2014/06/03
 *Auth：hehx
 *--------------------------------------------*/

#import <UIKit/UIKit.h>

typedef void(^ButtonSelectBlock)(void);

@interface EsHeadView : UIViewController

@property (nonatomic, copy) ButtonSelectBlock block;

- (id)initBlock:(ButtonSelectBlock)block;
- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame Block:(ButtonSelectBlock)block;


@end
