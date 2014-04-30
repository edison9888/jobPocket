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

#import "ES_AbstractMessage_Builder.h"

#import "ES_CodedInputStream.h"
#import "ES_ExtensionRegistry.h"
#import "ES_Message_Builder.h"
#import "ES_UnknownFieldSet.h"
#import "ES_UnknownFieldSet_Builder.h"


@implementation ES_PBAbstractMessage_Builder

- (id<ES_PBMessage_Builder>) clone {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (id<ES_PBMessage_Builder>) clear {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (id<ES_PBMessage_Builder>) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[ES_PBExtensionRegistry emptyRegistry]];
}


- (id<ES_PBMessage_Builder>) mergeFromCodedInputStream:(ES_PBCodedInputStream*) input
                                  extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (id<ES_PBMessage_Builder>) mergeUnknownFields:(ES_PBUnknownFieldSet*) unknownFields {
  ES_PBUnknownFieldSet* merged =
  [[[ES_PBUnknownFieldSet builderWithUnknownFields:self.unknownFields]
    mergeUnknownFields:unknownFields] build];

  [self setUnknownFields:merged];
  return self;
}


- (id<ES_PBMessage_Builder>) mergeFromData:(NSData*) data {
  ES_PBCodedInputStream* input = [ES_PBCodedInputStream streamWithData:data];
  [self mergeFromCodedInputStream:input];
  [input checkLastTagWas:0];
  return self;
}


- (id<ES_PBMessage_Builder>) mergeFromData:(NSData*) data
                      extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry {
  ES_PBCodedInputStream* input = [ES_PBCodedInputStream streamWithData:data];
  [self mergeFromCodedInputStream:input extensionRegistry:extensionRegistry];
  [input checkLastTagWas:0];
  return self;
}


- (id<ES_PBMessage_Builder>) mergeFromInputStream:(NSInputStream*) input {
  ES_PBCodedInputStream* codedInput = [ES_PBCodedInputStream streamWithInputStream:input];
  [self mergeFromCodedInputStream:codedInput];
  [codedInput checkLastTagWas:0];
  return self;
}


- (id<ES_PBMessage_Builder>) mergeFromInputStream:(NSInputStream*) input
                             extensionRegistry:(ES_PBExtensionRegistry*) extensionRegistry {
  ES_PBCodedInputStream* codedInput = [ES_PBCodedInputStream streamWithInputStream:input];
  [self mergeFromCodedInputStream:codedInput extensionRegistry:extensionRegistry];
  [codedInput checkLastTagWas:0];
  return self;
}


- (id<ES_PBMessage>) build {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (id<ES_PBMessage>) buildPartial {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (BOOL) isInitialized {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (id<ES_PBMessage>) defaultInstance {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (ES_PBUnknownFieldSet*) unknownFields {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}


- (id<ES_PBMessage_Builder>) setUnknownFields:(ES_PBUnknownFieldSet*) unknownFields {
  @throw [NSException exceptionWithName:@"ImproperSubclassing" reason:@"" userInfo:nil];
}

@end
