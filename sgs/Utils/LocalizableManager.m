//
//  LocalizableManager.m
//  sgs
//
//  Created by Rone Loza on 4/21/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "LocalizableManager.h"
#import "PreferencesManager.h"
#import "Constants.h"

@implementation LocalizableManager

//var localized: String {
//    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    
//    var lang = "en"
//    
//    if(appDelegate.isGreek)
//    {
//        lang = "el"
//    }
//    let path = NSBundle.mainBundle().pathForResource(lang, ofType: "lproj")
//    let bundle = NSBundle(path: path!)
//    
//    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
//}

+ (NSString *)localizedString:(NSString *)key {
    
    NSString *localizedString = @"";
    
    if (key.length > 0) {
     
        NSString *lang = [[PreferencesManager getPreferencesStringForKey:kPrefsKeyLang] lowercaseString];
        
        NSBundle *bundle = ([lang isEqualToString:@"es"] ? [NSBundle mainBundle] :
                            [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"bundle"]]);
        
        localizedString = NSLocalizedStringFromTableInBundle(key, nil, bundle, @"");
    }
    
    return localizedString;
}

+ (NSLocale *)localizedLocale {
    
    NSString *lang = [[PreferencesManager getPreferencesStringForKey:kPrefsKeyLang] lowercaseString];
    
    NSLocale *locale = ([lang isEqualToString:@"es"] ? [NSLocale localeWithLocaleIdentifier:@"es_PE"] :
                        [NSLocale localeWithLocaleIdentifier:@"en_US"]);
    
    return locale;
}

@end
