//
//  EsModifyPwViewController.h
//  xhgdzwyq
//
//  Created by Wen Sijia on 13-12-16.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EsModifyPwViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *pwOld;
@property (weak, nonatomic) IBOutlet UITextField *pwNew;
@property (weak, nonatomic) IBOutlet UITextField *pwNewAgain;
- (IBAction)onModifyPw:(id)sender;

@end
