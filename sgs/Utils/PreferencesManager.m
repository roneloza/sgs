//
//  PreferencesManager.m
//  statslite
//
//  Created by Rone Loza on 10/04/17.
//  Copyright © 2017 Rone Loza. All rights reserved.
//

#import "PreferencesManager.h"
#import "Constants.h"
#import "MenuDetailItem.h"

@implementation PreferencesManager

+ (BOOL)existPreferencesForKey:(NSString *)key {
    
    NSUserDefaults *defaults= [NSUserDefaults standardUserDefaults];
    
    BOOL existPreferencesForKey = ([[[defaults dictionaryRepresentation] allKeys] containsObject:key]);

    return existPreferencesForKey;
}

+ (NSDictionary *)getDictionaryFromPlist:(NSString *)plist {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
    
    NSDictionary *plistDictionary = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    return plistDictionary;
}

+ (void)setPreferencesString:(NSString *)value forKey:(NSString *)key {
    
    if (value && key) {
    
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)setPreferencesBOOL:(BOOL)value forKey:(NSString *)key {
    
    if (key) {
        
        [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (BOOL)getPreferencesBOOLForKey:(NSString *)key {
    
    return (key ? [[NSUserDefaults standardUserDefaults] boolForKey:key] : NO);
}

+ (NSString *)getPreferencesStringForKey:(NSString *)key {
    
    NSString *value = (key ? [[NSUserDefaults standardUserDefaults] stringForKey:key] : nil);
    
    return value;
    
}

+ (void)setPreferencesDictionary:(NSDictionary *)value forKey:(NSString *)key {
    
    if (value && key) {
        
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSDictionary *)getPreferencesDictionaryForKey:(NSString *)key {
    
    NSDictionary *value = (key ? [[NSUserDefaults standardUserDefaults] dictionaryForKey:key] : nil);
    
    return value;
}

+ (NSArray *)getSelectedColumnsWithIsPortrait:(BOOL)isPortrait data:(NSArray *)data {
    
    NSArray *matches = nil;
    
    if ([PreferencesManager existPreferencesForKey:kPrefKeyHeaderOrientation]) {
        
        NSString *jsonDataString = [PreferencesManager getPreferencesStringForKey:kPrefKeyHeaderOrientation];
        
        NSData *jsonData = [jsonDataString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingAllowFragments) error:nil];
        
        matches = [dict valueForKey:(isPortrait ?  kPrefKeyHeaderOrientationPortrait : kPrefKeyHeaderOrientationLandscape)];
    }
    
    NSArray *cols = [data filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"methodName IN %@", matches]];
    
    return cols;
}

+ (void)setSelectedColumnsDefaultsWithItem:(MenuDetailItem *)item {
    
    if (![PreferencesManager existPreferencesForKey:kPrefKeyHeaderOrientation] && item.columns.count >= 5) {
        
        NSArray *portraits = [[item.columns valueForKey:@"methodName"] subarrayWithRange:NSMakeRange(0, [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? 3 : 5)] ;
        NSArray *landscapes = [[item.columns valueForKey:@"methodName"] subarrayWithRange:NSMakeRange(0, 5)] ;
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                              portraits, kPrefKeyHeaderOrientationPortrait,
                              landscapes, kPrefKeyHeaderOrientationLandscape, nil];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:(NSJSONWritingPrettyPrinted) error:nil];
        
        [PreferencesManager setPreferencesString:[[NSString alloc] initWithData:jsonData encoding:(NSUTF8StringEncoding)] forKey:kPrefKeyHeaderOrientation];
    }
}

+ (void)setSelectedColumnsWithIsPortrait:(BOOL)isPortrait data:(NSArray *)data {

    NSArray *selecteds = [data valueForKey:@"methodName"];
                          
    NSString *jsonDataString = [PreferencesManager getPreferencesStringForKey:kPrefKeyHeaderOrientation];
    
    NSData *jsonData = [jsonDataString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary *dict = [[NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingAllowFragments) error:nil] mutableCopy];
    
    [dict setValue:selecteds forKey:(isPortrait ?  kPrefKeyHeaderOrientationPortrait : kPrefKeyHeaderOrientationLandscape)];
    
    jsonData = [NSJSONSerialization dataWithJSONObject:dict options:(NSJSONWritingPrettyPrinted) error:nil];
    
    [PreferencesManager setPreferencesString:[[NSString alloc] initWithData:jsonData encoding:(NSUTF8StringEncoding)] forKey:kPrefKeyHeaderOrientation];
}

@end
