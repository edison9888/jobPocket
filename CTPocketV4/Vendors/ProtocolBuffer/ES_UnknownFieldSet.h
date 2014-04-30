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

@class ES_PBCodedOutputStream;
@class ES_PBField;
@class ES_PBUnknownFieldSet_Builder;

@interface ES_PBUnknownFieldSet : NSObject {
@private
  NSDictionary* fields;
}

@property (readonly, retain) NSDictionary* fields;

+ (ES_PBUnknownFieldSet*) defaultInstance;

+ (ES_PBUnknownFieldSet*) setWithFields:(NSMutableDictionary*) fields;
+ (ES_PBUnknownFieldSet*) parseFromData:(NSData*) data;

+ (ES_PBUnknownFieldSet_Builder*) builder;
+ (ES_PBUnknownFieldSet_Builder*) builderWithUnknownFields:(ES_PBUnknownFieldSet*) other;

- (void) writeAsMessageSetTo:(ES_PBCodedOutputStream*) output;
- (void) writeToCodedOutputStream:(ES_PBCodedOutputStream*) output;
- (NSData*) data;

- (int32_t) serializedSize;
- (int32_t) serializedSizeAsMessageSet;

- (BOOL) hasField:(int32_t) number;
- (ES_PBField*) getField:(int32_t) number;

- (void) writeDescriptionTo:(NSMutableString*) output
                 withIndent:(NSString*) indent;

@end
