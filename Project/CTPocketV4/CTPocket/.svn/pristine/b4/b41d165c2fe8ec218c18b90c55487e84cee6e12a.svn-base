//
//  CRecipientEditView.h
//  CTPocketV4
//
//  Created by Mac-Eshore-01 on 14-1-17.
//  Copyright (c) 2014年 广东亿迅科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CRecipientEditViewDelegate <NSObject>
-(void)onPikerAction:(id)sender;
-(void)onHiddenPopView:(id)sender;  // 隐藏、输入框、piker等
@end


@interface CRecipientEditView : UIView
{
}
@property(nonatomic,assign)    id<CRecipientEditViewDelegate> delegate;
@property(nonatomic,strong)    UITextField *reciper;
@property(nonatomic,strong)    UITextField *province;
@property(nonatomic,strong)    UITextField *address;
@property(nonatomic,strong)    UITextField *postcode;
@property(nonatomic,strong)    UITextField *phone;

-(void)hiddenKeyBord;
-(void)setProvince:(NSString*)prov
              city:(NSString*)city
              dist:(NSString*)dist;

-(void)setAdressDict:(NSDictionary*)dict;
-(NSError*)checkInputValues;

@end
