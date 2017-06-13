//
//  UIAlertManager.h
//  statslite
//
//  Created by rone shender loza aliaga on 4/14/17.
//  Copyright © 2017 eeeccom.elcomercio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertViewManager : NSObject

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles onDismiss:(void (^)(NSInteger buttonIndex))onDismiss;

+ (void)showAlertDismissHUDWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles onDismiss:(void (^)(NSInteger buttonIndex))onDismiss;

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles onDismiss:(void (^)(NSInteger buttonIndex))onDismiss completion:(void (^)(void))completion;

+ (void)showAlertDismissHUDWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles onDismiss:(void (^)(NSInteger buttonIndex))onDismiss completion:(void (^)(void))completion;

+ (void)progressHUDSetMaskBlack;
+ (void)progressHUDDismissWithCompletion:(void (^)(void))completion;

+ (void)progressHUShow;
@end
