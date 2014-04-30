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

#import <Foundation/Foundation.h>

@class ES_PBArray;
@class ES_PBAppendableArray;
@class ES_PBCodedOutputStream;

@interface ES_PBField : NSObject
{
@protected
	ES_PBAppendableArray *	_varintArray;
	ES_PBAppendableArray *	_fixed32Array;
	ES_PBAppendableArray *	_fixed64Array;
	ES_PBAppendableArray *	_lengthDelimitedArray;
	ES_PBAppendableArray *	_groupArray;
}

@property (nonatomic,retain,readonly) ES_PBArray *	varintArray;
@property (nonatomic,retain,readonly) ES_PBArray *	fixed32Array;
@property (nonatomic,retain,readonly) ES_PBArray *	fixed64Array;
@property (nonatomic,retain,readonly) ES_PBArray *	lengthDelimitedArray;
@property (nonatomic,retain,readonly) ES_PBArray *	groupArray;

+ (ES_PBField *)defaultInstance;

- (int32_t)getSerializedSize:(int32_t)fieldNumber;
- (int32_t)getSerializedSizeAsMessageSetExtension:(int32_t)fieldNumber;

- (void)writeTo:(int32_t) fieldNumber output:(ES_PBCodedOutputStream *)output;
- (void)writeAsMessageSetExtensionTo:(int32_t)fieldNumber output:(ES_PBCodedOutputStream *)output;
- (void)writeDescriptionFor:(int32_t) fieldNumber
                         to:(NSMutableString*) output
                 withIndent:(NSString*) indent;
@end
