//
//  JSONParserManager.h
//  statslite
//
//  Created by Rone Loza on 11/04/17.
//  Copyright © 2017 Rone Loza. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserProfile;

@interface JSONParserManager : NSObject

+ (NSArray *)getArrayDeserializeClassName:(NSString *)className jsonData:(NSData *)jsonData;

+ (id)getObjectDeserializeClassName:(NSString *)className jsonData:(NSData *)jsonData;

@end
