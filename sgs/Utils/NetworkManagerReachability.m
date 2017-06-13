//
//  NetworkManagerReachability.m
//  sgs
//
//  Created by Rone Loza on 5/11/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "NetworkManagerReachability.h"
#import "PreferencesManager.h"
#import "ReachabilityManager.h"
#import "Constants.h"
#import "UIAlertViewManager.h"
#import "LocalizableManager.h"
#import "BaseViewController.h"
#import "SettingsTableViewController.h"
#import "PreferencesManager.h"

@implementation NetworkManagerReachability

+ (BOOL)isUnvailableViaWWAN {
    
    BOOL useMobileData = [PreferencesManager getPreferencesBOOLForKey:kPrefUserUseMobileData];
    
    NetworkStatus remoteHostStatus = [[[[ReachabilityManager class] sharedManager] reachability] currentReachabilityStatus];
    
    //        NSError *error = [[NSError alloc] initWithDomain:kCustomNetworkErrors code:kErrorNotUnvailableWWANConnectedToInternet userInfo:nil];
    //        if (completion) completion(nil, error);
    
    return (remoteHostStatus == ReachableViaWWAN && !useMobileData);
}

+ (void)showAlertUnvailableViaWWAN {
    
    __weak id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
        
        __weak UITabBarController *tabVC = (UITabBarController *)appDelegate.window.rootViewController;
        
        if ([tabVC.selectedViewController isKindOfClass:[UINavigationController class]]) {
            
            __weak UINavigationController *nvc = (UINavigationController *)tabVC.selectedViewController;
            
            if ([nvc.topViewController isKindOfClass:[SettingsTableViewController class]]) {
                
//                __weak BaseViewController *bvc = (BaseViewController *)nvc.topViewController;
//                
//                [PreferencesManager setPreferencesBOOL:YES forKey:kPrefUserUseMobileData];
//                [bvc refreshBarButtonPressed:nil];
            }
            else {
                
                [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_unvailable_wwam"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_cancel_label"] otherButtonTitles:[[NSArray alloc] initWithObjects:[LocalizableManager localizedString:@"btn_enable_use_data_label"], nil] onDismiss:^(NSInteger buttonIndex) {
                    
                    if (buttonIndex == 1) {
                        
                        UIViewController *profileVC = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierProfileVC);
                        UIViewController *settingsVC = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierSettingsVC);
                        
                        if ([appDelegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
                            
                            __weak UITabBarController *tabVC = (UITabBarController *)appDelegate.window.rootViewController;
                            
                            [tabVC setSelectedIndex:3];
                            
                            if ([tabVC.selectedViewController isKindOfClass:[UINavigationController class]]) {
                                
                                __weak UINavigationController *nvc = (UINavigationController *)tabVC.selectedViewController;
                                nvc.viewControllers = [[NSArray alloc] initWithObjects:profileVC, settingsVC, nil];
                            }
                        }
                    }
                }];
            }
        }
    }

    
//    [UIAlertViewManager showAlertDismissHUDWithTitle:@"" message:[LocalizableManager localizedString:@"msg_unvailable_wwam"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_accept_label"] otherButtonTitles:[[NSArray alloc] initWithObjects:[LocalizableManager localizedString:@"btn_settings_label"], nil] onDismiss:^(NSInteger buttonIndex) {
//        
//        if (buttonIndex == 1) {
//            
//            UIViewController *vc = UIStoryboardInstantiateViewControllerWithIdentifier(kStoryboardMain, kStoryboardIdentifierSettingsVC);
//            
//            if ([appDelegate.window.rootViewController isKindOfClass:[UITabBarController class]]) {
//                
//                __weak UITabBarController *tabVC = (UITabBarController *)appDelegate.window.rootViewController;
//                
//                [(UINavigationController *)tabVC.selectedViewController pushViewController:vc animated:YES];
//            }
//        }
//    }];
}

+ (void)getListTermsPostDict:(NSDictionary *)postDict completion:(void (^)(VerifyUserItem *, NSError *))completion {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getListTermsPostDict:postDict completion:completion];
}

