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

#import "ES_GeneratedMessage_Builder.h"

#import "ES_GeneratedMessage.h"
#import "ES_Message.h"
#import "ES_Message_Builder.h"
#import "ES_UnknownFieldSet.h"
#import "ES_UnknownFieldSet_Builder.h"


@interface ES_PBGeneratedMessage ()
@property (retain) ES_PBUnknownFieldSet* unknownFields;
@end


@implementation ES_PBGeneratedMessage_Builder

/**
 * Get the message being built.  We don't just pass this to the
 * constructor because it becomes null when build() is called.
 */
- (ES_PBGeneratedMessage*) internalGetResult {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (void) checkInitialized {
  ES_PBGeneratedMessage* result = self.internalGetResult;
  if (result != nil && !result.isInitialized) {
    @throw [NSException exceptionWithName:@"UninitializedMessage" reason:@"" userInfo:nil];
  }
}


- (ES_PBUnknownFieldSet*) unknownFields {
  return self.internalGetResult.unknownFields;
}


- (id<ES_PBMessage_Builder>) setUnknownFields:(ES_PBUnknownFieldSet*) unknownFields {
  self.internalGetResult.unknownFields = unknownFields;
  return self;
}


- (id<ES_PBMessage_Builder>) mergeUnknownFields:(ES_PBUnknownFieldSet*) unknownFields {
  ES_PBGeneratedMessage* result = self.internalGetResult;
  result.unknownFields =
  [[[ES_PBUnknownFieldSet builderWithUnknownFields:result.unknownFields]
    mergeUnknownFields:unknownFields] build];
  return self;
}


- (BOOL) isInitialized {
  return self.internalGetResult.isInitialized;
}


/**
 * Called by subclasses to parse an unknown field.
 * @return {@code YES} unless the tag is an end-group tag.
 */
- (BOOL) parseUnknownField:(ES_PBCodedInputStream*) input
             unknownFields:(ES_PBUnknownFieldSet_Builder*) unknownFields
         extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry
                       tag:(int32_t) tag {
  return [unknownFields mergeFieldFrom:tag input:input];
}


- (void) checkInitializedParsed {
  ES_PBGeneratedMessage* result = self.internalGetResult;
  if (result != nil && !result.isInitialized) {
    @throw [NSException exceptionWithName:@"InvalidProtocolBuffer" reason:@"" userInfo:nil];
  }
}

@end
