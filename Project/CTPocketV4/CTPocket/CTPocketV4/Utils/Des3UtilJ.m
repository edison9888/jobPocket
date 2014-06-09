//
//  Des3UtilJ.m
//  TaskDemo
//
//  Created by Gong Xintao on 14-3-25.
//  Copyright (c) 2014年 com.ataol.view. All rights reserved.
//

#import "Des3UtilJ.h"
#import <CommonCrypto/CommonCryptor.h>
#define  ALGORITHM   @"DESede"//解密类型，copy java范例
#define HEX_STRING "0123456789abcdef0123456789ABCDEF"
typedef struct byte_array
{
    Byte *array;int lenght;
}byte_array;
 
@implementation Des3UtilJ

#pragma mark 转换成十六进制字符串
+(NSString*)byte2hex:(Byte* )b len:(int)lenght
{
    
    NSMutableString *hs = [NSMutableString string];
    for (int n = 0; n <lenght; n++) {
        @autoreleasepool {
            NSString *stmp  =[NSString stringWithFormat:@"%x",(b[n] & 0XFF)];
            if (stmp.length == 1)
            {
                [hs appendFormat:@"0%@",stmp];
            }
            else
            {
                [hs appendFormat:@"%@",stmp];
            }
        }
    }
    return [hs uppercaseString];
}



#pragma mark 通过参数encryptOrDecrypt判断进行加密还是解密操作
+ (NSString*) doCipher:(NSString*)plainText enc:(CCOperation)encryptOrDecrypt{
    
     Byte *vplainText;
    size_t plainTextBufferSize;
    
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        const char *s=[plainText cStringUsingEncoding:NSUTF8StringEncoding];
        int sl= plainText.length ;
        int i =sl/ 2;
        Byte *abyte0=(Byte * )malloc( i * sizeof(Byte));
        int j = 0;
        if (sl % 2 != 0)return nil;
        for (int k = 0; k < i; k++)
        {
            char c  =s[j++];
            int hl=strlen(HEX_STRING);
            int l=-1;
            for (int ii=0;ii<hl;ii++) {
                if(c==HEX_STRING[ii])
                {
                    l=ii;
                    break;
                }
            }
            if (l==-1) {
                return nil;
            }
            int i1 = (l & 0xf) << 4;
            c=s[j++];
            for (int ii=0;ii<hl;ii++) {
                if(c==HEX_STRING[ii])
                {
                    l=ii;
                    break;
                }
            }
            i1 += l & 0xf;
            abyte0[k] = (Byte) i1;
        }
        vplainText=abyte0;
        plainTextBufferSize=i;

    }
    else
    {
        vplainText = (Byte*)[plainText UTF8String];
        plainTextBufferSize=strlen(((char*)vplainText));
    }
    
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr =(uint8_t * )malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    //用来加密解密的key
    Byte keyData[24]={49,50,51,52,53,54,55,96,57,48,107,111,105,117,121,104,103,116,102,114,100,101,119,115};
    unsigned char IV3[8]={0,0,0,0,0,0,0,0};
    
    uint8_t iv[kCCBlockSize3DES];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding ,
                       keyData, //"123456789012345678901234", //key result1
                       kCCKeySize3DES,
                       IV3 ,  //iv,
                       vplainText,  //plainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    if (ccStatus == kCCParamError) return @"PARAM ERROR";
    else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
    else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
    else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
    else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
    else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        
        result = [[NSString alloc] initWithBytes:bufferPtr length:movedBytes
                                        encoding:NSUTF8StringEncoding];
    }
    else
    {
        result=[self byte2hex:bufferPtr len:(NSUInteger)movedBytes];
    }
     
    free(bufferPtr) ;
    if (encryptOrDecrypt == kCCDecrypt)
    {
        free (vplainText);
    }
    
    return result;
}
@end
