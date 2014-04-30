// Protocol Buffers for Objective C
//
// Copyright 2010 Booyah Inc.
// Copyright 2008 Cyrus Najmabadi
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "ES_ConcreteExtensionField.h"

#import "ES_AbstractMessage.h"
#import "ES_CodedInputStream.h"
#import "ES_CodedOutputStream.h"
#import "ES_ExtendableMessage_Builder.h"
#import "ES_Message_Builder.h"
#import "ES_Utilities.h"
#import "ES_WireFormat.h"

@interface ES_PBConcreteExtensionField()
@property ES_PBExtensionType type;
@property (assign) Class extendedClass;
@property int32_t fieldNumber;
@property (retain) id defaultValue;
@property (assign) Class messageOrGroupClass;
@property BOOL isRepeated;
@property BOOL isPacked;
@property BOOL isMessageSetWireFormat;
@end

@implementation ES_PBConcreteExtensionField

@synthesize type;
@synthesize extendedClass;
@synthesize fieldNumber;
@synthesize defaultValue;
@synthesize messageOrGroupClass;
@synthesize isRepeated;
@synthesize isPacked;
@synthesize isMessageSetWireFormat;

- (void) dealloc {
  self.type = 0;
  self.extendedClass = nil;
  self.fieldNumber = 0;
  self.defaultValue = nil;
  self.messageOrGroupClass = nil;
  self.isRepeated = NO;
  self.isPacked = NO;
  self.isMessageSetWireFormat = NO;
  [super dealloc];
}


- (id)     initWithType:(ES_PBExtensionType) type_
          extendedClass:(Class) extendedClass_
            fieldNumber:(int32_t) fieldNumber_
           defaultValue:(id) defaultValue_
    messageOrGroupClass:(Class) messageOrGroupClass_
             isRepeated:(BOOL) isRepeated_
               isPacked:(BOOL) isPacked_
    isMessageSetWireFormat:(BOOL) isMessageSetWireFormat_ {
  if ((self = [super init])) {
    self.type = type_;
    self.extendedClass = extendedClass_;
    self.fieldNumber = fieldNumber_;
    self.defaultValue = defaultValue_;
    self.messageOrGroupClass = messageOrGroupClass_;
    self.isRepeated = isRepeated_;
    self.isPacked = isPacked_;
    self.isMessageSetWireFormat = isMessageSetWireFormat_;
  }

  return self;
}


+ (ES_PBConcreteExtensionField*) extensionWithType:(ES_PBExtensionType) type
                                extendedClass:(Class) extendedClass
                                  fieldNumber:(int32_t) fieldNumber
                                 defaultValue:(id) defaultValue
                    messageOrGroupClass:(Class) messageOrGroupClass
                                   isRepeated:(BOOL) isRepeated
                                     isPacked:(BOOL) isPacked
                       isMessageSetWireFormat:(BOOL) isMessageSetWireFormat {
  return [[[ES_PBConcreteExtensionField alloc] initWithType:type
                                         extendedClass:extendedClass
                                           fieldNumber:fieldNumber
                                          defaultValue:defaultValue
                             messageOrGroupClass:messageOrGroupClass
                                            isRepeated:isRepeated
                                              isPacked:isPacked
                                isMessageSetWireFormat:isMessageSetWireFormat] autorelease];
}


