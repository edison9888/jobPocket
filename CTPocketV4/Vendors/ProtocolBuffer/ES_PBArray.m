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

#import "ES_PBArray.h"

NSString * const ES_PBArrayTypeMismatchException = @"ES_PBArrayTypeMismatchException";
NSString * const ES_PBArrayNumberExpectedException = @"ES_PBArrayNumberExpectedException";
NSString * const ES_PBArrayAllocationFailureException = @"ES_PBArrayAllocationFailureException";

#pragma mark NSNumber Setters

typedef void (*ES_PBArrayValueSetter)(NSNumber *number, void *value);

static void ES_PBArraySetBoolValue(NSNumber *number, void *value)
{
	*((BOOL *)value) = [number charValue];
}

static void ES_PBArraySetInt32Value(NSNumber *number, void *value)
{
	*((int32_t *)value) = [number intValue];
}

static void ES_PBArraySetUInt32Value(NSNumber *number, void *value)
{
	*((uint32_t *)value) = [number unsignedIntValue];
}

static void ES_PBArraySetInt64Value(NSNumber *number, void *value)
{
	*((int64_t *)value) = [number longLongValue];
}

static void ES_PBArraySetUInt64Value(NSNumber *number, void *value)
{
	*((uint64_t *)value) = [number unsignedLongLongValue];
}

static void ES_PBArraySetFloatValue(NSNumber *number, void *value)
{
	*((Float32 *)value) = [number floatValue];
}

static void ES_PBArraySetDoubleValue(NSNumber *number, void *value)
{
	*((Float64 *)value) = [number doubleValue];
}

#pragma mark Array Value Types

typedef struct _ES_PBArrayValueTypeInfo
{
	const size_t size;
	const ES_PBArrayValueSetter setter;
} ES_PBArrayValueTypeInfo;

static ES_PBArrayValueTypeInfo ES_PBValueTypes[] =
{
	{ sizeof(id),		NULL					},
	{ sizeof(BOOL),		ES_PBArraySetBoolValue		},
	{ sizeof(int32_t),	ES_PBArraySetInt32Value	},
	{ sizeof(uint32_t),	ES_PBArraySetUInt32Value	},
	{ sizeof(int64_t),	ES_PBArraySetInt64Value	},
	{ sizeof(uint64_t),	ES_PBArraySetUInt64Value	},
	{ sizeof(Float32),	ES_PBArraySetFloatValue	},
	{ sizeof(Float64),	ES_PBArraySetDoubleValue	},
};

#define ES_PBArrayValueTypeSize(type)		ES_PBValueTypes[type].size
#define ES_PBArrayValueTypeSetter(type)	ES_PBValueTypes[type].setter

#pragma mark Helper Macros

#define ES_PBArraySlot(index) (_data + (index * ES_PBArrayValueTypeSize(_valueType)))

#define ES_PBArrayForEachObject(__data, __count, x) \
	if (_valueType == ES_PBArrayValueTypeObject) \
		for (NSUInteger i = 0; i < __count; ++i) { id object = ((id *)__data)[i]; [object x]; }

#define ES_PBArrayValueTypeAssert(type) \
	if (__builtin_expect(_valueType != type, 0)) \
		[NSException raise:ES_PBArrayTypeMismatchException \
					format:@"array value type mismatch (expected '%s')", #type];

#define ES_PBArrayValueRangeAssert(index) \
	if (__builtin_expect(index >= _count, 0)) \
		[NSException raise:NSRangeException format: @"index (%u) beyond bounds (%u)", index, _count];

#define ES_PBArrayNumberAssert(value) \
	if (__builtin_expect(![value isKindOfClass:[NSNumber class]], 0)) \
		[NSException raise:ES_PBArrayNumberExpectedException format:@"NSNumber expected (got '%@')", [value class]];

#define ES_PBArrayAllocationAssert(p, size) \
	if (__builtin_expect(p == NULL, 0)) \
		[NSException raise:ES_PBArrayAllocationFailureException format:@"failed to allocate %lu bytes", size];

#pragma mark -
#pragma mark ES_PBArray

@implementation ES_PBArray

@synthesize valueType = _valueType;
@dynamic data;

- (id)initWithCount:(NSUInteger)count valueType:(ES_PBArrayValueType)valueType
{
	if ((self = [super init]))
	{
		_valueType = valueType;
		_count = count;
		_capacity = count;

		if (_capacity)
		{
			_data = malloc(_capacity * ES_PBArrayValueTypeSize(_valueType));
			if (_data == NULL)
			{
				[self release];
				self = nil;
			}
		}
	}

	return self;
}

- (id)copyWithZone:(NSZone *)zone
{
	ES_PBArray *copy = [[[self class] allocWithZone:zone] initWithCount:_count valueType:_valueType];
	if (copy)
	{
		memcpy(copy->_data, _data, _count * ES_PBArrayValueTypeSize(_valueType));
		ES_PBArrayForEachObject(_data, _count, retain);
	}

	return copy;
}

- (void)dealloc
{
	if (_data)
	{
		ES_PBArrayForEachObject(_data, _count, release);
		free(_data);
	}

	[super dealloc];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@ %p>{valueType = %d, count = %d, capacity = %d, data = %p}",
			[self class], self, _valueType, _count, _capacity, _data];
}

