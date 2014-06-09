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

#import "ES_UnknownFieldSet_Builder.h"

#import "ES_CodedInputStream.h"
#import "ES_Field.h"
#import "ES_MutableField.h"
#import "ES_UnknownFieldSet.h"
#import "ES_WireFormat.h"

@interface ES_PBUnknownFieldSet_Builder ()
@property (retain) NSMutableDictionary* fields;
@property int32_t lastFieldNumber;
@property (retain) ES_PBMutableField* lastField;
@end


@implementation ES_PBUnknownFieldSet_Builder

@synthesize fields;
@synthesize lastFieldNumber;
@synthesize lastField;


- (void) dealloc {
  self.fields = nil;
  self.lastFieldNumber = 0;
  self.lastField = nil;

  [super dealloc];
}


- (id) init {
  if ((self = [super init])) {
    self.fields = [NSMutableDictionary dictionary];
  }
  return self;
}


+ (ES_PBUnknownFieldSet_Builder*) createBuilder:(ES_PBUnknownFieldSet*) unknownFields {
  ES_PBUnknownFieldSet_Builder* builder = [[[ES_PBUnknownFieldSet_Builder alloc] init] autorelease];
  [builder mergeUnknownFields:unknownFields];
  return builder;
}


/**
 * Add a field to the {@code ES_PBUnknownFieldSet}.  If a field with the same
 * number already exists, it is removed.
 */
- (ES_PBUnknownFieldSet_Builder*) addField:(ES_PBField*) field forNumber:(int32_t) number {
  if (number == 0) {
    @throw [NSException exceptionWithName:@"IllegalArgument" reason:@"" userInfo:nil];
  }
  if (lastField != nil && lastFieldNumber == number) {
    // Discard this.
    self.lastField = nil;
    lastFieldNumber = 0;
  }
  [fields setObject:field forKey:[NSNumber numberWithInt:number]];
  return self;
}


/**
 * Get a field builder for the given field number which includes any
 * values that already exist.
 */
- (ES_PBMutableField*) getFieldBuilder:(int32_t) number {
  if (lastField != nil) {
    if (number == lastFieldNumber) {
      return lastField;
    }
    // Note:  addField() will reset lastField and lastFieldNumber.
    [self addField:lastField forNumber:lastFieldNumber];
  }
  if (number == 0) {
    return nil;
  } else {
    ES_PBField* existing = [fields objectForKey:[NSNumber numberWithInt:number]];
    lastFieldNumber = number;
    self.lastField = [ES_PBMutableField field];
    if (existing != nil) {
      [lastField mergeFromField:existing];
    }
    return lastField;
  }
}


- (ES_PBUnknownFieldSet*) build {
  [self getFieldBuilder:0];  // Force lastField to be built.
  ES_PBUnknownFieldSet* result;
  if (fields.count == 0) {
    result = [ES_PBUnknownFieldSet defaultInstance];
  } else {
    result = [ES_PBUnknownFieldSet setWithFields:fields];
  }
  self.fields = nil;
  return result;
}

- (ES_PBUnknownFieldSet*) buildPartial {
  @throw [NSException exceptionWithName:@"UnsupportedMethod" reason:@"" userInfo:nil];
}

- (ES_PBUnknownFieldSet*) clone {
  @throw [NSException exceptionWithName:@"UnsupportedMethod" reason:@"" userInfo:nil];
}

- (BOOL) isInitialized {
  return YES;
}

- (ES_PBUnknownFieldSet*) defaultInstance {
  @throw [NSException exceptionWithName:@"UnsupportedMethod" reason:@"" userInfo:nil];
}

- (ES_PBUnknownFieldSet*) unknownFields {
  return [self build];
}

- (id<ES_PBMessage_Builder>) setUnknownFields:(ES_PBUnknownFieldSet*) unknownFields {
  @throw [NSException exceptionWithName:@"UnsupportedMethod" reason:@"" userInfo:nil];
}

/** Check if the given field number is present in the set. */
- (BOOL) hasField:(int32_t) number {
  if (number == 0) {
    @throw [NSException exceptionWithName:@"IllegalArgument" reason:@"" userInfo:nil];
  }

  return number == lastFieldNumber || ([fields objectForKey:[NSNumber numberWithInt:number]] != nil);
}


/**
 * Add a field to the {@code ES_PBUnknownFieldSet}.  If a field with the same
 * number already exists, the two are merged.
 */
