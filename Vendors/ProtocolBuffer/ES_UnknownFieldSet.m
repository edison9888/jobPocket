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

#import "ES_UnknownFieldSet.h"

#import "ES_CodedInputStream.h"
#import "ES_CodedOutputStream.h"
#import "ES_Field.h"
#import "ES_UnknownFieldSet_Builder.h"

@interface ES_PBUnknownFieldSet()
@property (retain) NSDictionary* fields;
@end


@implementation ES_PBUnknownFieldSet

static ES_PBUnknownFieldSet* defaultInstance = nil;

+ (void) initialize {
  if (self == [ES_PBUnknownFieldSet class]) {
    defaultInstance = [[ES_PBUnknownFieldSet setWithFields:[NSMutableDictionary dictionary]] retain];
  }
}


@synthesize fields;

- (void) dealloc {
  self.fields = nil;

  [super dealloc];
}


+ (ES_PBUnknownFieldSet*) defaultInstance {
  return defaultInstance;
}


- (id) initWithFields:(NSMutableDictionary*) fields_ {
  if ((self = [super init])) {
    self.fields = fields_;
  }

  return self;
}


+ (ES_PBUnknownFieldSet*) setWithFields:(NSMutableDictionary*) fields {
  return [[[ES_PBUnknownFieldSet alloc] initWithFields:fields] autorelease];
}


- (BOOL) hasField:(int32_t) number {
  return [fields objectForKey:[NSNumber numberWithInt:number]] != nil;
}


- (ES_PBField*) getField:(int32_t) number {
  ES_PBField* result = [fields objectForKey:[NSNumber numberWithInt:number]];
  return (result == nil) ? [ES_PBField defaultInstance] : result;
}


- (void) writeToCodedOutputStream:(ES_PBCodedOutputStream*) output {
  NSArray* sortedKeys = [fields.allKeys sortedArrayUsingSelector:@selector(compare:)];
  for (NSNumber* number in sortedKeys) {
    ES_PBField* value = [fields objectForKey:number];
    [value writeTo:number.intValue output:output];
  }
}


- (void) writeToOutputStream:(NSOutputStream*) output {
  ES_PBCodedOutputStream* codedOutput = [ES_PBCodedOutputStream streamWithOutputStream:output];
  [self writeToCodedOutputStream:codedOutput];
  [codedOutput flush];
}


- (void) writeDescriptionTo:(NSMutableString*) output
                 withIndent:(NSString *)indent {
  NSArray* sortedKeys = [fields.allKeys sortedArrayUsingSelector:@selector(compare:)];
  for (NSNumber* number in sortedKeys) {
    ES_PBField* value = [fields objectForKey:number];
    [value writeDescriptionFor:number.intValue to:output withIndent:indent];
  }
}


+ (ES_PBUnknownFieldSet*) parseFromCodedInputStream:(ES_PBCodedInputStream*) input {
  return [[[ES_PBUnknownFieldSet builder] mergeFromCodedInputStream:input] build];
}


+ (ES_PBUnknownFieldSet*) parseFromData:(NSData*) data {
  return [[[ES_PBUnknownFieldSet builder] mergeFromData:data] build];
}


+ (ES_PBUnknownFieldSet*) parseFromInputStream:(NSInputStream*) input {
  return [[[ES_PBUnknownFieldSet builder] mergeFromInputStream:input] build];
}


+ (ES_PBUnknownFieldSet_Builder*) builder {
  return [[[ES_PBUnknownFieldSet_Builder alloc] init] autorelease];
}


+ (ES_PBUnknownFieldSet_Builder*) builderWithUnknownFields:(ES_PBUnknownFieldSet*) copyFrom {
  return [[ES_PBUnknownFieldSet builder] mergeUnknownFields:copyFrom];
}


/** Get the number of bytes required to encode this set. */
- (int32_t) serializedSize {
  int32_t result = 0;
  for (NSNumber* number in fields) {
    result += [[fields objectForKey:number] getSerializedSize:number.intValue];
  }
  return result;
}

/**
 * Serializes the set and writes it to {@code output} using
 * {@code MessageSet} wire format.
 */
- (void) writeAsMessageSetTo:(ES_PBCodedOutputStream*) output {
  for (NSNumber* number in fields) {
    [[fields objectForKey:number] writeAsMessageSetExtensionTo:number.intValue output:output];
  }
}


/**
 * Get the number of bytes required to encode this set using
 * {@code MessageSet} wire format.
 */
- (int32_t) serializedSizeAsMessageSet {
  int32_t result = 0;
  for (NSNumber* number in fields) {
    result += [[fields objectForKey:number] getSerializedSizeAsMessageSetExtension:number.intValue];
  }
  return result;
}


/**
 * Serializes the message to a {@code ByteString} and returns it. This is
 * just a trivial wrapper around {@link #writeTo(ES_PBCodedOutputStream)}.
 */
- (NSData*) data {
  NSMutableData* data = [NSMutableData dataWithLength:self.serializedSize];
  ES_PBCodedOutputStream* output = [ES_PBCodedOutputStream streamWithData:data];

  [self writeToCodedOutputStream:output];
  return data;
}

@end
