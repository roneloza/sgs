//
//  PreferencesManager.h
//  statslite
//
//  Created by Rone Loza on 10/04/17.
//  Copyright © 2017 Rone Loza. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MenuDetailItem;
@interface PreferencesManager : NSObject

+ (NSDictionary *)getDictionaryFromPlist:(NSString *)plist;
+ (void)setPreferencesString:(NSString *)value forKey:(NSString *)key;
+ (NSString *)getPreferencesStringForKey:(NSString *)key;
+ (void)setPreferencesDictionary:(NSDictionary *)value forKey:(NSString *)key;
+ (NSDictionary *)getPreferencesDictionaryForKey:(NSString *)key;


+ (void)setPreferencesBOOL:(BOOL)value forKey:(NSString *)key;
+ (BOOL)getPreferencesBOOLForKey:(NSString *)key;
+ (BOOL)existPreferencesForKey:(NSString *)key;

+ (NSArray *)getSelectedColumnsWithIsPortrait:(BOOL)isPortrait data:(NSArray *)data;
+ (void)setSelectedColumnsDefaultsWithItem:(MenuDetailItem *)item;
+ (void)setSelectedColumnsWithIsPortrait:(BOOL)isPortrait data:(NSArray *)data;
@end
