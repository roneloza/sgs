//
//  NSData+Utils.h
//  sgs
//
//  Created by rone loza on 6/12/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Utils)

+ (NSData *)dataFromBase64EncodedString:(NSString *)base64EncodedString;

@end