- (NSUInteger)count
{
	return _count;
}

- (const void *)data
{
	return _data;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
	// TODO: We only support enumeration of object values.  In the future, we
	// can extend this code to return a new list of NSNumber* objects wrapping
	// our primitive values.
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeObject);

	if (state->state >= _count)
	{
		return 0; // terminate iteration
	}

	state->itemsPtr = (id *)_data;
	state->state = _count;
	state->mutationsPtr = (unsigned long *)self;

	return _count;
}

- (id)objectAtIndex:(NSUInteger)index
{
	ES_PBArrayValueRangeAssert(index);
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeObject);
	return ((id *)_data)[index];
}

- (BOOL)boolAtIndex:(NSUInteger)index
{
	ES_PBArrayValueRangeAssert(index);
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeBool);
	return ((BOOL *)_data)[index];
}

- (int32_t)int32AtIndex:(NSUInteger)index
{
	ES_PBArrayValueRangeAssert(index);
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeInt32);
	return ((int32_t *)_data)[index];
}

- (uint32_t)uint32AtIndex:(NSUInteger)index
{
	ES_PBArrayValueRangeAssert(index);
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeUInt32);
	return ((uint32_t *)_data)[index];
}

- (int64_t)int64AtIndex:(NSUInteger)index
{
	ES_PBArrayValueRangeAssert(index);
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeInt64);
	return ((int64_t *)_data)[index];
}

- (uint64_t)uint64AtIndex:(NSUInteger)index
{
	ES_PBArrayValueRangeAssert(index);
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeUInt64);
	return ((uint64_t *)_data)[index];
}

- (Float32)floatAtIndex:(NSUInteger)index
{
	ES_PBArrayValueRangeAssert(index);
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeFloat);
	return ((Float32 *)_data)[index];
}

- (Float64)doubleAtIndex:(NSUInteger)index
{
	ES_PBArrayValueRangeAssert(index);
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeDouble);
	return ((Float64 *)_data)[index];
}

- (BOOL)isEqualToArray:(ES_PBArray *)array
{
	if (self == array)
	{
		return YES;
	}
	else if (array->_count != _count)
	{
		return NO;
	}
	else
	{
		return memcmp(array->_data, _data, _count * ES_PBArrayValueTypeSize(_valueType)) == 0;
	}
}

- (BOOL)isEqual:(id)object
{
	BOOL equal = NO;
	if ([object isKindOfClass:[ES_PBArray class]])
	{
		equal = [self isEqualToArray:object];
	}
	return equal;
}

@end

@implementation ES_PBArray (PBArrayExtended)

- (id)arrayByAppendingArray:(ES_PBArray *)array
{
	ES_PBArrayValueTypeAssert(array.valueType);

	ES_PBArray *result = [[[self class] alloc] initWithCount:_count + array.count valueType:_valueType];
	if (result)
	{
		const size_t elementSize = ES_PBArrayValueTypeSize(_valueType);
		const size_t originalSize = _count * elementSize;

		memcpy(result->_data, _data, originalSize);
		memcpy(result->_data + originalSize, array.data, array.count * elementSize);

		ES_PBArrayForEachObject(result->_data, result->_count, retain);
	}

	return [result autorelease];
}

@end

@implementation ES_PBArray (PBArrayCreation)

+ (id)arrayWithValueType:(ES_PBArrayValueType)valueType
{
	return [[[self alloc] initWithValueType:valueType] autorelease];
}

+ (id)arrayWithValues:(const void *)values count:(NSUInteger)count valueType:(ES_PBArrayValueType)valueType
{
	return [[[self alloc] initWithValues:values count:count valueType:valueType] autorelease];
}

+ (id)arrayWithArray:(NSArray *)array valueType:(ES_PBArrayValueType)valueType
{
	return [[[self alloc] initWithArray:array valueType:valueType] autorelease];
}

