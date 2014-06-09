//
//  PublicFile.h
//  TelecomCloudManager2
//
//  Created by Y W on 13-4-13.
//  Copyright (c) 2013年 Y W. All rights reserved.
//

#ifndef TelecomCloudManager2_PublicFile_h
#define TelecomCloudManager2_PublicFile_h

//*****
#pragma mark - iphone5  & iphone4

#define __iPhone5__ ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define __iP5_AutoSizeDistance__ (__iPhone5__? 88 : 0)
#define __ipHeight__ (__iPhone5__? 568:480)


//******
#pragma mark - color define

#define kRGBUIColor(R,G,B,a) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(a)]

#define kUIColorLightBlack kRGBUIColor(65, 65, 65, 1)
#define kUIColorDarkBlack kRGBUIColor(36, 36, 36, 1)
#define kUIColorDarkYellow kRGBUIColor(186, 95, 36, 1)

#define kUIColorDarkGray kRGBUIColor(64,64,64,1)
#define kUIColorLightGray kRGBUIColor(157,154,147,1)

#define kUIColorWhiteColor kRGBUIColor(255,255,255,1)


//******
#pragma mark - font define

#define kFontSizeOne    [UIFont systemFontOfSize:22]
#define kFontSizeTwo    [UIFont systemFontOfSize:18]
#define kFontSizeThree  [UIFont systemFontOfSize:16]
#define kFontSizeFour   [UIFont systemFontOfSize:14]
#define kFontSizeFive   [UIFont systemFontOfSize:12]

#define kBoldFontSizeOne    [UIFont boldSystemFontOfSize:22]
#define kBoldFontSizeTwo    [UIFont boldSystemFontOfSize:18]
#define kBoldFontSizeThree  [UIFont boldSystemFontOfSize:16]
#define kBoldFontSizeFour   [UIFont boldSystemFontOfSize:14]
#define kBoldFontSizeFive   [UIFont boldSystemFontOfSize:12]



#define  kNumbers @"0123456789"

#endif