- (ES_PBWireFormat) wireType {
  if (isPacked) {
    return ES_PBWireFormatLengthDelimited;
  }

  switch (type) {
    case ES_PBExtensionTypeBool:     return ES_PBWireFormatVarint;
    case ES_PBExtensionTypeFixed32:  return ES_PBWireFormatFixed32;
    case ES_PBExtensionTypeSFixed32: return ES_PBWireFormatFixed32;
    case ES_PBExtensionTypeFloat:    return ES_PBWireFormatFixed32;
    case ES_PBExtensionTypeFixed64:  return ES_PBWireFormatFixed64;
    case ES_PBExtensionTypeSFixed64: return ES_PBWireFormatFixed64;
    case ES_PBExtensionTypeDouble:   return ES_PBWireFormatFixed64;
    case ES_PBExtensionTypeInt32:    return ES_PBWireFormatVarint;
    case ES_PBExtensionTypeInt64:    return ES_PBWireFormatVarint;
    case ES_PBExtensionTypeSInt32:   return ES_PBWireFormatVarint;
    case ES_PBExtensionTypeSInt64:   return ES_PBWireFormatVarint;
    case ES_PBExtensionTypeUInt32:   return ES_PBWireFormatVarint;
    case ES_PBExtensionTypeUInt64:   return ES_PBWireFormatVarint;
    case ES_PBExtensionTypeBytes:    return ES_PBWireFormatLengthDelimited;
    case ES_PBExtensionTypeString:   return ES_PBWireFormatLengthDelimited;
    case ES_PBExtensionTypeMessage:  return ES_PBWireFormatLengthDelimited;
    case ES_PBExtensionTypeGroup:    return ES_PBWireFormatStartGroup;
    case ES_PBExtensionTypeEnum:     return ES_PBWireFormatVarint;
  }

  @throw [NSException exceptionWithName:@"InternalError" reason:@"" userInfo:nil];
}


BOOL ES_typeIsFixedSize(ES_PBExtensionType type) {
  switch (type) {
    case ES_PBExtensionTypeBool:
    case ES_PBExtensionTypeFixed32:
    case ES_PBExtensionTypeSFixed32:
    case ES_PBExtensionTypeFloat:
    case ES_PBExtensionTypeFixed64:
    case ES_PBExtensionTypeSFixed64:
    case ES_PBExtensionTypeDouble:
      return YES;
    default:
      return NO;
  }
}


int32_t ES_typeSize(ES_PBExtensionType type) {
  switch (type) {
    case ES_PBExtensionTypeBool:
      return 1;
    case ES_PBExtensionTypeFixed32:
    case ES_PBExtensionTypeSFixed32:
    case ES_PBExtensionTypeFloat:
      return 4;
    case ES_PBExtensionTypeFixed64:
    case ES_PBExtensionTypeSFixed64:
    case ES_PBExtensionTypeDouble:
      return 8;
    default:
      break;
  }

  @throw [NSException exceptionWithName:@"InternalError" reason:@"" userInfo:nil];
}


- (void)           writeSingleValue:(id) value
    includingTagToCodedOutputStream:(ES_PBCodedOutputStream*) output {
  switch (type) {
    case ES_PBExtensionTypeBool:
      [output writeBool:fieldNumber value:[value boolValue]];
      return;
    case ES_PBExtensionTypeFixed32:
      [output writeFixed32:fieldNumber value:[value intValue]];
      return;
    case ES_PBExtensionTypeSFixed32:
      [output writeSFixed32:fieldNumber value:[value intValue]];
      return;
    case ES_PBExtensionTypeFloat:
      [output writeFloat:fieldNumber value:[value floatValue]];
      return;
    case ES_PBExtensionTypeFixed64:
      [output writeFixed64:fieldNumber value:[value longLongValue]];
      return;
    case ES_PBExtensionTypeSFixed64:
      [output writeSFixed64:fieldNumber value:[value longLongValue]];
      return;
    case ES_PBExtensionTypeDouble:
      [output writeDouble:fieldNumber value:[value doubleValue]];
      return;
    case ES_PBExtensionTypeInt32:
      [output writeInt32:fieldNumber value:[value intValue]];
      return;
    case ES_PBExtensionTypeInt64:
      [output writeInt64:fieldNumber value:[value longLongValue]];
      return;
    case ES_PBExtensionTypeSInt32:
      [output writeSInt32:fieldNumber value:[value intValue]];
      return;
    case ES_PBExtensionTypeSInt64:
      [output writeSInt64:fieldNumber value:[value longLongValue]];
      return;
    case ES_PBExtensionTypeUInt32:
      [output writeUInt32:fieldNumber value:[value intValue]];
      return;
    case ES_PBExtensionTypeUInt64:
      [output writeUInt64:fieldNumber value:[value longLongValue]];
      return;
    case ES_PBExtensionTypeBytes:
      [output writeData:fieldNumber value:value];
      return;
    case ES_PBExtensionTypeString:
      [output writeString:fieldNumber value:value];
      return;
    case ES_PBExtensionTypeGroup:
      [output writeGroup:fieldNumber value:value];
      return;
    case ES_PBExtensionTypeEnum:
      [output writeEnum:fieldNumber value:[value intValue]];
      return;
    case ES_PBExtensionTypeMessage:
      if (isMessageSetWireFormat) {
        [output writeMessageSetExtension:fieldNumber value:value];
      } else {
        [output writeMessage:fieldNumber value:value];
      }
      return;
  }

  @throw [NSException exceptionWithName:@"InternalError" reason:@"" userInfo:nil];
}


