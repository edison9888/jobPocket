//
//  BBNWRequstProcess.m
//  CTPocketV4
//
//  Created by Gong Xintao on 14-6-6.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//  网络处理

#import "BBNWRequstProcess.h"

#import "AppDelegate.h"

#import "SIAlertView.h"
#import "SVProgressHUD.h"
#import "ToastAlertView.h"

#import "BBTopViewManager.h"
#import "BBTRequestParamModel.h"
#import "BBTopRepDataModel.h"

#import "BBCenterViewManager.h"
#import "BBCRequestParamModel.h"
#import "BBCenterRepDataModel.h"
@implementation BBNWRequstProcess
#pragma mark - 请求区域信息
#pragma mark 把模型转化为格式为dictionary请求参数
-(NSDictionary*)dictionaryWIthTopParamModel:(BBTRequestParamModel*)model
{
    NSString *CityCode=model.CityCode?model.CityCode:@"";
    NSString *ProvinceCode=model.ProvinceCode?model.ProvinceCode:@"";
    NSString *Type=[NSString stringWithFormat:@"%i",model.Type];
    return @{@"CityCode":CityCode,@"ProvinceCode":ProvinceCode,@"Type":Type};
}

#pragma mark 请求省份或城市或地区
-(void)requestTopWithParmaModel:(BBTRequestParamModel*)model
{
    
    if (model.cachePath)
    {
        BBTopRepDataModel *top=[[BBTopRepDataModel alloc] init];
        [top readFromFile:model.cachePath];
        if (top.Data.count>0)
        {
            switch (model.topType) { 
                case BBT_C:
                {
                    [self.tManager updateCinty:top.Data];
                }
                    break;
                case BBT_R:
                {
                      [self.tManager updateRegion:top.Data];
                }
                    break;
                    
                default:
                    break;
            }
            return;
        }
    }
 
      [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    __weak typeof(self) weakSelf=self;
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryOrganization"
                                           params:[self dictionaryWIthTopParamModel:model]
                                      onSucceeded:^(NSDictionary *dict) {
                                          DDLogInfo(@"%s--%@", __func__, dict.description);
                                          id Data = [dict objectForKey:@"Data"];
                                          
                                          id Items = [Data objectForKey:@"Items"];
                                          NSArray * arr = nil;
                                          if ([Items isKindOfClass:[NSArray class]])
                                          {
                                              arr = Items;
                                          }
                                          else if ([Items isKindOfClass:[NSDictionary class]])
                                          {
                                              arr = [NSArray arrayWithObject:Items];
                                          }
                                          else
                                          {
                                              arr = [NSArray array];
                                          }
                                           BBTopRepDataModel *top=[[BBTopRepDataModel alloc] init];
                                          [top transformWithArray:arr];
                                          switch (model.topType) {
                                              case BBT_P:
                                              {
                                                  [weakSelf.tManager updateProvince:top.Data];
                                              }
                                                  break;
                                              case BBT_C:
                                              {
                                                  [weakSelf.tManager updateCinty:top.Data];
                                              }
                                                  break;
                                              case BBT_R:
                                              {
                                                  [weakSelf.tManager updateRegion:top.Data];
                                              }
                                                  break;
                                                  
                                              default:
                                                  break;
                                          }
                                          [SVProgressHUD dismiss];
                                      } onError:^(NSError *engineError) {
                                          [SVProgressHUD dismiss];
                                          if ([engineError.userInfo objectForKey:@"ResultCode"])
                                          {
                                              if ([engineError.userInfo[@"ResultCode"] isEqualToString:@"X104"])
                                              {
                                                  // 取消掉全部请求和回调，避免出现多个弹框
                                                  [MyAppDelegate.cserviceEngine cancelAllOperations];
                                                  /**
                                                  // 提示重新登录
                                                  SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                                                                   andMessage:@"长时间未登录，请重新登录。"];
                                                  [alertView addButtonWithTitle:@"确定"
                                                                           type:SIAlertViewButtonTypeDefault
                                                                        handler:^(SIAlertView *alertView) {
                                                                            [MyAppDelegate showReloginVC];
                                                                            
                                                                            if (self.navigationController != nil)
                                                                            {
                                                                                [self.navigationController popViewControllerAnimated:NO];
                                                                            }
                                                                        }];
                                                  alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                                  [alertView show];
                                                   */
                                              }
                                          }
                                          else{
                                              ToastAlertView *alert = [ToastAlertView new];
                                              [alert showAlertMsg:@"系统繁忙,请重新提交"];
                                          }
                                      }];

}

 
#pragma mark - 请求查询的信息
#pragma mark 把模型转化为格式为dictionary请求参数
-(NSDictionary*)dictionaryWIthCenterParamModel:(BBCRequestParamModel*)model
{
    NSString *areaId=model.AreaId?model.AreaId:@"";
    NSString *ComName=model.ComName?model.ComName:@"";
    NSString *PageIndex=[NSString stringWithFormat:@"%i",model.PageIndex];
    NSString *PageSize=[NSString stringWithFormat:@"%i",model.PageSize];
    return @{@"AreaId":areaId,@"ComName":ComName,@"PageIndex":PageIndex,@"PageSize":PageSize};
}

