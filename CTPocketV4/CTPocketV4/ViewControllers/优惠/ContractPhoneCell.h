//
//  ContractPhoneCell.h
//  CTPocketv3
//
//  Created by apple on 13-5-7.
//
//

#import <UIKit/UIKit.h>

@interface ContractPhoneCell : UITableViewCell
{

}

-(void)setInfo:(NSMutableDictionary *)phoneInfo;

@property (nonatomic , assign) NSMutableDictionary *_contractDictionary;
@property (nonatomic ,retain)  NSString *userIdentify;

@end
