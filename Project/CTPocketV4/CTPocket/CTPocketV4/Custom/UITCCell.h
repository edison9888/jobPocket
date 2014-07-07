/*--------------------------------------------
 *Name：UITCCell
 *Desc：套餐变更套餐数据控件
 *Date：2014/07/04
 *Auth：lip
 *--------------------------------------------*/

#import <UIKit/UIKit.h>

@protocol ValueChangeProtocl <NSObject>

-(void)changeValue:(int)value index:(int)index;

@end

/**
 *  获取套餐数据控件
 */
@interface UITCCell : UIView<UITextFieldDelegate>

@property (strong, nonatomic) UIImage *icon;//图标
@property (strong, nonatomic) NSString *title;//套餐标题
@property (strong, nonatomic) NSString *unitTile;//单位名称
@property (assign, nonatomic) int cvalue;//值
@property (assign, nonatomic) int minValue;//最小值
@property (assign, nonatomic) int maxValue;//最大值
@property (assign, nonatomic) double unitPrice;//价格
@property (assign, nonatomic) int grain;//递增数量
@property (assign, nonatomic, getter = getCost) double cost;//消费金额
@property (assign, nonatomic) int index;//标示控件
@property (weak, nonatomic) id<ValueChangeProtocl> delegate;

-(id)initWithPoint:(CGPoint)point;

-(BOOL)resignFirstResponder;
@end