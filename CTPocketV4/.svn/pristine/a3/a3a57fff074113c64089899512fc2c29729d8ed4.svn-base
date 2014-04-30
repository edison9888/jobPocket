//
//  MAMapView_Enterprise_Addition.h
//  MAMapKit
//
//  Created by 印泽 张 on 12-3-14.
//  Copyright (c) 2012年  autonavi. All rights reserved.
//


@protocol MAMapView_Enterprise_Delegate;

//定义企业级用户回调句柄
@interface MAMapView()
@property (nonatomic, assign) id<MAMapView_Enterprise_Delegate> enterpriseDelegate;
@end

//用户自定义图层操作接口
@interface MAMapView(CustomLayerAPI_Addition)
//创建一个用户自定图层
-(void)createCustomLayer:(LayerProperty)layerProperty;
//把用户自定的图层添加到地图图层之上
-(void)addCustomLayer:(NSString*)layerName;
//把一个图层layer插入到belowlayer之下
-(void)insertCustomLayer:(NSString*)layerName belowing:(NSString*)belowLayerName;
//把一个图层layer插入到aboelayer之上
-(void)insertCustomLayer:(NSString *)layerName aboveing:(NSString *)aboveLayerName;
//交换两个图层的位置
-(void)exchangeCustomLayer:(NSString*)layerName withLayer:(NSString *)changeLayerName;
//移除指定用户自定义图层
-(void)removeCustomLayer:(NSString*)layerName;
//移除全部用户自定义图层
-(void)removeALLCustomLayers;
@end


@interface MAMapView (Enterprise_Addition)
-(CLLocationCoordinate2D)screenXY2LocationCoordinate:(CGPoint)screenXY;
-(CGPoint)LonLat2screenXY:(CLLocationCoordinate2D)lonlat;
-(CGPoint) PixelXY2LngLatXY:(CGPoint)inpixelXY;
@end


@protocol MAMapView_Enterprise_Delegate <MAMapViewDelegate>
@optional

/* errorCode = 256  地址配置错误*/
-(void)mapView:(MAMapView *)mapView tileMapCustomURLError:(NSInteger)errorCode;

/*errorCode = 256 地址配置错误*/
-(void)mapView:(MAMapView *)mapView satelliteCustomURLError:(NSInteger)errorCode;

/* errorCode = 0 地址正确，但是没有实时交通数据
 errorCode = -1003 地址配置错误 */
-(void)mapView:(MAMapView *)mapView tmcMapCustomURLError:(NSInteger)errorCode;

/*传入正常顺序的xyz，返回用户自定义的xyz*/
-(OrderXYZ)customeLayer:(NSString*)layname TileX:(int)x TileY:(int)y TileZ:(int)z;

-(void)mapView:(MAMapView *)mapView forAnnotation:(MAAnnotationView*)annotation screenXY:(CGPoint)point;
//-(OrderXYZ)mapView:(NSString *)LayerName getRightWithX:(int)x getRightWithY:(int)y getRightWithZ:(int)z;
@end