- (void)           writeSingleValue:(id) value
    noTagToCodedOutputStream:(ES_PBCodedOutputStream*) output {
  switch (type) {
    case ES_PBExtensionTypeBool:
      [output writeBoolNoTag:[value boolValue]];
      return;
    case ES_PBExtensionTypeFixed32:
      [output writeFixed32NoTag:[value intValue]];
      return;
    case ES_PBExtensionTypeSFixed32:
      [output writeSFixed32NoTag:[value intValue]];
      return;
    case ES_PBExtensionTypeFloat:
      [output writeFloatNoTag:[value floatValue]];
      return;
    case ES_PBExtensionTypeFixed64:
      [output writeFixed64NoTag:[value longLongValue]];
      return;
    case ES_PBExtensionTypeSFixed64:
      [output writeSFixed64NoTag:[value longLongValue]];
      return;
    case ES_PBExtensionTypeDouble:
      [output writeDoubleNoTag:[value doubleValue]];
      return;
    case ES_PBExtensionTypeInt32:
      [output writeInt32NoTag:[value intValue]];
      return;
    case ES_PBExtensionTypeInt64:
      [output writeInt64NoTag:[value longLongValue]];
      return;
    case ES_PBExtensionTypeSInt32:
      [output writeSInt32NoTag:[value intValue]];
      return;
    case ES_PBExtensionTypeSInt64:
      [output writeSInt64NoTag:[value longLongValue]];
      return;
    case ES_PBExtensionTypeUInt32:
      [output writeUInt32NoTag:[value intValue]];
      return;
    case ES_PBExtensionTypeUInt64:
      [output writeUInt64NoTag:[value longLongValue]];
      return;
    case ES_PBExtensionTypeBytes:
      [output writeDataNoTag:value];
      return;
    case ES_PBExtensionTypeString:
      [output writeStringNoTag:value];
      return;
    case ES_PBExtensionTypeGroup:
      [output writeGroupNoTag:fieldNumber value:value];
      return;
    case ES_PBExtensionTypeEnum:
      [output writeEnumNoTag:[value intValue]];
      return;
    case ES_PBExtensionTypeMessage:
      [output writeMessageNoTag:value];
      return;
  }

  @throw [NSException exceptionWithName:@"InternalError" reason:@"" userInfo:nil];
}


- (int32_t) computeSingleSerializedSizeNoTag:(id) value {
  switch (type) {
    case ES_PBExtensionTypeBool:     return ES_computeBoolSizeNoTag([value boolValue]);
    case ES_PBExtensionTypeFixed32:  return ES_computeFixed32SizeNoTag([value intValue]);
    case ES_PBExtensionTypeSFixed32: return ES_computeSFixed32SizeNoTag([value intValue]);
    case ES_PBExtensionTypeFloat:    return ES_computeFloatSizeNoTag([value floatValue]);
    case ES_PBExtensionTypeFixed64:  return ES_computeFixed64SizeNoTag([value longLongValue]);
    case ES_PBExtensionTypeSFixed64: return ES_computeSFixed64SizeNoTag([value longLongValue]);
    case ES_PBExtensionTypeDouble:   return ES_computeDoubleSizeNoTag([value doubleValue]);
    case ES_PBExtensionTypeInt32:    return ES_computeInt32SizeNoTag([value intValue]);
    case ES_PBExtensionTypeInt64:    return ES_computeInt64SizeNoTag([value longLongValue]);
    case ES_PBExtensionTypeSInt32:   return ES_computeSInt32SizeNoTag([value intValue]);
    case ES_PBExtensionTypeSInt64:   return ES_computeSInt64SizeNoTag([value longLongValue]);
    case ES_PBExtensionTypeUInt32:   return ES_computeUInt32SizeNoTag([value intValue]);
    case ES_PBExtensionTypeUInt64:   return ES_computeUInt64SizeNoTag([value longLongValue]);
    case ES_PBExtensionTypeBytes:    return ES_computeDataSizeNoTag(value);
    case ES_PBExtensionTypeString:   return ES_computeStringSizeNoTag(value);
    case ES_PBExtensionTypeGroup:    return ES_computeGroupSizeNoTag(value);
    case ES_PBExtensionTypeEnum:     return ES_computeEnumSizeNoTag([value intValue]);
    case ES_PBExtensionTypeMessage:  return ES_computeMessageSizeNoTag(value);
  }

  @throw [NSException exceptionWithName:@"InternalError" reason:@"" userInfo:nil];
}


