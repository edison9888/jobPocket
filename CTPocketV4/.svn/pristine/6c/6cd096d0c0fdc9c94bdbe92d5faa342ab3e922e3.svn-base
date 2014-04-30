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

#import "ES_WireFormat.h"

@class ES_PBCodedInputStream;
@class ES_PBCodedOutputStream;
@class ES_PBExtendableMessage_Builder;
@class ES_PBExtensionRegistry;
@class ES_PBUnknownFieldSet_Builder;

@protocol ES_PBExtensionField
- (int32_t) fieldNumber;
- (ES_PBWireFormat) wireType;
- (BOOL) isRepeated;
- (Class) extendedClass;
- (id) defaultValue;

- (void) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input
                     unknownFields:(ES_PBUnknownFieldSet_Builder*) unknownFields
                 extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry
                           builder:(ES_PBExtendableMessage_Builder*) builder
                               tag:(int32_t) tag;
- (void) writeValue:(id) value includingTagToCodedOutputStream:(ES_PBCodedOutputStream*) output;
- (int32_t) computeSerializedSizeIncludingTag:(id) value;
- (void) writeDescriptionOf:(id) value
                         to:(NSMutableString*) output
                 withIndent:(NSString*) indent;
@end
