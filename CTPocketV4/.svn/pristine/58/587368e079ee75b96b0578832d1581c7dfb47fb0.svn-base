/*
 *  MATypes.h
 *  MAMapKit
 *
 *  
 *  Copyright 2011 Autonavi Inc. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>


enum {
    MAMapTypeStandard = 0,//标准栅格图
    MAMapTypeSatellite,//影像图
    MAMapTypeVector,//矢量图
    MAMapUserDefine  //用户自定义
};
typedef NSUInteger MAMapType;


UIKIT_EXTERN NSString *MAErrorDomain;

enum MAErrorCode {
    MAErrorUnknown = 1,
    MAErrorServerFailure,
    MAErrorLoadingThrottled,
};


typedef CGFloat MAZoomScale;

//取图url的tile id
typedef struct{
    int z;
    int x;
    int y;
}OrderXYZ; 

//用户自定图层的属性
typedef struct _layerProperty{
    __unsafe_unretained NSString* layerName;     //图层名称
    NSInteger minZoomLevel;  //最小缩放级别
    NSInteger maxZoomLevel;  //最大缩放级别
    NSInteger tileSize;      //切片大小
    __unsafe_unretained NSString* serverUrl;      //图层取图地址
    __unsafe_unretained NSString* cachPath;       //缓存目录
    MAMapType mapType;       //地图类型
    NSInteger refreshTime;   //图层刷新时间
}LayerProperty;