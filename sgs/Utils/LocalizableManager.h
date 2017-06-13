//
//  LocalizableManager.h
//  sgs
//
//  Created by Rone Loza on 4/21/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalizableManager : NSObject

+ (NSString *)localizedString:(NSString *)key;
+ (NSLocale *)localizedLocale;
@end