- (int32_t) computeSingleSerializedSizeIncludingTag:(id) value {
  switch (type) {
    case ES_PBExtensionTypeBool:     return ES_computeBoolSize(fieldNumber, [value boolValue]);
    case ES_PBExtensionTypeFixed32:  return ES_computeFixed32Size(fieldNumber, [value intValue]);
    case ES_PBExtensionTypeSFixed32: return ES_computeSFixed32Size(fieldNumber, [value intValue]);
    case ES_PBExtensionTypeFloat:    return ES_computeFloatSize(fieldNumber, [value floatValue]);
    case ES_PBExtensionTypeFixed64:  return ES_computeFixed64Size(fieldNumber, [value longLongValue]);
    case ES_PBExtensionTypeSFixed64: return ES_computeSFixed64Size(fieldNumber, [value longLongValue]);
    case ES_PBExtensionTypeDouble:   return ES_computeDoubleSize(fieldNumber, [value doubleValue]);
    case ES_PBExtensionTypeInt32:    return ES_computeInt32Size(fieldNumber, [value intValue]);
    case ES_PBExtensionTypeInt64:    return ES_computeInt64Size(fieldNumber, [value longLongValue]);
    case ES_PBExtensionTypeSInt32:   return ES_computeSInt32Size(fieldNumber, [value intValue]);
    case ES_PBExtensionTypeSInt64:   return ES_computeSInt64Size(fieldNumber, [value longLongValue]);
    case ES_PBExtensionTypeUInt32:   return ES_computeUInt32Size(fieldNumber, [value intValue]);
    case ES_PBExtensionTypeUInt64:   return ES_computeUInt64Size(fieldNumber, [value longLongValue]);
    case ES_PBExtensionTypeBytes:    return ES_computeDataSize(fieldNumber, value);
    case ES_PBExtensionTypeString:   return ES_computeStringSize(fieldNumber, value);
    case ES_PBExtensionTypeGroup:    return ES_computeGroupSize(fieldNumber, value);
    case ES_PBExtensionTypeEnum:     return ES_computeEnumSize(fieldNumber, [value intValue]);
    case ES_PBExtensionTypeMessage:
      if (isMessageSetWireFormat) {
        return ES_computeMessageSetExtensionSize(fieldNumber, value);
      } else {
        return ES_computeMessageSize(fieldNumber, value);
      }
  }

  @throw [NSException exceptionWithName:@"InternalError" reason:@"" userInfo:nil];
}


- (void) writeDescriptionOfSingleValue:(id) value
                                    to:(NSMutableString*) output
                            withIndent:(NSString*) indent {
  switch (type) {
    case ES_PBExtensionTypeBool:
    case ES_PBExtensionTypeFixed32:
    case ES_PBExtensionTypeSFixed32:
    case ES_PBExtensionTypeFloat:
    case ES_PBExtensionTypeFixed64:
    case ES_PBExtensionTypeSFixed64:
    case ES_PBExtensionTypeDouble:
    case ES_PBExtensionTypeInt32:
    case ES_PBExtensionTypeInt64:
    case ES_PBExtensionTypeSInt32:
    case ES_PBExtensionTypeSInt64:
    case ES_PBExtensionTypeUInt32:
    case ES_PBExtensionTypeUInt64:
    case ES_PBExtensionTypeBytes:
    case ES_PBExtensionTypeString:
    case ES_PBExtensionTypeEnum:
      [output appendFormat:@"%@%@\n", indent, value];
      return;
    case ES_PBExtensionTypeGroup:
    case ES_PBExtensionTypeMessage:
      [((ES_PBAbstractMessage *)value) writeDescriptionTo:output withIndent:indent];
      return;
  }
  @throw [NSException exceptionWithName:@"InternalError" reason:@"" userInfo:nil];
}


