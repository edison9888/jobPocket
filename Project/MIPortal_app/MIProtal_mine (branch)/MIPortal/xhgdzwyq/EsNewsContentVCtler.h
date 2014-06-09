//
//  EsNewsContentVCtler.h
//  xhgdzwyq
//
//  Created by apple on 13-11-26.
//  Copyright (c) 2013年 Eshore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EsNewsItem.h"
#import "EsUIStyle.h"
#import "EsNewsDetailModel.h"

@interface EsNewsContentVCtler : UIViewController

@property (nonatomic, strong) EsNewsItem*   newsInfo;
@property (nonatomic, strong) EsNewsDetailModel*      newsDetail;

@end
