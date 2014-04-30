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

#import "ES_ExtensionField.h"

typedef enum {
  ES_PBExtensionTypeBool,
  ES_PBExtensionTypeFixed32,
  ES_PBExtensionTypeSFixed32,
  ES_PBExtensionTypeFloat,
  ES_PBExtensionTypeFixed64,
  ES_PBExtensionTypeSFixed64,
  ES_PBExtensionTypeDouble,
  ES_PBExtensionTypeInt32,
  ES_PBExtensionTypeInt64,
  ES_PBExtensionTypeSInt32,
  ES_PBExtensionTypeSInt64,
  ES_PBExtensionTypeUInt32,
  ES_PBExtensionTypeUInt64,
  ES_PBExtensionTypeBytes,
  ES_PBExtensionTypeString,
  ES_PBExtensionTypeMessage,
  ES_PBExtensionTypeGroup,
  ES_PBExtensionTypeEnum
} ES_PBExtensionType;

@interface ES_PBConcreteExtensionField : NSObject<ES_PBExtensionField> {
@private
  ES_PBExtensionType type;

  Class extendedClass;
  int32_t fieldNumber;
  id defaultValue;

  Class messageOrGroupClass;

  BOOL isRepeated;
  BOOL isPacked;
  BOOL isMessageSetWireFormat;
}

+ (ES_PBConcreteExtensionField*) extensionWithType:(ES_PBExtensionType) type
                                extendedClass:(Class) extendedClass
                                  fieldNumber:(int32_t) fieldNumber
                                 defaultValue:(id) defaultValue
                            messageOrGroupClass:(Class) messageOrGroupClass
                                   isRepeated:(BOOL) isRepeated
                                     isPacked:(BOOL) isPacked
                       isMessageSetWireFormat:(BOOL) isMessageSetWireFormat;

@end
