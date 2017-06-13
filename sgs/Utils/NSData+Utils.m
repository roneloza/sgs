//
//  NSData+Utils.m
//  sgs
//
//  Created by rone loza on 6/12/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "NSData+Utils.h"

@implementation NSData (Utils)

+ (NSData *)dataFromBase64EncodedString:(NSString *)base64EncodedString {
    
    NSData *dataBase64Deoded = nil;
    
    if (base64EncodedString) {
     
        dataBase64Deoded = [[NSData alloc] initWithBase64EncodedString:base64EncodedString options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
    }
    
    return dataBase64Deoded;
}
@end
