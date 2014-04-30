//
//  SelectPackagesVCtler.h
//  CTPocketv3
//
//  Created by Y W on 13-5-29.
//
//

#import "CTBaseViewController.h"

typedef void(^DetailAction)(NSDictionary *info);
typedef void(^SelectAction)(NSDictionary *info);

@interface SelectPackagesCell : UITableViewCell <UIGestureRecognizerDelegate>
{
    UIButton *_packageButton; //套餐多少钱的
    UILabel *_voiceLabel; //语音
    UILabel *_flowLabel; //流量
    UILabel *_msgLabel; //短信
    UIButton *_detailButton; //详情
}

@property (nonatomic, retain)NSDictionary *info;
@property (nonatomic, readwrite, copy)DetailAction detailAction;
@property (nonatomic, readwrite, copy)SelectAction selectAction;

+ (float)cellHeight;

- (void)setInfo:(NSDictionary *)info;

- (void)setCustomSelect;

@end



//************************************************华丽丽的分割线******************************************************



typedef void(^ButtonSelect)(NSDictionary *info);

@interface ItemButton : UIControl
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
}
@property (nonatomic, retain)NSDictionary *info;

- (void)setItem:(NSDictionary *)item;

@end



//************************************************华丽丽的分割线******************************************************



@interface SelectPackagesVCtler : CTBaseViewController

@property (nonatomic, strong) NSString *SalesproductId; //合约机销售品ID
@property (nonatomic, strong) NSString *ContractId; //合约ID


//.
@property (nonatomic, strong) NSDictionary *SalesproductInfoDict; //销售品信息
@property (nonatomic, strong) NSDictionary *ContractInfo; //合约信息

@end
