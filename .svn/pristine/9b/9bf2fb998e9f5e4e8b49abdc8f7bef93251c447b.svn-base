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

#import "ES_Message_Builder.h"

@class ES_PBField;
@class ES_PBMutableField;

@interface ES_PBUnknownFieldSet_Builder : NSObject <ES_PBMessage_Builder> {
@private
  NSMutableDictionary* fields;

  // Optimization:  We keep around a builder for the last field that was
  //   modified so that we can efficiently add to it multiple times in a
  //   row (important when parsing an unknown repeated field).
  int32_t lastFieldNumber;

  ES_PBMutableField* lastField;
}

+ (ES_PBUnknownFieldSet_Builder*) createBuilder:(ES_PBUnknownFieldSet*) unknownFields;

- (ES_PBUnknownFieldSet*) build;
- (ES_PBUnknownFieldSet_Builder*) mergeUnknownFields:(ES_PBUnknownFieldSet*) other;

- (ES_PBUnknownFieldSet_Builder*) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input;
- (ES_PBUnknownFieldSet_Builder*) mergeFromData:(NSData*) data;
- (ES_PBUnknownFieldSet_Builder*) mergeFromInputStream:(NSInputStream*) input;

- (ES_PBUnknownFieldSet_Builder*) mergeVarintField:(int32_t) number value:(int32_t) value;

- (BOOL) mergeFieldFrom:(int32_t) tag input:(ES_PBCodedInputStream*) input;

- (ES_PBUnknownFieldSet_Builder*) addField:(ES_PBField*) field forNumber:(int32_t) number;

- (ES_PBUnknownFieldSet_Builder*) clear;
- (ES_PBUnknownFieldSet_Builder*) mergeField:(ES_PBField*) field forNumber:(int32_t) number;

@end