+ (void)acceptTermsPostDict:(NSDictionary *)postDict completion:(void(^)(VerifyUserItem *item, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super acceptTermsPostDict:postDict completion:completion];
}

+ (void)getIdiomsWithCompletion:(void(^)(NSArray *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getIdiomsWithCompletion:completion];
}

+ (void)getMenuWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getMenuWithPostDict:postDict completion:completion];
}

+ (void)getMenuDetailWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getMenuDetailWithPostDict:postDict completion:completion];
}

+ (void)getSettingsParamsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
   
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getSettingsParamsWithPostDict:postDict completion:completion];
}

+ (void)postUpdateSettingsParamsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSInteger responseCodeData, NSError *error))completion; {
   
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super postUpdateSettingsParamsWithPostDict:postDict completion:completion];
}

+ (void)getSocialWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getSocialWithPostDict:postDict completion:completion];
}

+ (void)getOfficesWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getOfficesWithPostDict:postDict completion:completion];
}

+ (void)getMenuDetailInfoWithPostDict:(NSDictionary *)postDict completion:(void(^)(DetailInfoItem *item, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getMenuDetailInfoWithPostDict:postDict completion:completion];
    
}

+ (void)getUserProfileWithPostDict:(NSDictionary *)postDict completion:(void(^)(UserProfileItem *item, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getUserProfileWithPostDict:postDict completion:completion];
}

+ (void)getAttachmentsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getAttachmentsWithPostDict:postDict completion:completion];
}

+ (void)getAttachWithPostDict:(NSDictionary *)postDict completion:(void(^)(AttachItem *data, NSError *error))completion; {
   
    BOOL useAttachWifi = [PreferencesManager getPreferencesBOOLForKey:kPrefUserUseAttachWifi];
    
    NetworkStatus remoteHostStatus = [[[[ReachabilityManager class] sharedManager] reachability] currentReachabilityStatus];
    
    if (remoteHostStatus == ReachableViaWWAN && useAttachWifi) {
        
        [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_unvailable_wwam_attach"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_accept_label"] otherButtonTitles:nil onDismiss:nil];
        
        if (completion) completion(nil, nil);
    }
    else if (remoteHostStatus == ReachableViaWWAN && !useAttachWifi) {
        
        [UIAlertViewManager showAlertWithTitle:@"" message:[LocalizableManager localizedString:@"msg_available_wwam_attach"] cancelButtonTitle:[LocalizableManager localizedString:@"btn_cancel_label"] otherButtonTitles:[[NSArray alloc] initWithObjects:[[LocalizableManager localizedString:@"btn_download_label"] capitalizedString], nil] onDismiss:^(NSInteger buttonIndex) {
            
            if (buttonIndex == 1) {
                
                [super getAttachWithPostDict:postDict completion:completion];
            }
            else {
                
                if (completion) completion(nil, nil);
            }
        }];
    }
    else {
        
        [super getAttachWithPostDict:postDict completion:completion];
    }
}

+ (void)getDirectoryWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getDirectoryWithPostDict:postDict completion:completion];
}

+ (void)getNotificationsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getNotificationsWithPostDict:postDict completion:completion];
}

+ (void)getNotificationsUnReadWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSString *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getNotificationsUnReadWithPostDict:postDict completion:completion];
}

+ (void)postNotificationUpdateWithPostDict:(NSDictionary *)postDict completion:(void(^)(NotificationItem *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super postNotificationUpdateWithPostDict:postDict completion:completion];
}

+ (void)getNotificationDetailWithPostDict:(NSDictionary *)postDict completion:(void(^)(NotificationDetailItem *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getNotificationDetailWithPostDict:postDict completion:completion];
}

+ (void)getNotificationAttachmentsWithPostDict:(NSDictionary *)postDict completion:(void(^)(NSArray *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getNotificationAttachmentsWithPostDict:postDict completion:completion];
}

+ (void)getNotificationAttachWithPostDict:(NSDictionary *)postDict completion:(void(^)(NotificationAttachItem *data, NSError *error))completion; {
    
    if ([[self class] isUnvailableViaWWAN]) {
        
        [[self class] showAlertUnvailableViaWWAN];
        
        return;
    }
    
    [super getNotificationAttachWithPostDict:postDict completion:completion];
}

@end
