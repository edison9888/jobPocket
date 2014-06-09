// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ES_ProtocolBuffers.h"

@class GetContactListVersionResponse;
@class GetContactListVersionResponse_Builder;
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


@interface GetContactListVersionProtoRoot : NSObject {
}
+ (ES_PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(ES_PBMutableExtensionRegistry*) registry;
@end

@interface GetContactListVersionResponse : ES_PBGeneratedMessage {
@private
  BOOL hasContactListVersion_:1;
  int32_t contactListVersion;
}
- (BOOL) hasContactListVersion;
@property (readonly) int32_t contactListVersion;

+ (GetContactListVersionResponse*) defaultInstance;
- (GetContactListVersionResponse*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(ES_PBCodedOutputStream*) output;
- (GetContactListVersionResponse_Builder*) builder;
+ (GetContactListVersionResponse_Builder*) builder;
+ (GetContactListVersionResponse_Builder*) builderWithPrototype:(GetContactListVersionResponse*) prototype;
- (GetContactListVersionResponse_Builder*) toBuilder;

+ (GetContactListVersionResponse*) parseFromData:(NSData*) data;
+ (GetContactListVersionResponse*) parseFromData:(NSData*) data extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
+ (GetContactListVersionResponse*) parseFromInputStream:(NSInputStream*) input;
+ (GetContactListVersionResponse*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
+ (GetContactListVersionResponse*) parseFromCodedInputStream:(ES_PBCodedInputStream*) input;
+ (GetContactListVersionResponse*) parseFromCodedInputStream:(ES_PBCodedInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;
@end

@interface GetContactListVersionResponse_Builder : ES_PBGeneratedMessage_Builder {
@private
  GetContactListVersionResponse* result;
}

- (GetContactListVersionResponse*) defaultInstance;

- (GetContactListVersionResponse_Builder*) clear;
- (GetContactListVersionResponse_Builder*) clone;

- (GetContactListVersionResponse*) build;
- (GetContactListVersionResponse*) buildPartial;

- (GetContactListVersionResponse_Builder*) mergeFrom:(GetContactListVersionResponse*) other;
- (GetContactListVersionResponse_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input;
- (GetContactListVersionResponse_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasContactListVersion;
- (int32_t) contactListVersion;
- (GetContactListVersionResponse_Builder*) setContactListVersion:(int32_t) value;
- (GetContactListVersionResponse_Builder*) clearContactListVersion;
@end

