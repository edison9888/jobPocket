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

typedef enum {
  ES_PBWireFormatVarint = 0,
  ES_PBWireFormatFixed64 = 1,
  ES_PBWireFormatLengthDelimited = 2,
  ES_PBWireFormatStartGroup = 3,
  ES_PBWireFormatEndGroup = 4,
  ES_PBWireFormatFixed32 = 5,

  ES_PBWireFormatTagTypeBits = 3,
  ES_PBWireFormatTagTypeMask = 7 /* = (1 << ES_PBWireFormatTagTypeBits) - 1*/,

  ES_PBWireFormatMessageSetItem = 1,
  ES_PBWireFormatMessageSetTypeId = 2,
  ES_PBWireFormatMessageSetMessage = 3
} ES_PBWireFormat;

int32_t ES_PBWireFormatMakeTag(int32_t fieldNumber, int32_t wireType);
int32_t ES_PBWireFormatGetTagWireType(int32_t tag);
int32_t ES_PBWireFormatGetTagFieldNumber(int32_t tag);

#define ES_PBWireFormatMessageSetItemTag (ES_PBWireFormatMakeTag(ES_PBWireFormatMessageSetItem, ES_PBWireFormatStartGroup))
#define ES_PBWireFormatMessageSetItemEndTag (ES_PBWireFormatMakeTag(ES_PBWireFormatMessageSetItem, ES_PBWireFormatEndGroup))
#define ES_PBWireFormatMessageSetTypeIdTag (ES_PBWireFormatMakeTag(ES_PBWireFormatMessageSetTypeId, ES_PBWireFormatVarint))
#define ES_PBWireFormatMessageSetMessageTag (ES_PBWireFormatMakeTag(ES_PBWireFormatMessageSetMessage, ES_PBWireFormatLengthDelimited))