-(void)requestSearch:(BBCRequestParamModel*)model
{
    
    [SVProgressHUD showWithStatus:@"请稍候..." maskType:SVProgressHUDMaskTypeGradient];
    __weak typeof(self) weakSelf=self;
    [MyAppDelegate.cserviceEngine postXMLWithCode:@"qryBroadbandInfo"
                                           params:[self dictionaryWIthCenterParamModel:model]
                                      onSucceeded:^(NSDictionary *dict) {
                                          DDLogInfo(@"%s--%@", __func__, dict.description);
                                          id Data = [dict objectForKey:@"Data"];
                                          
                                          id Items = [Data objectForKey:@"DataList"];
                                          NSArray * arr = nil;
                                          if ([Items isKindOfClass:[NSArray class]])
                                          {
                                              arr = Items;
                                          }
                                          else if ([Items isKindOfClass:[NSDictionary class]])
                                          {
                                              arr = [NSArray arrayWithObject:Items];
                                          }
                                          else
                                          {
                                              arr = [NSArray array];
                                          }
                                          BBCenterRepDataModel *repData=[[BBCenterRepDataModel alloc] init];
                                          repData.TotalCount=[Data[@"TotalCount"] integerValue];
                                          [repData transformWithArray:arr];
                                          [weakSelf.cManager updateWithData:repData];
                                          [SVProgressHUD dismiss];
                                      } onError:^(NSError *engineError) {
                                          [SVProgressHUD dismiss];
                                          if ([engineError.userInfo objectForKey:@"ResultCode"])
                                          {
                                              if ([engineError.userInfo[@"ResultCode"] isEqualToString:@"X104"])
                                              {
                                                  // 取消掉全部请求和回调，避免出现多个弹框
                                                  [MyAppDelegate.cserviceEngine cancelAllOperations];
                                                  /**
                                                   // 提示重新登录
                                                   SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil
                                                   andMessage:@"长时间未登录，请重新登录。"];
                                                   [alertView addButtonWithTitle:@"确定"
                                                   type:SIAlertViewButtonTypeDefault
                                                   handler:^(SIAlertView *alertView) {
                                                   [MyAppDelegate showReloginVC];
                                                   
                                                   if (self.navigationController != nil)
                                                   {
                                                   [self.navigationController popViewControllerAnimated:NO];
                                                   }
                                                   }];
                                                   alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
                                                   [alertView show];
                                                   */
                                              }
                                          }
                                          else{
                                              ToastAlertView *alert = [ToastAlertView new];
                                              [alert showAlertMsg:@"系统繁忙,请重新提交"];
                                          }
                                      }];
}
@end
