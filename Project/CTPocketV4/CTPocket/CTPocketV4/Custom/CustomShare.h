//
//  CustomShare.h
//  AGShareSDKDemo
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 vimfung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

@interface CustomShare : NSObject

+(UIImage*)fullScreenshots;
+(BOOL)deleteFromName:(NSString *)name;
+(BOOL) setPhotoToPath:(UIImage *)image isName:(NSString *)name;
+ (UIImage *)getNormalImage:(UIView *)view;
+ (void)shareHandler:(UIImage*)image;

@end

