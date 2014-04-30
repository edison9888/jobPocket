//
//  NSDataAdditions.h
//  CloudCity
//
//  Created by mjlee on 10-9-29.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSMutableData(Addtions)

- (NSMutableData*) EncryptAES: (NSString *) key;
- (NSMutableData*) DecryptAES: (NSString *) key andForData:(NSMutableData*)objEncryptedData;

@end