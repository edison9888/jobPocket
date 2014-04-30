//
//  NSMutableDataAdditions.m
//  CloudCity
//
//  Created by mjlee on 10-9-29.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "NSMutableDataAdditions.h"

@implementation NSMutableData(Addtions)

- (NSMutableData*) EncryptAES: (NSString *) key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero( keyPtr, sizeof(keyPtr) );
    
    [key getCString: keyPtr maxLength: sizeof(keyPtr) encoding: NSUTF16StringEncoding];
    size_t numBytesEncrypted = 0;
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
    
    
    //NSMutableData *output = [[[NSMutableData alloc] init] autorelease];
    
    
    
    CCCryptorStatus result = CCCrypt( kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                     keyPtr, kCCKeySizeAES256,
                                     NULL,
                                     [self mutableBytes], [self length],
                                     buffer, bufferSize,
                                     &numBytesEncrypted );
    
    
    NSMutableData * output = [NSMutableData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    if( result == kCCSuccess )
    {
        return output;
    }
    return NULL;
}

- (NSMutableData*) DecryptAES: (NSString *) key andForData:(NSMutableData*)objEncryptedData
{
    char  keyPtr[kCCKeySizeAES256+1];
    bzero( keyPtr, sizeof(keyPtr) );
    
    [key getCString: keyPtr maxLength: sizeof(keyPtr) encoding: NSUTF16StringEncoding];
    
    size_t numBytesEncrypted = 0;
    
    NSUInteger dataLength = [self length];
	
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer_decrypt = malloc(bufferSize);    
    //NSMutableData *output_decrypt = [[[NSMutableData alloc] init] autorelease];
    CCCryptorStatus result = CCCrypt( kCCDecrypt , kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                     keyPtr, kCCKeySizeAES256,
                                     NULL,
                                     [self mutableBytes], [self length],
                                     buffer_decrypt, bufferSize,
                                     &numBytesEncrypted );
    
    NSMutableData * output_decrypt = [NSMutableData dataWithBytesNoCopy:buffer_decrypt length:numBytesEncrypted];
    if( result == kCCSuccess )
    {
        return output_decrypt;
    }
    return NULL;
}

@end
