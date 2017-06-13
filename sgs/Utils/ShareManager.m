//
//  ShareManager.m
//  sgs
//
//  Created by Rone Loza on 5/9/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import "ShareManager.h"
#import "UIAlertViewManager.h"
#import "NSString+Utils.h"
#import "LocalizableManager.h"
#import "SocialItem.h"
#import "PreferencesManager.h"
#import "NetworkManagerReachability.h"
#import "Constants.h"
#import "AttachItem.h"
#import "NotificationAttachItem.h"
#import "FileManager.h"

@implementation ShareManager

+ (void)openURLWithScheme:(NSString *)scheme parameters:(NSDictionary *)params {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:scheme]]) {
        
        NSString *paramBody = [NSString queryStringFromDictionary:params];
        
        NSString *sUrl = [[NSString alloc] initWithFormat:@"%@%@", scheme, (paramBody ? [@"?" stringByAppendingString:paramBody] : @"")];
        sUrl = [sUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sUrl]];
    }
    else {
        
        [UIAlertViewManager showAlertWithTitle:@"" message:[[LocalizableManager localizedString:@"msg_unable_open_app"] capitalizedString] cancelButtonTitle:[[LocalizableManager localizedString:@"btn_accept_label"] capitalizedString] otherButtonTitles:nil onDismiss:nil];
    }
}

+ (void)openURLWithScheme:(NSString *)scheme path:(NSString *)path parameters:(NSDictionary *)params {

    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:scheme]]) {
        
        NSString *paramBody = [NSString queryStringFromDictionary:params];
        
        NSString *sUrl = [[NSString alloc] initWithFormat:@"%@%@%@", scheme, (path.length > 0 ? path : @""), (paramBody ? [@"?" stringByAppendingString:paramBody] : @"")];
        sUrl = [sUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:sUrl]];
    }
    else {
        
        [UIAlertViewManager showAlertWithTitle:@"" message:[[LocalizableManager localizedString:@"msg_unable_open_app"] capitalizedString] cancelButtonTitle:[[LocalizableManager localizedString:@"btn_accept_label"] capitalizedString] otherButtonTitles:nil onDismiss:nil];
    }
}

+ (void)openURLWithItem:(SocialItem *)item {
    
    //whatapps
    if ([item.idredsocial isEqualToString:@"01"]) {
        
        NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                item.valor, kSchemeWhatsAppParam_abid,
                                item.nombreredsocial, kSchemeWhatsAppParam_text,
                                nil];
        
        [[self class] openURLWithScheme:[kSchemeWhatsApp stringByAppendingString:@"send"] parameters:params];
    }
    //email
    else if ([item.idredsocial isEqualToString:@"02"]) {
        
        NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"", kSchemeMailParam_subject,
                                @"", kSchemeMailParam_body, nil];
        
        NSString *scheme = [[NSString alloc] initWithFormat:@"%@%@", kSchemeMail, item.valor];
        
        [[self class] openURLWithScheme:scheme parameters:params];
    }
    //tel
    else if ([item.idredsocial isEqualToString:@"03"]) {
    
        NSString *scheme = [[NSString alloc] initWithFormat:@"%@%@", kSchemeTel, item.valor];
        
        [[self class] openURLWithScheme:scheme parameters:nil];
    }
    //facebook
    else if ([item.idredsocial isEqualToString:@"04"]) {
        
        NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                item.valor, kSchemeFacebookParam_text,
                                nil];
        
        [[self class] openURLWithScheme:kSchemeFacebook path:kSchemeFacebookPathPublishProfile parameters:params];
    }
}