- (id)initWithValueType:(ES_PBArrayValueType)valueType
{
	return [self initWithCount:0 valueType:valueType];
}

- (id)initWithValues:(const void *)values count:(NSUInteger)count valueType:(ES_PBArrayValueType)valueType
{
	if ((self = [self initWithCount:count valueType:valueType]))
	{
		memcpy(_data, values, count * ES_PBArrayValueTypeSize(_valueType));
		ES_PBArrayForEachObject(_data, _count, retain);
	}

	return self;
}

- (id)initWithArray:(NSArray *)array valueType:(ES_PBArrayValueType)valueType
{
	if ((self = [self initWithCount:[array count] valueType:valueType]))
	{
		const size_t elementSize = ES_PBArrayValueTypeSize(valueType);
		size_t offset = 0;

		if (valueType == ES_PBArrayValueTypeObject)
		{
			for (id object in array)
			{
				*(id *)(_data + offset) = [object retain];
				offset += elementSize;
			}
		}
		else
		{
			ES_PBArrayValueSetter setter = ES_PBArrayValueTypeSetter(valueType);
			for (id object in array)
			{
				ES_PBArrayNumberAssert(object);
				setter((NSNumber *)object, _data + offset);
				offset += elementSize;
			}
		}
	}

	return self;
}

@end

#pragma mark -
#pragma mark ES_PBAppendableArray

@implementation ES_PBAppendableArray

- (void)ensureAdditionalCapacity:(NSUInteger)additionalSlots
{
	const NSUInteger requiredSlots = _count + additionalSlots;

	if (requiredSlots > _capacity)
	{
		// If we haven't allocated any capacity yet, simply reserve
		// enough capacity to cover the required number of slots.
		if (_capacity == 0)
		{
			_capacity = requiredSlots;
		}
		else
		{
			// Otherwise, continue to double our capacity until we
			// can accomodate the required number of slots.
			while (_capacity < requiredSlots)
			{
				_capacity *= 2;
			}
		}

		const size_t size = _capacity * ES_PBArrayValueTypeSize(_valueType);
		_data = reallocf(_data, size);
		ES_PBArrayAllocationAssert(_data, size);
	}
}

- (void)addObject:(id)value
{
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeObject);
	[self ensureAdditionalCapacity:1];
	*(id *)ES_PBArraySlot(_count) = [value retain];
	_count++;
}

- (void)addBool:(BOOL)value
{
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeBool);
	[self ensureAdditionalCapacity:1];
	*(BOOL *)ES_PBArraySlot(_count) = value;
	_count++;
}

- (void)addInt32:(int32_t)value
{
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeInt32);
	[self ensureAdditionalCapacity:1];
	*(int32_t *)ES_PBArraySlot(_count) = value;
	_count++;
}

- (void)addUint32:(uint32_t)value
{
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeUInt32);
	[self ensureAdditionalCapacity:1];
	*(uint32_t *)ES_PBArraySlot(_count) = value;
	_count++;
}

- (void)addInt64:(int64_t)value
{
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeInt64);
	[self ensureAdditionalCapacity:1];
	*(int64_t *)ES_PBArraySlot(_count) = value;
	_count++;
}

- (void)addUint64:(uint64_t)value
{
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeUInt64);
	[self ensureAdditionalCapacity:1];
	*(uint64_t *)ES_PBArraySlot(_count) = value;
	_count++;
}

- (void)addFloat:(Float32)value
{
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeFloat);
	[self ensureAdditionalCapacity:1];
	*(Float32 *)ES_PBArraySlot(_count) = value;
	_count++;
}

- (void)addDouble:(Float64)value
{
	ES_PBArrayValueTypeAssert(ES_PBArrayValueTypeDouble);
	[self ensureAdditionalCapacity:1];
	*(Float64 *)ES_PBArraySlot(_count) = value;
	_count++;
}

- (void)appendArray:(ES_PBArray *)array
{
	ES_PBArrayValueTypeAssert(array.valueType);
	[self ensureAdditionalCapacity:array.count];

	const size_t elementSize = ES_PBArrayValueTypeSize(_valueType);
	memcpy(_data + (_count * elementSize), array.data, array.count * elementSize);
	_count += array.count;

	ES_PBArrayForEachObject(array->_data, array->_count, retain);
}

- (void)appendValues:(const void *)values count:(NSUInteger)count
{
	[self ensureAdditionalCapacity:count];

	const size_t elementSize = ES_PBArrayValueTypeSize(_valueType);
	memcpy(_data + (_count * elementSize), values, count * elementSize);
	_count += count;

	ES_PBArrayForEachObject(values, count, retain);
}

@end
