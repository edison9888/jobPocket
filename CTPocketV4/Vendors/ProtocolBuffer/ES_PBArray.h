// Protocol Buffers for Objective C
//
// Copyright 2010 Booyah Inc.
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
//
// Author: Jon Parise <jon@booyah.com>

#import <Foundation/Foundation.h>

extern NSString * const ES_PBArrayTypeMismatchException;
extern NSString * const ES_PBArrayNumberExpectedException;
extern NSString * const ES_PBArrayAllocationFailureException;

typedef enum _ES_PBArrayValueType
{
	ES_PBArrayValueTypeObject,
	ES_PBArrayValueTypeBool,
	ES_PBArrayValueTypeInt32,
	ES_PBArrayValueTypeUInt32,
	ES_PBArrayValueTypeInt64,
	ES_PBArrayValueTypeUInt64,
	ES_PBArrayValueTypeFloat,
	ES_PBArrayValueTypeDouble,
} ES_PBArrayValueType;

// ES_PBArray is an immutable array class that's optimized for storing primitive
// values.  All values stored in an ES_PBArray instance must have the same type
// (ES_PBArrayValueType).  Object values (ES_PBArrayValueTypeObject) are retained.
@interface ES_PBArray : NSObject <NSCopying, NSFastEnumeration>
{
@protected
	ES_PBArrayValueType	_valueType;
	NSUInteger			_capacity;
	NSUInteger			_count;
	void *				_data;
}

- (NSUInteger)count;
- (id)objectAtIndex:(NSUInteger)index;
- (BOOL)boolAtIndex:(NSUInteger)index;
- (int32_t)int32AtIndex:(NSUInteger)index;
- (uint32_t)uint32AtIndex:(NSUInteger)index;
- (int64_t)int64AtIndex:(NSUInteger)index;
- (uint64_t)uint64AtIndex:(NSUInteger)index;
- (Float32)floatAtIndex:(NSUInteger)index;
- (Float64)doubleAtIndex:(NSUInteger)index;
- (BOOL)isEqualToArray:(ES_PBArray *)array;

@property (nonatomic,assign,readonly) ES_PBArrayValueType valueType;
@property (nonatomic,assign,readonly) const void * data;
@property (nonatomic,assign,readonly,getter=count) NSUInteger count;

@end

@interface ES_PBArray (PBArrayExtended)

- (id)arrayByAppendingArray:(ES_PBArray *)array;

@end

@interface ES_PBArray (PBArrayCreation)

+ (id)arrayWithValueType:(ES_PBArrayValueType)valueType;
+ (id)arrayWithValues:(const void *)values count:(NSUInteger)count valueType:(ES_PBArrayValueType)valueType;
+ (id)arrayWithArray:(NSArray *)array valueType:(ES_PBArrayValueType)valueType;
- (id)initWithValueType:(ES_PBArrayValueType)valueType;
- (id)initWithValues:(const void *)values count:(NSUInteger)count valueType:(ES_PBArrayValueType)valueType;
- (id)initWithArray:(NSArray *)array valueType:(ES_PBArrayValueType)valueType;

@end

// ES_PBAppendableArray extends ES_PBArray with the ability to append new values to
// the end of the array.
@interface ES_PBAppendableArray : ES_PBArray

- (void)addObject:(id)value;
- (void)addBool:(BOOL)value;
- (void)addInt32:(int32_t)value;
- (void)addUint32:(uint32_t)value;
- (void)addInt64:(int64_t)value;
- (void)addUint64:(uint64_t)value;
- (void)addFloat:(Float32)value;
- (void)addDouble:(Float64)value;

- (void)appendArray:(ES_PBArray *)array;
- (void)appendValues:(const void *)values count:(NSUInteger)count;

@end