+ (void)shareUrlFile:(NSURL *)urlFile inViewController:(__weak UIViewController *)viewController barButtonItem:(UIBarButtonItem *)barButtonItem completion:(void (^)(void))completion; {
    
    NSArray *activityItems = [[NSArray alloc] initWithObjects:urlFile, nil];
    
    //    DownloadActivity *da = [[DownloadActivity alloc] init];
    //    NSArray *acts = [[NSArray alloc] initWithObjects:da, nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    //if iPhone
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
//        [self presentViewController:controller animated:YES completion:nil];
        
         [viewController presentViewController:activityViewController animated:YES completion:completion];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:activityViewController];
        
        [popup presentPopoverFromBarButtonItem:barButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

+ (void)shareImage:(__weak  UIImage *)image inViewController:(__weak UIViewController *)viewController completion:(void (^)(void))completion; {
    
    NSArray *activityItems = [[NSArray alloc] initWithObjects:image, nil];
    
//    DownloadActivity *da = [[DownloadActivity alloc] init];
//    NSArray *acts = [[NSArray alloc] initWithObjects:da, nil];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [viewController presentViewController:controller animated:YES completion:completion];
}

+ (void)requestWithAttach:(AttachItem *)item completion:(void(^)(AttachItem *data, NSError *error))completion {
    
    NSURL *urlFile = [[FileManager class] appendPathComponentAtDocumentDirectory:[kFolderNameAttachments stringByAppendingPathComponent:item.nombreadjunto]];
    
    NSData *fileContent = [[FileManager class] readDataAtFilePath:urlFile.path];
    
//    NSString *stringContentsOfFile = [[NSString alloc] initWithData:fileContent encoding:(NSUTF8StringEncoding)];
    
    if (fileContent.length > 0) {
        
        item.fileContent = fileContent;
        if (completion) completion(item, nil);
    }
    else {
        
        NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
        NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
        NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
        
        NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      [lang uppercaseString], kUrlPathParamAttach_ididioma,
                                      [country uppercaseString], kUrlPathParamAttach_idpais,
                                      userId, kUrlPathParamAttach_idusuario,
                                      item.idmenu, kUrlPathParamAttach_idmenu,
                                      item.idmenudetalle, kUrlPathParamAttach_idmenudetalle,
                                      item.idadjunto, kUrlPathParamAttach_idadjunto,
                                      nil];
        
        [NetworkManagerReachability getAttachWithPostDict:postDataDict completion:^(AttachItem *data, NSError *error) {
            
            if (!error) {
                
                if (completion) completion(data, error);
            }
            else {
                
                if (error.code == kCFURLErrorUserCancelledAuthentication) {
                    
                    [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                        
                        if (!error) {
                            
                            [NetworkManagerReachability getAttachWithPostDict:postDataDict completion:^(AttachItem *data, NSError *error) {
                                
                                if (completion) completion(data, error);
                            }];
                        }
                        else {
                            
                            if (completion) completion(data, error);
                        }
                    }];
                }
                else {
                    
                    if (completion) completion(data, error);
                }
            }
        }];
    }
}

+ (void)requestWithNotificationAttach:(NotificationAttachItem *)item completion:(void(^)(NotificationAttachItem *data, NSError *error))completion {
    
    NSURL *urlFile = [[FileManager class] appendPathComponentAtDocumentDirectory:[kFolderNameAttachments stringByAppendingPathComponent:item.nombreadjunto]];
    
    NSData *fileContent = [[FileManager class] readDataAtFilePath:urlFile.path];
    
    //    NSString *stringContentsOfFile = [[NSString alloc] initWithData:fileContent encoding:(NSUTF8StringEncoding)];
    
    if (fileContent.length > 0) {
        
        item.fileContent = fileContent;
        if (completion) completion(item, nil);
    }
    else {
        
        NSString *country = [PreferencesManager getPreferencesStringForKey:kPrefsKeyCountry];
        NSString *userId = [PreferencesManager getPreferencesStringForKey:kPrefsKeyUserId];
        NSString *lang = [PreferencesManager getPreferencesStringForKey:kPrefsKeyLang];
        
        NSDictionary *postDataDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                      [lang uppercaseString], kUrlPathParamNotiAttach_ididioma,
                                      [country uppercaseString], kUrlPathParamNotiAttach_idpais,
                                      userId, kUrlPathParamNotiAttach_idusuario,
                                      item.idnotificacion, kUrlPathParamNotiAttach_idnotificacion,
                                      item.idadjunto, kUrlPathParamNotiAttach_idadjunto,
                                      nil];
        
        [NetworkManagerReachability getNotificationAttachWithPostDict:postDataDict completion:^(NotificationAttachItem *data, NSError *error) {
            
            if (!error) {
                
                if (completion) completion(data, error);
            }
            else {
                
                if (error.code == kCFURLErrorUserCancelledAuthentication) {
                    
                    [NetworkManagerReachability getTokenWithCompletion:^(NSString *newToken, NSError *error) {
                        
                        if (!error) {
                            
                            [NetworkManagerReachability getNotificationAttachWithPostDict:postDataDict completion:^(NotificationAttachItem *data, NSError *error) {
                                
                                if (completion) completion(data, error);
                            }];
                        }
                        else {
                            
                            if (completion) completion(data, error);
                        }
                    }];
                }
                else {
                    
                    if (completion) completion(data, error);
                }
            }
        }];
    }
}

@end
