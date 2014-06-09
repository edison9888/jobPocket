/*--------------------------------------------
 *Name：EsMineContentViewCtrler.h
 *Desc：我的界面列表详情模块
 *Date：2014/06/09
 *Auth：shanhq
 *--------------------------------------------*/

#import "BaseViewCtler.h"
#import "EsCorporationDelegate.h"
#import "EsNewsListNetAgent.h"
#import "EsNewsDetailModel.h"
#import "EsMineListNetAgent.h"

@interface EsMineContentViewCtrler : BaseViewCtler

@property (weak, nonatomic) id <EsCorporationDelegate> cprtDelegate;
@property (nonatomic, strong) EsMineListNetAgent* netAgent;
@property (nonatomic, assign) NSInteger selectIdx;
@property (nonatomic, assign) BOOL isRemotePushNews;     // 推送消息传送页面
@property (nonatomic, strong) NSDictionary* newsInfo;    // page=xqy_jm&id=1068&catalogAry=1_2_64
@property (nonatomic, strong) EsNewsDetailModel *newsDetail;

@end
