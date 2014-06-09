/*--------------------------------------------
 *Name：CSMineHeadView.h
 *Desc：自定义的头部展示模块
 *Date：2014/06/03
 *Auth：shanhq
 *--------------------------------------------*/

#import <UIKit/UIKit.h>

typedef void(^ButtonSelectBlock)(void);

@interface CSMineHeadView : UIView

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *centerButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, copy) ButtonSelectBlock leftBlock;
@property (nonatomic, copy) ButtonSelectBlock centerBlock;
@property (nonatomic, copy) ButtonSelectBlock rightBlock;

- (id)initWithFrame:(CGRect)frame leftButtonSelectBlock:(ButtonSelectBlock)leftButtonSelectBlock centerButtonSelectBlock:(ButtonSelectBlock)centerButtonSelectBlock  rightButtonSelectBlock:(ButtonSelectBlock)rightButtonSelectBlock;

- (void)setLeftButtonSelectBlock:(ButtonSelectBlock)leftButtonSelectBlock centerButtonSelectBlock:(ButtonSelectBlock)centerButtonSelectBlock  rightButtonSelectBlock:(ButtonSelectBlock)rightButtonSelectBlock;

- (void)autoFit;

- (id)initWithLeftButtonSelectBlock:(ButtonSelectBlock)backButtonSelectBlock ;

@end