- (void)         writeRepeatedValues:(NSArray*) values
    includingTagsToCodedOutputStream:(ES_PBCodedOutputStream*) output {
  if (isPacked) {
    [output writeTag:fieldNumber format:ES_PBWireFormatLengthDelimited];
    int32_t dataSize = 0;
    if (ES_typeIsFixedSize(type)) {
      dataSize = values.count * ES_typeSize(type);
    } else {
      for (id value in values) {
        dataSize += [self computeSingleSerializedSizeNoTag:value];
      }
    }
    [output writeRawVarint32:dataSize];
    for (id value in values) {
      [self writeSingleValue:value noTagToCodedOutputStream:output];
    }
  } else {
    for (id value in values) {
      [self writeSingleValue:value includingTagToCodedOutputStream:output];
    }
  }
}


- (void) writeValue:(id) value includingTagToCodedOutputStream:(ES_PBCodedOutputStream*) output {
  if (isRepeated) {
    [self writeRepeatedValues:value includingTagsToCodedOutputStream:output];
  } else {
    [self writeSingleValue:value includingTagToCodedOutputStream:output];
  }
}


- (int32_t) computeRepeatedSerializedSizeIncludingTags:(NSArray*) values {
  if (isPacked) {
    int32_t size = 0;
    if (ES_typeIsFixedSize(type)) {
      size = values.count * ES_typeSize(type);
    } else {
      for (id value in values) {
        size += [self computeSingleSerializedSizeNoTag:value];
      }
    }
    return size + ES_computeTagSize(fieldNumber) + ES_computeRawVarint32Size(size);
  } else {
    int32_t size = 0;
    for (id value in values) {
      size += [self computeSingleSerializedSizeIncludingTag:value];
    }
    return size;
  }
}


- (int32_t) computeSerializedSizeIncludingTag:(id) value {
  if (isRepeated) {
    return [self computeRepeatedSerializedSizeIncludingTags:value];
  } else {
    return [self computeSingleSerializedSizeIncludingTag:value];
  }
}


- (void) writeDescriptionOf:(id)value
                         to:(NSMutableString *)output
                 withIndent:(NSString *)indent {
  if (isRepeated) {
    NSArray* values = value;
    for (id singleValue in values) {
      [self writeDescriptionOfSingleValue:singleValue to:output withIndent:indent];
    }
  } else {
    [self writeDescriptionOfSingleValue:value to:output withIndent:indent];
  }
}

- (void) mergeMessageSetExtentionFromCodedInputStream:(ES_PBCodedInputStream*) input
                                        unknownFields:(ES_PBUnknownFieldSet_Builder*) unknownFields {
  @throw [NSException exceptionWithName:@"NYI" reason:@"" userInfo:nil];

  // The wire format for MessageSet is:
  //   message MessageSet {
  //     repeated group Item = 1 {
  //       required int32 typeId = 2;
  //       required bytes message = 3;
  //     }
  //   }
  // "typeId" is the extension's field number.  The extension can only be
  // a message type, where "message" contains the encoded bytes of that
  // message.
  //
  // In practice, we will probably never see a MessageSet item in which
  // the message appears before the type ID, or where either field does not
  // appear exactly once.  However, in theory such cases are valid, so we
  // should be prepared to accept them.

  //int typeId = 0;
//  ByteString rawBytes = null;
//
//  while (true) {
//    final int tag = input.readTag();
//    if (tag == 0) {
//      break;
//    }
//
//    if (tag == WireFormat.MESSAGE_SET_TYPE_ID_TAG) {
//      typeId = input.readUInt32();
//      // Zero is not a valid type ID.
//      if (typeId != 0) {
//        if (rawBytes != null) {
//          unknownFields.mergeField(typeId,
//                                   UnknownFieldSet.Field.newBuilder()
//                                   .addLengthDelimited(rawBytes)
//                                   .build());
//          rawBytes = null;
//        }
//      }
//    } else if (tag == WireFormat.MESSAGE_SET_MESSAGE_TAG) {
//      if (typeId == 0) {
//        // We haven't seen a type ID yet, so we have to store the raw bytes
//        // for now.
//        rawBytes = input.readBytes();
//      } else {
//        unknownFields.mergeField(typeId,
//                                 UnknownFieldSet.Field.newBuilder()
//                                 .addLengthDelimited(input.readBytes())
//                                 .build());
//      }
//    } else {
//      // Unknown fieldNumber.  Skip it.
//      if (!input.skipField(tag)) {
//        break;  // end of group
//      }
//    }
//  }
//
//  input.checkLastTagWas(WireFormat.MESSAGE_SET_ITEM_END_TAG);
}


