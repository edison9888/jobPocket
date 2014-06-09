/*--------------------------------------------
 *Name：CSTextField
 *Desc：自定义的textfield
 *Date：2014/05/21
 *Auth：lip
 *--------------------------------------------*/

#import <UIKit/UIKit.h>

@interface CSTextField : UITextField

@property (strong, nonatomic) NSString *moneyholder;
@property (strong, nonatomic) NSString *curMoney;
@property (assign, nonatomic) BOOL iscurMoney;
@property (assign, nonatomic) BOOL focus;
@property (assign, nonatomic, getter = getPice) NSInteger price;

-(id)init;

@end
