// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ES_ProtocolBuffers.h"

@class GetTpnoolResponse;
@class GetTpnoolResponse_Builder;
@class TpnoolData;
@class TpnoolData_Builder;
#ifndef __has_feature
  #define __has_feature(x) 0 // Compatibility with non-clang compilers.
#endif // __has_feature

#ifndef NS_RETURNS_NOT_RETAINED
  #if __has_feature(attribute_ns_returns_not_retained)
    #define NS_RETURNS_NOT_RETAINED __attribute__((ns_returns_not_retained))
  #else
    #define NS_RETURNS_NOT_RETAINED
  #endif
#endif


@interface TpnoolProtoRoot : NSObject {
}
+ (ES_PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(ES_PBMutableExtensionRegistry*) registry;
@end

@interface TpnoolData : ES_PBGeneratedMessage {
@private
  BOOL hasNumberSegment_:1;
  BOOL hasProvinceName_:1;
  BOOL hasCityName_:1;
  NSString* numberSegment;
  NSString* provinceName;
  NSString* cityName;
}
- (BOOL) hasNumberSegment;
- (BOOL) hasProvinceName;
- (BOOL) hasCityName;
@property (readonly, retain) NSString* numberSegment;
@property (readonly, retain) NSString* provinceName;
@property (readonly, retain) NSString* cityName;

+ (TpnoolData*) defaultInstance;
- (TpnoolData*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(ES_PBCodedOutputStream*) output;
- (TpnoolData_Builder*) builder;
+ (TpnoolData_Builder*) builder;
+ (TpnoolData_Builder*) builderWithPrototype:(TpnoolData*) prototype;
- (TpnoolData_Builder*) toBuilder;

+ (TpnoolData*) parseFromData:(NSData*) data;
+ (TpnoolData*) parseFromData:(NSData*) data extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
+ (TpnoolData*) parseFromInputStream:(NSInputStream*) input;
+ (TpnoolData*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
+ (TpnoolData*) parseFromCodedInputStream:(ES_PBCodedInputStream*) input;
+ (TpnoolData*) parseFromCodedInputStream:(ES_PBCodedInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
@end

@interface TpnoolData_Builder : ES_PBGeneratedMessage_Builder {
@private
  TpnoolData* result;
}

- (TpnoolData*) defaultInstance;

- (TpnoolData_Builder*) clear;
- (TpnoolData_Builder*) clone;

- (TpnoolData*) build;
- (TpnoolData*) buildPartial;

- (TpnoolData_Builder*) mergeFrom:(TpnoolData*) other;
- (TpnoolData_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input;
- (TpnoolData_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasNumberSegment;
- (NSString*) numberSegment;
- (TpnoolData_Builder*) setNumberSegment:(NSString*) value;
- (TpnoolData_Builder*) clearNumberSegment;

- (BOOL) hasProvinceName;
- (NSString*) provinceName;
- (TpnoolData_Builder*) setProvinceName:(NSString*) value;
- (TpnoolData_Builder*) clearProvinceName;

- (BOOL) hasCityName;
- (NSString*) cityName;
- (TpnoolData_Builder*) setCityName:(NSString*) value;
- (TpnoolData_Builder*) clearCityName;
@end

@interface GetTpnoolResponse : ES_PBGeneratedMessage {
@private
  BOOL hasTpnoolVer_:1;
  int32_t tpnoolVer;
  ES_PBAppendableArray * mobileTpnoolDataArray;
  ES_PBAppendableArray * telTpnoolDataArray;
}
- (BOOL) hasTpnoolVer;
@property (readonly) int32_t tpnoolVer;
@property (readonly, retain) ES_PBArray * mobileTpnoolData;
@property (readonly, retain) ES_PBArray * telTpnoolData;
- (TpnoolData*)mobileTpnoolDataAtIndex:(NSUInteger)index;
- (TpnoolData*)telTpnoolDataAtIndex:(NSUInteger)index;

+ (GetTpnoolResponse*) defaultInstance;
- (GetTpnoolResponse*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(ES_PBCodedOutputStream*) output;
- (GetTpnoolResponse_Builder*) builder;
+ (GetTpnoolResponse_Builder*) builder;
+ (GetTpnoolResponse_Builder*) builderWithPrototype:(GetTpnoolResponse*) prototype;
- (GetTpnoolResponse_Builder*) toBuilder;

+ (GetTpnoolResponse*) parseFromData:(NSData*) data;
+ (GetTpnoolResponse*) parseFromData:(NSData*) data extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
+ (GetTpnoolResponse*) parseFromInputStream:(NSInputStream*) input;
+ (GetTpnoolResponse*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
+ (GetTpnoolResponse*) parseFromCodedInputStream:(ES_PBCodedInputStream*) input;
+ (GetTpnoolResponse*) parseFromCodedInputStream:(ES_PBCodedInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
@end

@interface GetTpnoolResponse_Builder : ES_PBGeneratedMessage_Builder {
@private
  GetTpnoolResponse* result;
}

- (GetTpnoolResponse*) defaultInstance;

- (GetTpnoolResponse_Builder*) clear;
- (GetTpnoolResponse_Builder*) clone;

- (GetTpnoolResponse*) build;
- (GetTpnoolResponse*) buildPartial;

- (GetTpnoolResponse_Builder*) mergeFrom:(GetTpnoolResponse*) other;
- (GetTpnoolResponse_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input;
- (GetTpnoolResponse_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasTpnoolVer;
- (int32_t) tpnoolVer;
- (GetTpnoolResponse_Builder*) setTpnoolVer:(int32_t) value;
- (GetTpnoolResponse_Builder*) clearTpnoolVer;

- (ES_PBAppendableArray *)mobileTpnoolData;
- (TpnoolData*)mobileTpnoolDataAtIndex:(NSUInteger)index;
- (GetTpnoolResponse_Builder *)addMobileTpnoolData:(TpnoolData*)value;
- (GetTpnoolResponse_Builder *)setMobileTpnoolDataArray:(NSArray *)array;
- (GetTpnoolResponse_Builder *)setMobileTpnoolDataValues:(const TpnoolData* *)values count:(NSUInteger)count;
- (GetTpnoolResponse_Builder *)clearMobileTpnoolData;

- (ES_PBAppendableArray *)telTpnoolData;
- (TpnoolData*)telTpnoolDataAtIndex:(NSUInteger)index;
- (GetTpnoolResponse_Builder *)addTelTpnoolData:(TpnoolData*)value;
- (GetTpnoolResponse_Builder *)setTelTpnoolDataArray:(NSArray *)array;
- (GetTpnoolResponse_Builder *)setTelTpnoolDataValues:(const TpnoolData* *)values count:(NSUInteger)count;
- (GetTpnoolResponse_Builder *)clearTelTpnoolData;
@end