- (id) readSingleValueFromCodedInputStream:(ES_PBCodedInputStream*) input
                         extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry {
  switch (type) {
    case ES_PBExtensionTypeBool:     return [NSNumber numberWithBool:[input readBool]];
    case ES_PBExtensionTypeFixed32:  return [NSNumber numberWithInt:[input readFixed32]];
    case ES_PBExtensionTypeSFixed32: return [NSNumber numberWithInt:[input readSFixed32]];
    case ES_PBExtensionTypeFloat:    return [NSNumber numberWithFloat:[input readFloat]];
    case ES_PBExtensionTypeFixed64:  return [NSNumber numberWithLongLong:[input readFixed64]];
    case ES_PBExtensionTypeSFixed64: return [NSNumber numberWithLongLong:[input readSFixed64]];
    case ES_PBExtensionTypeDouble:   return [NSNumber numberWithDouble:[input readDouble]];
    case ES_PBExtensionTypeInt32:    return [NSNumber numberWithInt:[input readInt32]];
    case ES_PBExtensionTypeInt64:    return [NSNumber numberWithLongLong:[input readInt64]];
    case ES_PBExtensionTypeSInt32:   return [NSNumber numberWithInt:[input readSInt32]];
    case ES_PBExtensionTypeSInt64:   return [NSNumber numberWithLongLong:[input readSInt64]];
    case ES_PBExtensionTypeUInt32:   return [NSNumber numberWithInt:[input readUInt32]];
    case ES_PBExtensionTypeUInt64:   return [NSNumber numberWithLongLong:[input readUInt64]];
    case ES_PBExtensionTypeBytes:    return [input readData];
    case ES_PBExtensionTypeString:   return [input readString];
    case ES_PBExtensionTypeEnum:     return [NSNumber numberWithInt:[input readEnum]];
    case ES_PBExtensionTypeGroup:
    {
      id<ES_PBMessage_Builder> builder = [messageOrGroupClass builder];
      [input readGroup:fieldNumber builder:builder extensionRegistry:extensionRegistry];
      return [builder build];
    }

    case ES_PBExtensionTypeMessage:
    {
      id<ES_PBMessage_Builder> builder = [messageOrGroupClass builder];
      [input readMessage:builder extensionRegistry:extensionRegistry];
      return [builder build];
    }
  }

  @throw [NSException exceptionWithName:@"InternalError" reason:@"" userInfo:nil];
}


- (void) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input
                     unknownFields:(ES_PBUnknownFieldSet_Builder*) unknownFields
     extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry
    builder:(ES_PBExtendableMessage_Builder*) builder
                               tag:(int32_t) tag {
  if (isPacked) {
    int32_t length = [input readRawVarint32];
    int32_t limit = [input pushLimit:length];
    while ([input bytesUntilLimit] > 0) {
      id value = [self readSingleValueFromCodedInputStream:input extensionRegistry:extensionRegistry];
      [builder addExtension:self value:value];
    }
    [input popLimit:limit];
  } else if (isMessageSetWireFormat) {
    [self mergeMessageSetExtentionFromCodedInputStream:input
                                         unknownFields:unknownFields];
  } else {
    id value = [self readSingleValueFromCodedInputStream:input extensionRegistry:extensionRegistry];
    if (isRepeated) {
      [builder addExtension:self value:value];
    } else {
      [builder setExtension:self value:value];
    }
  }
}


@end
