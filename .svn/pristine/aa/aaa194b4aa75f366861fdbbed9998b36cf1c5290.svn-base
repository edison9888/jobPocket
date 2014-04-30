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

#import "ES_Utilities.h"

#import "ES_UnknownFieldSet.h"
#import "ES_WireFormat.h"

const int32_t ES_LITTLE_ENDIAN_32_SIZE = 4;
const int32_t ES_LITTLE_ENDIAN_64_SIZE = 8;


int64_t ES_convertFloat64ToInt64(Float64 v) {
  union { Float64 f; int64_t i; } u;
  u.f = v;
  return u.i;
}


int32_t ES_convertFloat32ToInt32(Float32 v) {
  union { Float32 f; int32_t i; } u;
  u.f = v;
  return u.i;
}


Float64 ES_convertInt64ToFloat64(int64_t v) {
  union { Float64 f; int64_t i; } u;
  u.i = v;
  return u.f;
}


Float32 ES_convertInt32ToFloat32(int32_t v) {
  union { Float32 f; int32_t i; } u;
  u.i = v;
  return u.f;
}


uint64_t ES_convertInt64ToUInt64(int64_t v) {
  union { int64_t i; uint64_t u; } u;
  u.i = v;
  return u.u;
}


int64_t ES_convertUInt64ToInt64(uint64_t v) {
  union { int64_t i; uint64_t u; } u;
  u.u = v;
  return u.i;
}

uint32_t ES_convertInt32ToUInt32(int32_t v) {
  union { int32_t i; uint32_t u; } u;
  u.i = v;
  return u.u;
}


int64_t ES_convertUInt32ToInt32(uint32_t v) {
  union { int32_t i; uint32_t u; } u;
  u.u = v;
  return u.i;
}


int32_t ES_logicalRightShift32(int32_t value, int32_t spaces) {
  return ES_convertUInt32ToInt32((ES_convertInt32ToUInt32(value) >> spaces));
}


int64_t ES_logicalRightShift64(int64_t value, int32_t spaces) {
  return ES_convertUInt64ToInt64((ES_convertInt64ToUInt64(value) >> spaces));
}


int32_t ES_decodeZigZag32(int32_t n) {
	return ES_logicalRightShift32(n, 1) ^ -(n & 1);
}


int64_t ES_decodeZigZag64(int64_t n) {
	return ES_logicalRightShift64(n, 1) ^ -(n & 1);
}


int32_t ES_encodeZigZag32(int32_t n) {
	// Note:  the right-shift must be arithmetic
	return (n << 1) ^ (n >> 31);
}


int64_t ES_encodeZigZag64(int64_t n) {
	// Note:  the right-shift must be arithmetic
	return (n << 1) ^ (n >> 63);
}


int32_t ES_computeDoubleSizeNoTag(Float64 value) {
	return ES_LITTLE_ENDIAN_64_SIZE;
}


int32_t ES_computeFloatSizeNoTag(Float32 value) {
	return ES_LITTLE_ENDIAN_32_SIZE;
}


int32_t ES_computeUInt64SizeNoTag(int64_t value) {
	return ES_computeRawVarint64Size(value);
}


int32_t ES_computeInt64SizeNoTag(int64_t value) {
	return ES_computeRawVarint64Size(value);
}


int32_t ES_computeInt32SizeNoTag(int32_t value) {
	if (value >= 0) {
		return ES_computeRawVarint32Size(value);
	} else {
		// Must sign-extend.
		return 10;
	}
}


int32_t ES_computeFixed64SizeNoTag(int64_t value) {
	return ES_LITTLE_ENDIAN_64_SIZE;
}


int32_t ES_computeFixed32SizeNoTag(int32_t value) {
	return ES_LITTLE_ENDIAN_32_SIZE;
}


int32_t ES_computeBoolSizeNoTag(BOOL value) {
	return 1;
}