- (ES_PBUnknownFieldSet_Builder*) mergeField:(ES_PBField*) field forNumber:(int32_t) number {
  if (number == 0) {
    @throw [NSException exceptionWithName:@"IllegalArgument" reason:@"" userInfo:nil];
  }
  if ([self hasField:number]) {
    [[self getFieldBuilder:number] mergeFromField:field];
  } else {
    // Optimization:  We could call getFieldBuilder(number).mergeFrom(field)
    // in this case, but that would create a copy of the ES_PBField object.
    // We'd rather reuse the one passed to us, so call addField() instead.
    [self addField:field forNumber:number];
  }

  return self;
}


- (ES_PBUnknownFieldSet_Builder*) mergeUnknownFields:(ES_PBUnknownFieldSet*) other {
  if (other != [ES_PBUnknownFieldSet defaultInstance]) {
    for (NSNumber* number in other.fields) {
      ES_PBField* field = [other.fields objectForKey:number];
      [self mergeField:field forNumber:[number intValue]];
    }
  }
  return self;
}


- (ES_PBUnknownFieldSet_Builder*) mergeFromData:(NSData*) data {
  ES_PBCodedInputStream* input = [ES_PBCodedInputStream streamWithData:data];
  [self mergeFromCodedInputStream:input];
  [input checkLastTagWas:0];
  return self;
}


- (ES_PBUnknownFieldSet_Builder*) mergeFromData:(NSData*) data extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry {
  ES_PBCodedInputStream* input = [ES_PBCodedInputStream streamWithData:data];
  [self mergeFromCodedInputStream:input extensionRegistry:extensionRegistry];
  [input checkLastTagWas:0];
  return self;
}


- (ES_PBUnknownFieldSet_Builder*) mergeFromInputStream:(NSInputStream*) input {
  @throw [NSException exceptionWithName:@"UnsupportedMethod" reason:@"" userInfo:nil];
}

- (ES_PBUnknownFieldSet_Builder*) mergeFromInputStream:(NSInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry {
  @throw [NSException exceptionWithName:@"UnsupportedMethod" reason:@"" userInfo:nil];
}

- (ES_PBUnknownFieldSet_Builder*) mergeVarintField:(int32_t) number value:(int32_t) value {
  if (number == 0) {
    @throw [NSException exceptionWithName:@"IllegalArgument" reason:@"Zero is not a valid field number." userInfo:nil];
  }

  [[self getFieldBuilder:number] addVarint:value];
  return self;
}


/**
 * Parse a single field from {@code input} and merge it into this set.
 * @param tag The field's tag number, which was already parsed.
 * @return {@code NO} if the tag is an engroup tag.
 */
- (BOOL) mergeFieldFrom:(int32_t) tag input:(ES_PBCodedInputStream*) input {
  int32_t number = ES_PBWireFormatGetTagFieldNumber(tag);
  switch (ES_PBWireFormatGetTagWireType(tag)) {
    case ES_PBWireFormatVarint:
      [[self getFieldBuilder:number] addVarint:[input readInt64]];
      return YES;
    case ES_PBWireFormatFixed64:
      [[self getFieldBuilder:number] addFixed64:[input readFixed64]];
      return YES;
    case ES_PBWireFormatLengthDelimited:
      [[self getFieldBuilder:number] addLengthDelimited:[input readData]];
      return YES;
    case ES_PBWireFormatStartGroup: {
      ES_PBUnknownFieldSet_Builder* subBuilder = [ES_PBUnknownFieldSet builder];
      [input readUnknownGroup:number builder:subBuilder];
      [[self getFieldBuilder:number] addGroup:[subBuilder build]];
      return YES;
    }
    case ES_PBWireFormatEndGroup:
      return NO;
    case ES_PBWireFormatFixed32:
      [[self getFieldBuilder:number] addFixed32:[input readFixed32]];
      return YES;
    default:
      @throw [NSException exceptionWithName:@"InvalidProtocolBuffer" reason:@"" userInfo:nil];
  }
}


/**
 * Parse an entire message from {@code input} and merge its fields into
 * this set.
 */
- (ES_PBUnknownFieldSet_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input {
  while (YES) {
    int32_t tag = [input readTag];
    if (tag == 0 || ![self mergeFieldFrom:tag input:input]) {
      break;
    }
  }
  return self;
}

- (ES_PBUnknownFieldSet_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry {
  @throw [NSException exceptionWithName:@"UnsupportedMethod" reason:@"" userInfo:nil];
}

- (ES_PBUnknownFieldSet_Builder*) clear {
  self.fields = [NSMutableDictionary dictionary];
  self.lastFieldNumber = 0;
  self.lastField = nil;
  return self;
}

@end