int32_t ES_computeStringSizeNoTag(const NSString* value) {
	const NSUInteger length = [value lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
	return ES_computeRawVarint32Size(length) + length;
}


int32_t ES_computeGroupSizeNoTag(const id<ES_PBMessage> value) {
	return [value serializedSize];
}


int32_t ES_computeUnknownGroupSizeNoTag(const ES_PBUnknownFieldSet* value) {
	return value.serializedSize;
}


int32_t ES_computeMessageSizeNoTag(const id<ES_PBMessage> value) {
	int32_t size = [value serializedSize];
	return ES_computeRawVarint32Size(size) + size;
}


int32_t ES_computeDataSizeNoTag(const NSData* value) {
	return ES_computeRawVarint32Size(value.length) + value.length;
}


int32_t ES_computeUInt32SizeNoTag(int32_t value) {
	return ES_computeRawVarint32Size(value);
}


int32_t ES_computeEnumSizeNoTag(int32_t value) {
	return ES_computeRawVarint32Size(value);
}


int32_t ES_computeSFixed32SizeNoTag(int32_t value) {
	return ES_LITTLE_ENDIAN_32_SIZE;
}


int32_t ES_computeSFixed64SizeNoTag(int64_t value) {
	return ES_LITTLE_ENDIAN_64_SIZE;
}


int32_t ES_computeSInt32SizeNoTag(int32_t value) {
	return ES_computeRawVarint32Size(ES_encodeZigZag32(value));
}


int32_t ES_computeSInt64SizeNoTag(int64_t value) {
	return ES_computeRawVarint64Size(ES_encodeZigZag64(value));
}


int32_t ES_computeDoubleSize(int32_t fieldNumber, Float64 value) {
	return ES_computeTagSize(fieldNumber) + ES_computeDoubleSizeNoTag(value);
}


int32_t ES_computeFloatSize(int32_t fieldNumber, Float32 value) {
	return ES_computeTagSize(fieldNumber) + ES_computeFloatSizeNoTag(value);
}


int32_t ES_computeUInt64Size(int32_t fieldNumber, int64_t value) {
	return ES_computeTagSize(fieldNumber) + ES_computeUInt64SizeNoTag(value);
}


int32_t ES_computeInt64Size(int32_t fieldNumber, int64_t value) {
	return ES_computeTagSize(fieldNumber) + ES_computeInt64SizeNoTag(value);
}


int32_t ES_computeInt32Size(int32_t fieldNumber, int32_t value) {
	return ES_computeTagSize(fieldNumber) + ES_computeInt32SizeNoTag(value);
}


int32_t ES_computeFixed64Size(int32_t fieldNumber, int64_t value) {
	return ES_computeTagSize(fieldNumber) + ES_computeFixed64SizeNoTag(value);
}


int32_t ES_computeFixed32Size(int32_t fieldNumber, int32_t value) {
	return ES_computeTagSize(fieldNumber) + ES_computeFixed32SizeNoTag(value);
}


int32_t ES_computeBoolSize(int32_t fieldNumber, BOOL value) {
	return ES_computeTagSize(fieldNumber) + ES_computeBoolSizeNoTag(value);
}


int32_t ES_computeStringSize(int32_t fieldNumber, const NSString* value) {
	return ES_computeTagSize(fieldNumber) + ES_computeStringSizeNoTag(value);
}


int32_t ES_computeGroupSize(int32_t fieldNumber, const id<ES_PBMessage> value) {
	return ES_computeTagSize(fieldNumber) * 2 + ES_computeGroupSizeNoTag(value);
}


int32_t ES_computeUnknownGroupSize(int32_t fieldNumber, const ES_PBUnknownFieldSet* value) {
	return ES_computeTagSize(fieldNumber) * 2 + ES_computeUnknownGroupSizeNoTag(value);
}


int32_t ES_computeMessageSize(int32_t fieldNumber, const id<ES_PBMessage> value) {
	return ES_computeTagSize(fieldNumber) + ES_computeMessageSizeNoTag(value);
}


int32_t ES_computeDataSize(int32_t fieldNumber, const NSData* value) {
	return ES_computeTagSize(fieldNumber) + ES_computeDataSizeNoTag(value);
}


int32_t ES_computeUInt32Size(int32_t fieldNumber, int32_t value) {
	return ES_computeTagSize(fieldNumber) + ES_computeUInt32SizeNoTag(value);
}


int32_t ES_computeEnumSize(int32_t fieldNumber, int32_t value) {
	return ES_computeTagSize(fieldNumber) + ES_computeEnumSizeNoTag(value);
}


int32_t ES_computeSFixed32Size(int32_t fieldNumber, int32_t value) {
	return ES_computeTagSize(fieldNumber) + ES_computeSFixed32SizeNoTag(value);
}


int32_t ES_computeSFixed64Size(int32_t fieldNumber, int64_t value) {
	return ES_computeTagSize(fieldNumber) + ES_computeSFixed64SizeNoTag(value);
}


int32_t ES_computeSInt32Size(int32_t fieldNumber, int32_t value) {
	return ES_computeTagSize(fieldNumber) + ES_computeSInt32SizeNoTag(value);
}


int32_t ES_computeTagSize(int32_t fieldNumber) {
	return ES_computeRawVarint32Size(ES_PBWireFormatMakeTag(fieldNumber, 0));
}


int32_t ES_computeSInt64Size(int32_t fieldNumber, int64_t value) {
	return ES_computeTagSize(fieldNumber) +
	ES_computeRawVarint64Size(ES_encodeZigZag64(value));
}


int32_t ES_computeRawVarint32Size(int32_t value) {
	if ((value & (0xffffffff <<  7)) == 0) return 1;
	if ((value & (0xffffffff << 14)) == 0) return 2;
	if ((value & (0xffffffff << 21)) == 0) return 3;
	if ((value & (0xffffffff << 28)) == 0) return 4;
	return 5;
}


int32_t ES_computeRawVarint64Size(int64_t value) {
	if ((value & (0xffffffffffffffffL <<  7)) == 0) return 1;
	if ((value & (0xffffffffffffffffL << 14)) == 0) return 2;
	if ((value & (0xffffffffffffffffL << 21)) == 0) return 3;
	if ((value & (0xffffffffffffffffL << 28)) == 0) return 4;
	if ((value & (0xffffffffffffffffL << 35)) == 0) return 5;
	if ((value & (0xffffffffffffffffL << 42)) == 0) return 6;
	if ((value & (0xffffffffffffffffL << 49)) == 0) return 7;
	if ((value & (0xffffffffffffffffL << 56)) == 0) return 8;
	if ((value & (0xffffffffffffffffL << 63)) == 0) return 9;
	return 10;
}


int32_t ES_computeMessageSetExtensionSize(int32_t fieldNumber, const id<ES_PBMessage> value) {
	return ES_computeTagSize(ES_PBWireFormatMessageSetItem) * 2 +
	ES_computeUInt32Size(ES_PBWireFormatMessageSetTypeId, fieldNumber) +
	ES_computeMessageSize(ES_PBWireFormatMessageSetMessage, value);
}


int32_t ES_computeRawMessageSetExtensionSize(int32_t fieldNumber, const NSData* value) {
	return ES_computeTagSize(ES_PBWireFormatMessageSetItem) * 2 +
	ES_computeUInt32Size(ES_PBWireFormatMessageSetTypeId, fieldNumber) +
	ES_computeDataSize(ES_PBWireFormatMessageSetMessage, value);
}
